import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter_own_event/constants/colors.dart';
import 'package:flutter_own_event/screens/cameraView.dart';
import 'package:flutter_own_event/screens/displayPictureVideo.dart';

late List<CameraDescription> cameras;

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen>
    with WidgetsBindingObserver {
  late CameraController _controller;
  late Future<void> _initController;
  var isCameraReady = false;
  bool isRecoring = false;

  late XFile imageFile;
  bool iscamerafront = true;
  double transform = 0;
  bool flash = false;
  final db = FirebaseFirestore.instance;
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  @override
  void initState() {
    FirebaseFirestore.instance;
    super.initState();
    initCamera();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _controller = new CameraController(cameras[0], ResolutionPreset.medium);
    _controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  Widget cameraWidget(context) {
    var camera = _controller.value;
    return CameraPreview(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      // appBar: AppBar(),
      body: FutureBuilder<void>(
        future: _initController,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Stack(
              alignment: Alignment.bottomLeft,
              children: [
                Container(
                  color: PRIMARY_COLOR,
                  height: MediaQuery.of(context).size.height,
                  child: CameraPreview(_controller),
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
                              ? _controller.setFlashMode(FlashMode.torch)
                              : _controller.setFlashMode(FlashMode.off);
                        },
                        icon: Icon(
                          flash ? Icons.flash_on : Icons.flash_off,
                          color: Colors.red,
                          size: 28,
                        ),
                      ),
                      GestureDetector(
                        // onTap: () async {
                        //   print('hello');
                        //   if (!isRecoring) {
                        //     print('hello');
                        //     XFile test = await _controller.takePicture();
                        //     setState(() {});
                        //     // File editedFile = await Navigator.of(context).push(
                        //     //   new MaterialPageRoute(
                        //     //     builder: (context) => StoryDesigner(
                        //     //       filePath: test.path,
                        //     //     ),
                        //     //   ),
                        //     // );
                        //     await Navigator.push(
                        //       context,
                        //       MaterialPageRoute(
                        //         builder: (builder) => DisplayPictureVideo(
                        //           monImage: test.path,
                        //         ),
                        //       ),
                        //     );
                        //     // await FirebaseStorage.instance
                        //     //     .ref('nameOfUser/nameOfImage.jpg')
                        //     //     .putFile(
                        //     //       File(test.path),
                        //     //     );
                        //   }
                        // },
                        onLongPress: () async {
                          await _controller.startVideoRecording();
                          setState(() {
                            isRecoring = true;
                          });
                        },
                        onLongPressUp: () async {
                          XFile videopath =
                              await _controller.stopVideoRecording();
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
                          // await FirebaseStorage.instance
                          //     .ref('video/userid/')
                          //     .putFile(File(videopath.path));
                        },
                        child: IconButton(
                          onPressed: () async {
                            print('hello');
                            if (!isRecoring) {
                              print('hello');
                              XFile test = await _controller.takePicture();
                              setState(() {});

                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (builder) => DisplayPictureVideo(
                                    monImage: test.path,
                                  ),
                                ),
                              );
                            }
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => DisplayPictureVideo(
                            //             monImage: imageFile.path.toString())));
                            // await db.collection('hello').add({
                            //   'imageData': imageFile.path.toString(),
                            // });
                            // File uploadFile = File(imageFile.path);
                            // await firebase_storage.FirebaseStorage.instance
                            //     .ref('uploads/hello.jpg')
                            //     .putFile(uploadFile);
                          },
                          icon: Icon(
                            Icons.circle_outlined,
                            color: Colors.white,
                            size: 60,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          setState(() {
                            iscamerafront = !iscamerafront;
                          });
                          int cameraPos = iscamerafront ? 0 : 1;
                          _controller = CameraController(
                              cameras[cameraPos], ResolutionPreset.high);
                          _initController = _controller.initialize();
                        },
                        icon: Icon(
                          Icons.camera_front_rounded,
                          color: PRIMARY_COLOR,
                          size: 40,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Future<void> initCamera() async {
    cameras = await availableCameras();
    // final firstCamera = cameras.first;
    _controller = CameraController(
      cameras[0],
      ResolutionPreset.high,
    );
    _initController = _controller.initialize();
    if (!mounted) return;
    setState(() {
      isCameraReady = true;
    });
  }
}
