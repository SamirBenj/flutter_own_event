import 'dart:io';

import 'package:camera/camera.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_own_event/screens/cameraView.dart';
import 'package:video_player/video_player.dart';

class CameraUi extends StatefulWidget {
  CameraUi({
    Key? key,
    required this.controller,
    required this.initController,
    required this.cameras,
    required this.iscameraFront,
  }) : super(key: key);

  CameraController controller;
  Future<void> initController;
  List<CameraDescription> cameras;
  bool iscameraFront;

  @override
  _CameraUiState createState() => _CameraUiState();
}

class _CameraUiState extends State<CameraUi> {
  var isCameraReady = false;
  bool isRecoring = false;
  // bool iscamerafront = true;
  bool flash = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomLeft,
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
          child: CameraPreview(widget.controller),
        ),
        Padding(
          padding: const EdgeInsets.all(25.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    flash = !flash;
                  });
                  flash
                      ? widget.controller.setFlashMode(FlashMode.torch)
                      : widget.controller.setFlashMode(FlashMode.off);
                },
                icon: Icon(
                  flash ? Icons.flash_on : Icons.flash_off,
                  color: Colors.red,
                  size: 28,
                ),
              ),
              GestureDetector(
                onLongPress: () async {
                  await widget.controller.startVideoRecording();
                  setState(() {
                    isRecoring = true;
                  });
                },
                onLongPressUp: () async {
                  XFile videopath =
                      await widget.controller.stopVideoRecording();
                  setState(() {
                    isRecoring = false;
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (builder) => CameraViewTest(
                        maVideo: videopath.path,
                      ),
                    ),
                  );
                  await FirebaseStorage.instance
                      .ref('video/test.mp4')
                      .putFile(File(videopath.path));
                },
                onTap: () async {
                  if (!isRecoring) {
                    print('hello');
                    XFile test = await widget.controller.takePicture();
                    setState(() {});
                    // File editedFile = await Navigator.of(context).push(
                    //   new MaterialPageRoute(
                    //     builder: (context) => StoryDesigner(
                    //       filePath: test.path,
                    //     ),
                    //   ),
                    // );
                    await FirebaseStorage.instance
                        .ref('nameOfUser/nameOfImage.jpg')
                        .putFile(
                          File(test.path),
                        );
                  }
                },
                child: IconButton(
                  // onPressed: () async {
                  //   // Navigator.push(
                  //   //     context,
                  //   //     MaterialPageRoute(
                  //   //         builder: (context) => DisplayPictureVideo(
                  //   //             monImage: imageFile.path.toString())));
                  //   // await db.collection('hello').add({
                  //   //   'imageData': imageFile.path.toString(),
                  //   // });
                  //   // File uploadFile = File(imageFile.path);
                  //   // await firebase_storage.FirebaseStorage.instance
                  //   //     .ref('uploads/hello.jpg')
                  //   //     .putFile(uploadFile);
                  // },
                  icon: Icon(
                    Icons.circle_outlined,
                    color: Colors.white,
                    size: 60,
                  ),
                  onPressed: () {},
                ),
              ),
              IconButton(
                onPressed: () async {
                  setState(() {
                    widget.iscameraFront = !widget.iscameraFront;
                  });
                  int cameraPos = widget.iscameraFront ? 0 : 1;
                  widget.controller = CameraController(
                      widget.cameras[cameraPos], ResolutionPreset.high);
                  widget.initController = widget.controller.initialize();
                },
                icon: Icon(
                  Icons.camera_front_rounded,
                  color: Colors.black,
                  size: 40,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
