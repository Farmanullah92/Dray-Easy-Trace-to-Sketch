import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:draw_easy/views/screens/camera/photo_preview_screen.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  List<CameraDescription>? cameras;
  CameraController? controller;
  bool isFlashOn = false;
  bool isRearCameraSelected = true;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  Future<void> _initCamera() async {
    try {
      cameras = await availableCameras();
      if (cameras == null || cameras!.isEmpty) {
        throw Exception('No cameras available');
      }
      _startCamera(
        cameras!.firstWhere(
          (camera) => camera.lensDirection == CameraLensDirection.back,
          orElse: () => cameras!.first,
        ),
      );
    } catch (e) {
      debugPrint('Camera initialization error: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Camera error: ${e.toString()}')),
        );
      }
    }
  }

  Future<void> _startCamera(CameraDescription cameraDescription) async {
    if (controller != null) {
      await controller!.dispose();
    }

    controller = CameraController(
      cameraDescription,
      ResolutionPreset.high,
      enableAudio: false,
    );

    try {
      await controller!.initialize();
      if (!mounted) return;
      setState(() {});
    } catch (e) {
      debugPrint('Camera controller error: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Camera error: ${e.toString()}')),
        );
      }
    }
  }

  Future<void> _toggleFlash() async {
    if (controller == null || !controller!.value.isInitialized) return;

    try {
      isFlashOn = !isFlashOn;
      await controller!.setFlashMode(
        isFlashOn ? FlashMode.torch : FlashMode.off,
      );
      if (mounted) setState(() {});
    } catch (e) {
      debugPrint('Flash toggle error: $e');
    }
  }

  Future<void> _switchCamera() async {
    if (cameras == null || cameras!.length < 2) return;

    isRearCameraSelected = !isRearCameraSelected;
    final newCamera = cameras!.firstWhere(
      (camera) =>
          isRearCameraSelected
              ? camera.lensDirection == CameraLensDirection.back
              : camera.lensDirection == CameraLensDirection.front,
      orElse: () => cameras!.first,
    );

    await _startCamera(newCamera);
  }

  Future<void> _capturePhoto() async {
    if (controller == null || !controller!.value.isInitialized) return;

    setState(() {
      isLoading = true;
    });

    try {
      final XFile photo = await controller!.takePicture();

      if (!mounted) return;

      // Navigate to preview screen after a short delay
      await Future.delayed(const Duration(milliseconds: 500));

      Navigator.push(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(
          builder:
              (context) =>
                  PhotoPreviewScreen(imagePath: photo.path, cameras: cameras!),
        ),
      );
    } catch (e) {
      debugPrint('Photo capture error: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to capture photo")),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: const BackButton(),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Stack(
        children: [
          if (controller != null && controller!.value.isInitialized)
            CameraPreview(controller!)
          else
            const Center(child: CircularProgressIndicator()),

          // Flash toggle button
          Positioned(
            bottom: 30,
            left: 30,
            child: IconButton(
              onPressed: _toggleFlash,
              icon: Icon(
                isFlashOn ? Icons.flash_on : Icons.flash_off,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),

          // Camera switch button
          Positioned(
            bottom: 30,
            right: 30,
            child: IconButton(
              onPressed: _switchCamera,
              icon: const Icon(
                Icons.cameraswitch,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),

          // Capture button
          if (controller != null && controller!.value.isInitialized)
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: FloatingActionButton(
                  onPressed: isLoading ? null : _capturePhoto,
                  backgroundColor: Colors.white,
                  child:
                      isLoading
                          ? const CircularProgressIndicator(color: Colors.black)
                          : const Icon(Icons.camera, color: Colors.black),
                ),
              ),
            ),

          // Loading overlay
          if (isLoading) const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}
