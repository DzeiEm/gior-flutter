import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:gior/db/gallery_image_db.dart';
import 'package:gior/model/image_mo.dart';

class ImagesProvider with ChangeNotifier {
  List<ImageMo> _images = [];

  List<ImageMo> get images {
    return _images;
  }

  void addImage(File image, String title) {
    final newImage = ImageMo(
      id: DateTime.now().toIso8601String(),
      image: image,
      title: title,
    );
    _images.add(newImage);
    print(_images);
    notifyListeners();
    GalleryImageDB.insert('gallery_images', {
      'id': newImage.id,
      'title': newImage.title,
      'image': newImage.image.path
    });
  }

  Future<void> fetchAndSetGalleryImages() async {
    final dataList = await GalleryImageDB.fetchData('gallery_images');
    _images = dataList
        .map((image) => ImageMo(
              id: image['id'],
              title: image['title'],
              image: File(image['image']),
            ))
        .toList();
    notifyListeners();
  }
}
