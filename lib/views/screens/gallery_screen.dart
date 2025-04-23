import 'package:draw_easy/views/screens/album_screen.dart';
import 'package:draw_easy/views/screens/asset_thumbnail.dart';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  List<AssetPathEntity> albums = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchAlbums();
  }

  Future<void> _fetchAlbums() async {
    final PermissionState ps = await PhotoManager.requestPermissionExtend();
    if (!mounted) return;

    if (ps.isAuth) {
      final List<AssetPathEntity> albumList =
          await PhotoManager.getAssetPathList(
            type: RequestType.image,
            filterOption: FilterOptionGroup(
              imageOption: const FilterOption(
                sizeConstraint: SizeConstraint(ignoreSize: true),
              ),
              orders: [
                const OrderOption(type: OrderOptionType.createDate, asc: false),
              ],
            ),
          );

      setState(() {
        albums = albumList;
        isLoading = false;
      });
    } else {
      PhotoManager.openSetting();
      setState(() => isLoading = false);
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
        title: const Text('Gallery'),
        backgroundColor: const Color(0xFFF4F7FA),
        elevation: 0,
      ),
      body:
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : albums.isEmpty
              ? const Center(child: Text('No albums found'))
              : ListView.builder(
                itemCount: albums.length,
                itemBuilder: (context, index) {
                  return _buildAlbumItem(albums[index]);
                },
              ),
    );
  }

  Widget _buildAlbumItem(AssetPathEntity album) {
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
                  child:
                      coverAsset == null
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
  }
}
