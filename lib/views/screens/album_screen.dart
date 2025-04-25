import 'package:draw_easy/views/screens/asset_thumbnail.dart';
import 'package:draw_easy/views/screens/camera/photo_preview_screen.dart';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:get/get.dart';
import '../../controllers/album_controller.dart';
import '../../widgets/app_dialog.dart';

class AlbumScreen extends StatefulWidget {
  final AssetPathEntity album;

  const AlbumScreen({super.key, required this.album});

  @override
  _AlbumScreenState createState() => _AlbumScreenState();
}

class _AlbumScreenState extends State<AlbumScreen> {
  final AlbumController _controller = Get.put(AlbumController());

  @override
  void initState() {
    super.initState();
    _controller.initializeCameras();
    _controller.fetchAssets(widget.album);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FA),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(widget.album.name),
        backgroundColor: const Color(0xFFF4F7FA),
        elevation: 0,
      ),
      body: GetBuilder<AlbumController>(
        builder: (controller) {
          if (controller.assets.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 2,
              mainAxisSpacing: 2,
            ),
            itemCount: controller.assets.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () async {
                  // Show the dialog when an image is selected
                  showDialog(
                    context: context,
                    builder: (_) {
                      return AppDialog(
                        title: 'Please Wait',
                        imagePath: 'assets/images/hind.png',
                        message: 'Wait.....',
                      );
                    },
                  );

                  // Add a 2-second delay before navigating to the preview screen
                  await Future.delayed(const Duration(seconds: 2));

                  // Load the image file after the delay
                  final file = await controller.assets[index].file;
                  if (file != null && controller.cameras.isNotEmpty) {
                    Navigator.pop(context); // Close the dialog after processing
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (_) => PhotoPreviewScreen(
                              imagePath: file.path,
                              cameras: controller.cameras,
                            ),
                      ),
                    );
                  } else {
                    Navigator.pop(context); // Close the dialog on error
                    print("No cameras available or file is null");
                  }
                },
                child: AssetThumbnail(asset: controller.assets[index]),
              );
            },
          );
        },
      ),
    );
  }
}
