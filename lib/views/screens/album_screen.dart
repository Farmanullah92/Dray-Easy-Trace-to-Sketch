import 'package:draw_easy/views/screens/asset_thumbnail.dart';
import 'package:draw_easy/views/screens/camera/photo_preview_screen.dart';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:camera/camera.dart';

class AlbumScreen extends StatefulWidget {
  final AssetPathEntity album;

  const AlbumScreen({super.key, required this.album});

  @override
  _AlbumScreenState createState() => _AlbumScreenState();
}

class _AlbumScreenState extends State<AlbumScreen> {
  late List<CameraDescription> cameras;

  @override
  void initState() {
    super.initState();
    _initializeCameras();
  }

  Future<void> _initializeCameras() async {
    try {
      cameras = await availableCameras();
      setState(() {});
    } catch (e) {
      print("Error initializing cameras: $e");
    }
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
      body: FutureBuilder<int>(
        future: widget.album.assetCountAsync,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final int assetCount = snapshot.data!;

          return FutureBuilder<List<AssetEntity>>(
            future: widget.album.getAssetListRange(start: 0, end: assetCount),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              final List<AssetEntity> assets = snapshot.data!;

              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 2,
                ),
                itemCount: assets.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () async {
                      final file = await assets[index].file;
                      if (file != null && cameras.isNotEmpty) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (_) => PhotoPreviewScreen(
                                  imagePath: file.path,
                                  cameras: cameras,
                                ),
                          ),
                        );
                      } else {
                        print("No cameras available or file is null");
                      }
                    },
                    child: AssetThumbnail(asset: assets[index]),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
