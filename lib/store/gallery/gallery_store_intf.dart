import 'package:photo_manager/photo_manager.dart';

abstract class GalleryStore {
  Future<void> initGallery();
  Future<void> changeGallery(AssetPathEntity gallery);
  void changeImage(AssetEntity image);
  Future<void> refreshGalleryList();
  Future<void> refreshImages();
  Future<void> loadMoreImages();
  void dispose();
}
