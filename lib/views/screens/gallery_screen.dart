import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';
import '../../controllers/gallery_controller.dart';
import 'album_screen.dart';
import 'asset_thumbnail.dart';

class GalleryScreen extends StatelessWidget {
  const GalleryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GalleryController controller = Get.put(GalleryController());

    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FA),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('Gallery'),
        backgroundColor: const Color(0xFFF4F7FA),
        elevation: 0,
      ),
      body: Obx(() {
        return controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : controller.albums.isEmpty
            ? const Center(child: Text('No albums found'))
            : ListView.builder(
          itemCount: controller.albums.length,
          itemBuilder: (context, index) {
            final album = controller.albums[index];

            return FutureBuilder<int>(
              future: album.assetCountAsync,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const ListTile(
                    leading: CircleAvatar(child: Icon(Icons.photo_library)),
                    title: Text('Loading...'),
                  );
                }

                final int assetCount = snapshot.data!;

                return FutureBuilder<AssetEntity?>(
                  future: album
                      .getAssetListRange(start: 0, end: 1)
                      .then((list) => list.isEmpty ? null : list[0]),
                  builder: (context, snapshot) {
                    final AssetEntity? coverAsset = snapshot.data;

                    return ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: SizedBox(
                          width: 50,
                          height: 50,
                          child: coverAsset == null
                              ? const Icon(Icons.photo_library)
                              : AssetThumbnail(asset: coverAsset),
                        ),
                      ),
                      title: Text(album.name),
                      subtitle: Text('$assetCount photos'),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AlbumScreen(album: album),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            );
          },
        );
      }),
    );
  }
}
