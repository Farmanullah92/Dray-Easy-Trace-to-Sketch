import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';

class GalleryController extends GetxController {
  var albums = <AssetPathEntity>[];
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    _fetchAlbums();
  }

  Future<void> _fetchAlbums() async {
    final PermissionState ps = await PhotoManager.requestPermissionExtend();

    // We check if Get.context is valid to prevent potential issues with unmounted context.
    if (Get.context == null) return;

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

      albums = albumList;
      isLoading.value = false;
    } else {
      PhotoManager.openSetting();
      isLoading.value = false;
    }
  }
}
