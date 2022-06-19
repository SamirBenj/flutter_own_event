import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_own_event/constants/colors.dart';
import 'package:flutter_own_event/navigationsBar/naviagationBar.dart';
import 'package:flutter_own_event/screens/displayPictureVideo.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:path/path.dart';
import 'package:video_player/video_player.dart';

class CameraViewTest extends StatefulWidget {
  CameraViewTest({Key? key, required this.maVideo}) : super(key: key);
  final String maVideo;
  @override
  _CameraViewTestState createState() => _CameraViewTestState();
}

class _CameraViewTestState extends State<CameraViewTest> {
  late VideoPlayerController _controller;
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
    _controller = VideoPlayerController.file(
      File(
        widget.maVideo,
      ),
    )..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {
          _controller.pause();
        });
      });
  }

  Future getFuture() {
    return Future(() async {
      await Future.delayed(Duration(seconds: 5));
      return 'Hello, Future Progress Dialog!';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 150,
            child: _controller.value.isInitialized
                ? AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  )
                : Container(
                    child: Text('wait for',
                        style: TextStyle(
                          color: Colors.red,
                        )),
                  ),
          ),
          GestureDetector(
            onTap: () async {
              String urlImage;
              File videoFile = File(widget.maVideo);
              String videoPath = basename(videoFile.path);
              Reference firebaseStorageRef = FirebaseStorage.instance
                  .ref('Users')
                  .child(email.toString())
                  .child('Story')
                  .child(videoPath);
              UploadTask uploadTask =
                  firebaseStorageRef.putFile(File(widget.maVideo));
              await uploadTask.whenComplete(
                () async {
                  urlImage = await uploadTask.snapshot.ref.getDownloadURL();
                  print(urlImage);
                  FirebaseFirestore.instance
                      .collection('Users')
                      .doc(userId)
                      .collection('story')
                      .add({
                    "username": username,
                    "image": false,
                    "url": urlImage,
                  }).then((value) async {
                    await showDialog(
                      context: context,
                      builder: (context) => FutureProgressDialog(
                        getFuture(),
                        message: Text('Publication en cours'),
                      ),
                    );
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NavigationBottomBar(),
                      ),
                    );
                  });
                },
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(17),
                    decoration: BoxDecoration(
                      color: PRIMARY_COLOR,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Icon(
                      Icons.send,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _controller.value.isPlaying
                ? _controller.pause()
                : _controller.play();
          });
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }
}
