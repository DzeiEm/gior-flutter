import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:gior/db/profile_image_dab.dart';

class ProfileImagePr with ChangeNotifier {
  final File _image = File(''); 

  void addProfileImage(File image) {
    final profileIm = image;

    ProfileImageDb.insert('profile_image', {
      'profImage': profileIm,
    });
  }

  Future<void> fetchProfileImage() async {
    final image = await ProfileImageDb.fetchUserProfileImage('profile_image');
    
    
  }
}
