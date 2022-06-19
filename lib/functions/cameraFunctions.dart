import 'dart:io';

import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class CameraHelpers {
  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance.currentUser;
  final firebaseAuth = FirebaseAuth.instance;
  Future<void> testInit() async {
    print('hello from CameraHelpers');
  }

  Future<void> initCamera(
    cameras,
    _controller,
    _initController,
    mounted,
    isCameraReady,
  ) async {
    cameras = await availableCameras();
    // final firstCamera = cameras.first;
    _controller = CameraController(
      cameras[0],
      ResolutionPreset.veryHigh,
    );
    _initController = _controller.initialize();
    if (!mounted) return;
    isCameraReady = true;
    return isCameraReady;
    // isCameraReady = true;
  }

//   Future addVideo(String maVideo) async {
//     bool done;

//     String urlImage;
//               File videoFile = File(maVideo);
//               String videoPath = basename(videoFile.path);
//               Reference firebaseStorageRef = FirebaseStorage.instance
//                   .ref('Users')
//                   .child(email.toString())
//                   .child('Story')
//                   .child(videoPath);
//               UploadTask uploadTask =
//                   firebaseStorageRef.putFile(File(maVideo));
//               await uploadTask.whenComplete(
//                 () async {
//                   urlImage = await uploadTask.snapshot.ref.getDownloadURL();
//                   print(urlImage);
//                   FirebaseFirestore.instance
//                       .collection('Users')
//                       .doc(userId)
//                       .collection('story')
//                       .add({
//                     "username": FirebaseAuth.instance.currentUser!.displayName.toString(),
//                     "image": false,
//                     "url": urlImage,
//                   });
//                 }
//                 return done;
// }

}
