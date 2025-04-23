import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';
import 'package:draw_easy/widgets/action_buttons.dart';
import 'package:draw_easy/widgets/control_buttons.dart';
import 'package:draw_easy/widgets/image_processor.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter/rendering.dart';

class PhotoPreviewScreen extends StatefulWidget {
  final String imagePath;
  final List<CameraDescription> cameras;

  const PhotoPreviewScreen({
    super.key,
    required this.imagePath,
    required this.cameras,
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

  final GlobalKey _globalKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _originalImageFile = File(widget.imagePath);
    _loadOriginalImage();
    _initCamera();
  }

  Future<void> _loadOriginalImage() async {
    _originalImageBytes = await _originalImageFile.readAsBytes();
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

      _cameraController = CameraController(backCamera, ResolutionPreset.high);
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
    if (_originalImageBytes == null) return;

    try {
      final processedBytes = await ImageProcessor.processImage(
        _originalImageBytes!,
        _edgeLevel,
      );

      if (mounted) {
        setState(() {
          _processedImageBytes = processedBytes;
        });
      }
    } catch (e) {
      debugPrint('Image processing error: $e');
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
      // Capture the full screen, including camera preview and UI
      RenderRepaintBoundary boundary =
          _globalKey.currentContext!.findRenderObject()
              as RenderRepaintBoundary;
      var image = await boundary.toImage(
        pixelRatio: 3.0,
      ); // Increase pixel ratio for higher quality
      image.toByteData(format: ImageByteFormat.png).then((byteData) {
        final buffer = byteData!.buffer.asUint8List();
        setState(() {
          _capturedImage = XFile.fromData(buffer);
          _originalImageBytes = buffer;
          _processedImageBytes = null;
          _showOriginalImage = true;
          _edgeLevel = 0.0;
        });
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
    final imageSize =
        _isFullScreen
            ? Size(screenSize.width, screenSize.height)
            : Size(300, 300 * _aspectRatios[_currentAspectRatio]!);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          if (!_isFullScreen && _isCameraInitialized && _showCameraBackground)
            Positioned.fill(
              child: Opacity(
                opacity: 0.5,
                child: CameraPreview(_cameraController),
              ),
            ),
          if (_isFullScreen && _displayImageBytes != null)
            Image.memory(
              _displayImageBytes!,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
          if (!_isFullScreen && _displayImageBytes != null)
            Positioned(
              top: 100,
              left: 0,
              right: 0,
              child: Center(
                child: Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.rotationY(_isFlipped ? pi : 0),
                  child: SizedBox(
                    height: imageSize.height,
                    width: imageSize.width,
                    child: Image.memory(
                      _displayImageBytes!,
                      fit: BoxFit.contain,
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
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Edge Level',
                    style: TextStyle(color: Colors.white),
                  ),
                  Expanded(
                    child: Slider(
                      value: _edgeLevel,
                      min: 0.0,
                      max: 1.0,
                      activeColor: Colors.white,
                      inactiveColor: Colors.grey,
                      onChanged:
                          _isLocked
                              ? null
                              : (value) async {
                                setState(() => _edgeLevel = value);
                                await _applyEdgeFilter();
                              },
                    ),
                  ),
                ],
              ),
            ),
          if (!_isFullScreen)
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Transparency',
                    style: TextStyle(color: Colors.white),
                  ),
                  Expanded(
                    child: Slider(
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
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
