import 'package:get/get.dart';
import 'package:camera/camera.dart';
import 'package:photo_manager/photo_manager.dart';

class AlbumController extends GetxController {
  var cameras = <CameraDescription>[];
  var assets = <AssetEntity>[];

  // Method to initialize the cameras
  Future<void> initializeCameras() async {
    try {
      cameras = await availableCameras();
      update(); // This will notify listeners to update the UI
    } catch (e) {
      // ignore: avoid_print
      print("Error initializing cameras: $e");
    }
  }

  // Method to fetch assets
  Future<void> fetchAssets(AssetPathEntity album) async {
    try {
      final int assetCount = await album.assetCountAsync;
      assets = await album.getAssetListRange(start: 0, end: assetCount);
      update();
    } catch (e) {
      // ignore: avoid_print
      print("Error fetching assets: $e");
    }
  }
}
