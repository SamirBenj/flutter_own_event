import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_own_event/constants/colors.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter_own_event/navigationsBar/naviagationBar.dart';
import 'package:flutter_own_event/screens/cameraScreen.dart';
import 'package:flutter_own_event/screens/homepage.dart';
import 'package:flutter_own_event/screens/splashScreen.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:image_painter/image_painter.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DisplayPictureVideo extends StatefulWidget {
  DisplayPictureVideo({Key? key, required this.monImage}) : super(key: key);
  final String monImage;
  @override
  _DisplayPictureVideoState createState() => _DisplayPictureVideoState();
}

//afffiche seulement image
class _DisplayPictureVideoState extends State<DisplayPictureVideo> {
  final _imageKey = GlobalKey<ImagePainterState>();

  final db = FirebaseStorage.instance;
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  late String email;
  late String userId;
  late String username;
  @override
  void initState() {
    FirebaseFirestore.instance;
    // TODO: implement initState
    email = FirebaseAuth.instance.currentUser!.email.toString();
    userId = FirebaseAuth.instance.currentUser!.uid;
    username = FirebaseAuth.instance.currentUser!.displayName.toString();
    super.initState();
  }

  getSpData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // sharedPreferences.getString('key')
  }

  Future getFuture() {
    return Future(() async {
      await Future.delayed(const Duration(seconds: 5));
      return 'Hello, Future Progress Dialog!';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Container(
                height: MediaQuery.of(context).size.height - 10,
                child: ImagePainter.file(File(widget.monImage), key: _imageKey),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // GestureDetector(
                    //   onTap: () => {
                    //     Navigator.pushAndRemoveUntil(
                    //         context,
                    //         MaterialPageRoute(
                    //           builder: (context) => MyHomePage(),
                    //         ),
                    //         (route) => false)
                    //   },
                    //   child: Icon(
                    //     Icons.close,
                    //     size: 40,
                    //     color: Colors.black,
                    //   ),
                    // ),
                    // Icon(
                    //   Icons.edit,
                    //   size: 40,
                    //   color: Colors.black,
                    // ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: CircleAvatar(
              backgroundColor: PRIMARY_COLOR,
              radius: 30,
              child: IconButton(
                padding: EdgeInsets.only(
                  left: 3,
                ),
                onPressed: () async {
                  try {
                    File imageFile = File(widget.monImage);
                    final imagePaint =
                        await _imageKey.currentState?.exportImage();
                    print(imagePaint.toString());
                    // await FirebaseStorage.instance
                    //     .ref('test')
                    //     .child('Image')
                    //     .putData(imagePaint as Uint8List);
                    String urlImage;
                    String imagePath = basename(imageFile.path);
                    Reference firebaseStorageRef = FirebaseStorage.instance
                        .ref('Users')
                        .child(email.toString())
                        .child('Story')
                        .child(imagePath);
                    UploadTask uploadTask =
                        firebaseStorageRef.putData(imagePaint as Uint8List);
                    await uploadTask.whenComplete(() async {
                      urlImage = await uploadTask.snapshot.ref.getDownloadURL();
                      print(urlImage);
                      FirebaseFirestore.instance
                          .collection('Users')
                          .doc(userId)
                          .collection('story')
                          .add({
                        "image": true,
                        "url": urlImage,
                        "username": username,
                      });
                      FirebaseFirestore.instance
                          .collection('Story')
                          .doc(userId)
                          .collection('video')
                          .add({
                        "username": username,
                        "image": true,
                        "url": urlImage,
                      }).then((value) async {
                        await showDialog(
                            context: context,
                            builder: (context) => FutureProgressDialog(
                                  getFuture(),
                                  message: Text('Publication en cours'),
                                ));
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NavigationBottomBar(),
                          ),
                        );
                      });
                    });
                  } catch (e) {
                    print('error uploading');
                    print(e);
                  }
                },
                icon: Icon(
                  Icons.send,
                  size: 30,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
