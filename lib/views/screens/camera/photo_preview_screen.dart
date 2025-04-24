import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:ui';
import 'package:draw_easy/widgets/action_buttons.dart';
import 'package:draw_easy/widgets/control_buttons.dart';
import 'package:draw_easy/widgets/image_processor.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

class PhotoPreviewScreen extends StatefulWidget {
  final String imagePath;
  final List<CameraDescription> cameras;
  final bool isAssetImage;

  const PhotoPreviewScreen({
    super.key,
    required this.imagePath,
    required this.cameras,
    this.isAssetImage = false,
  });

  @override
  State<PhotoPreviewScreen> createState() => _PhotoPreviewScreenState();
}

class _PhotoPreviewScreenState extends State<PhotoPreviewScreen> {
  double _edgeLevel = 0.0;
  double _transparency = 0.0;
  bool _isFlashOn = false;
  bool _isLocked = false;
  bool _isFlipped = false;
  String _currentAspectRatio = '3:3';
  bool _isFullScreen = false;
  late CameraController _cameraController;
  bool _isCameraInitialized = false;
  bool _showCameraBackground = true;
  bool _isRecording = false;
  bool _showOriginalImage = true;
  XFile? _capturedImage;

  final Map<String, double> _aspectRatios = {
    '3:3': 1.0,
    '4:5': 4 / 5,
    '5:6': 5 / 6,
    '6:7': 6 / 7,
  };

  late File _originalImageFile;
  Uint8List? _processedImageBytes;
  Uint8List? _originalImageBytes;
  bool _isProcessing = false;

  final GlobalKey _globalKey = GlobalKey();
  final _debouncer = _Debouncer(milliseconds: 300);

  @override
  void initState() {
    super.initState();
    if (!widget.isAssetImage) {
      _originalImageFile = File(widget.imagePath);
    }
    _loadOriginalImage();
    _initCamera();
  }

  Future<void> _loadOriginalImage() async {
    if (widget.isAssetImage) {
      final byteData = await rootBundle.load(widget.imagePath);
      _originalImageBytes = byteData.buffer.asUint8List();
    } else {
      _originalImageBytes = await _originalImageFile.readAsBytes();
    }

    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _initCamera() async {
    if (widget.cameras.isEmpty) {
      setState(() => _showCameraBackground = false);
      return;
    }

    try {
      final backCamera = widget.cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.back,
        orElse: () => widget.cameras.first,
      );

      _cameraController = CameraController(backCamera, ResolutionPreset.medium);
      await _cameraController.initialize();
      if (mounted) {
        setState(() => _isCameraInitialized = true);
      }
    } catch (e) {
      debugPrint('Camera initialization error: $e');
      setState(() => _showCameraBackground = false);
    }
  }

  Future<void> _applyEdgeFilter() async {
    if (_originalImageBytes == null || _isProcessing) return;

    _isProcessing = true;
    if (mounted) setState(() {});

    try {
      final processedBytes = await ImageProcessor.processImage(
        _originalImageBytes!,
        _edgeLevel,
      );

      if (mounted) {
        setState(() {
          _processedImageBytes = processedBytes;
          _isProcessing = false;
        });
      }
    } catch (e) {
      debugPrint('Image processing error: $e');
      if (mounted) {
        setState(() => _isProcessing = false);
      }
    }
  }

  void _toggleFlash() {
    if (!_isCameraInitialized) return;
    setState(() => _isFlashOn = !_isFlashOn);
    _cameraController.setFlashMode(
      _isFlashOn ? FlashMode.torch : FlashMode.off,
    );
  }

  void _toggleLock() => setState(() => _isLocked = !_isLocked);

  void _flipImage() => setState(() => _isFlipped = !_isFlipped);

  void _changeAspectRatio() {
    final ratios = _aspectRatios.keys.toList();
    final currentIndex = ratios.indexOf(_currentAspectRatio);
    final nextIndex = (currentIndex + 1) % ratios.length;
    setState(() => _currentAspectRatio = ratios[nextIndex]);
  }

  void _toggleFullScreen() => setState(() => _isFullScreen = !_isFullScreen);

  Future<void> _captureImage() async {
    try {
      RenderRepaintBoundary boundary =
          _globalKey.currentContext!.findRenderObject()
              as RenderRepaintBoundary;
      var image = await boundary.toImage(pixelRatio: 2.0);
      var byteData = await image.toByteData(format: ImageByteFormat.png);
      if (byteData == null) return;

      final buffer = byteData.buffer.asUint8List();
      setState(() {
        _capturedImage = XFile.fromData(buffer);
        _originalImageBytes = buffer;
        _processedImageBytes = null;
        _showOriginalImage = true;
        _edgeLevel = 0.0;
      });
    } catch (e) {
      debugPrint('Error capturing image: $e');
    }
  }

  Future<void> _toggleRecording() async {
    if (!_isCameraInitialized) return;

    setState(() => _isRecording = !_isRecording);

    try {
      if (_isRecording) {
        await _cameraController.startVideoRecording();
      } else {
        final video = await _cameraController.stopVideoRecording();
        debugPrint('Video saved to ${video.path}');
      }
    } catch (e) {
      debugPrint('Error recording video: $e');
      setState(() => _isRecording = false);
    }
  }

  void _toggleOriginalImage() {
    setState(() => _showOriginalImage = !_showOriginalImage);
  }

  @override
  void dispose() {
    _cameraController.dispose();
    _debouncer.cancel();
    super.dispose();
  }

  Uint8List? get _displayImageBytes {
    if (_showOriginalImage) {
      return _originalImageBytes;
    } else {
      return _processedImageBytes;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final aspectRatioValue = _aspectRatios[_currentAspectRatio] ?? 1.0;
    final imageWidth = min(screenSize.width * 0.9, 300);
    final imageHeight = imageWidth * aspectRatioValue;

    return Scaffold(
      backgroundColor: Colors.black,
      body: RepaintBoundary(
        key: _globalKey,
        child: Stack(
          children: [
            if (!_isFullScreen && _isCameraInitialized && _showCameraBackground)
              Positioned.fill(
                child: Opacity(
                  opacity: 0.5,
                  child: CameraPreview(_cameraController),
                ),
              ),

            if (_isFullScreen && _displayImageBytes != null)
              Center(
                child: InteractiveViewer(
                  panEnabled: false,
                  minScale: 1.0,
                  maxScale: 3.0,
                  child: Image.memory(
                    _displayImageBytes!,
                    fit: BoxFit.contain,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
              ),

            if (!_isFullScreen && _displayImageBytes != null)
              Positioned(
                top: (screenSize.height - imageHeight) / 3,
                left: (screenSize.width - imageWidth) / 2,
                child: Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.rotationY(_isFlipped ? pi : 0),
                  child: Container(
                    width: 200,
                    height: imageHeight,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.memory(
                        _displayImageBytes!,
                        fit: BoxFit.cover,
                        color: Color.fromRGBO(255, 255, 255, 1 - _transparency),
                        colorBlendMode: BlendMode.modulate,
                      ),
                    ),
                  ),
                ),
              ),

            if (!_isFullScreen)
              Positioned(
                top: 40,
                left: 0,
                right: 0,
                child: SafeArea(
                  child: ControlButtons(
                    onBackPressed: () => Navigator.pop(context),
                    onChangeAspectRatio: _changeAspectRatio,
                    onFlipImage: _flipImage,
                    onToggleFlash: _toggleFlash,
                    onToggleLock: _toggleLock,
                    isFlashOn: _isFlashOn,
                    isLocked: _isLocked,
                  ),
                ),
              ),

            if (!_isFullScreen)
              Positioned(
                bottom: 220,
                left: 10,
                child: IconButton(
                  onPressed: _toggleFullScreen,
                  icon: const Icon(
                    Icons.fullscreen,
                    size: 50,
                    color: Colors.white,
                  ),
                ),
              ),

            if (!_isFullScreen)
              Positioned(
                bottom: 160,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ActionButtons(
                    onCapture: _captureImage,
                    onConvert: _toggleOriginalImage,
                    onRecord: _toggleRecording,
                    isRecording: _isRecording,
                  ),
                ),
              ),

            if (!_isFullScreen)
              Positioned(
                bottom: 80,
                left: 20,
                right: 20,
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Text(
                          'Edge Level',
                          style: TextStyle(color: Colors.white),
                        ),
                        if (_isProcessing)
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            ),
                          ),
                      ],
                    ),
                    Slider(
                      value: _edgeLevel,
                      min: 0.0,
                      max: 1.0,
                      activeColor: Colors.white,
                      inactiveColor: Colors.grey,
                      onChanged:
                          _isLocked
                              ? null
                              : (value) {
                                setState(() => _edgeLevel = value);
                                _debouncer.run(_applyEdgeFilter);
                              },
                    ),
                  ],
                ),
              ),

            if (!_isFullScreen)
              Positioned(
                bottom: 20,
                left: 20,
                right: 20,
                child: Column(
                  children: [
                    const Text(
                      'Transparency',
                      style: TextStyle(color: Colors.white),
                    ),
                    Slider(
                      value: _transparency,
                      min: 0.0,
                      max: 1.0,
                      activeColor: Colors.white,
                      inactiveColor: Colors.grey,
                      onChanged:
                          _isLocked
                              ? null
                              : (value) =>
                                  setState(() => _transparency = value),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _Debouncer {
  final int milliseconds;
  VoidCallback? _action;
  Timer? _timer;

  _Debouncer({required this.milliseconds});

  void run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }

  void cancel() {
    _timer?.cancel();
  }
}
