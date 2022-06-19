import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_own_event/constants/colors.dart';
import 'package:flutter_own_event/navigationsBar/naviagationBar.dart';
// import 'package:flutter_stories/flutter_stories.dart';
// import 'package:story_view/story_view.dart';
import 'package:video_player/video_player.dart';

class TestVideoOrImage extends StatefulWidget {
  TestVideoOrImage({Key? key, required this.fileType, required this.url})
      : super(key: key);
  final bool fileType;
  final String url;

  @override
  _TestVideoOrImageState createState() => _TestVideoOrImageState();
}

class _TestVideoOrImageState extends State<TestVideoOrImage> {
  late bool isImageVideo;
  late VideoPlayerController _controller;
  // final storyController = StoryController();

  Future getVideoData() async {
    _controller = VideoPlayerController.network(
      widget.url.toString(),
    )..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        _controller.play();
        setState(() {});
      });
  }

  @override
  void dispose() {
    // storyController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    if (widget.fileType == true) {
      isImageVideo = true;
      setState(() {});
    } else {
      isImageVideo = false;
      setState(() {});
      getVideoData();
    }
    super.initState();
    print('image');
    print(widget.url);
  }

// WidgetsBinding.instance.addPostFrameCallback((_) {
//       // executes after build
//     });

  // List<StoryItem> storyItme = [
  //   StoryItem.pageVideo(
  //     '',
  //     controller: storyController,
  //   )
  // ];
  @override
  Widget build(BuildContext context) {
    return isImageVideo
        ? Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10.0, left: 2, right: 2),
                child: LinearProgressIndicator(
                  value: 1,
                  backgroundColor: PRIMARY_COLOR,
                ),
              ),
              Center(
                child: Image.network(
                  widget.url.toString(),
                ),
              ),
            ],
          )
        : _controller.value.isInitialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: LinearProgressIndicator(
                        value: 1,
                        backgroundColor: Colors.red,
                      ),
                    ),
                    VideoPlayer(
                      _controller,
                    ),
                  ],
                ),
              )
            : Container(
                child: Center(
                  child: CircularProgressIndicator(
                    color: Colors.red,
                  ),
                ),
              );
  }
}

  // storyItems: [
        //   // isImageVideo
        //   //     ? StoryItem.pageVideo(
        //   //         widget.url,
        //   //         controller: controller,
        //   //       )
        //   //     : StoryItem.pageImage(
        //   //         url: widget.url,
        //   //         controller: controller,
        //   //         shown: true,
        //   //       ),
        // ],
        //// return isImageVideo
//         ? Stack(
//             children: [
//               Center(
//                 child: Image.network(
//                   widget.url.toString(),
//                 ),
//               ),
//             ],
//           )
//         : _controller.value.isInitialized
//             ? AspectRatio(
//                 aspectRatio: _controller.value.aspectRatio,
//                 child: VideoPlayer(
//                   _controller,
//                 ),
//               )
//             : Container(
//                 child: Center(
//                   child: CircularProgressIndicator(
//                     color: Colors.red,
//                   ),
//                 ),
//               );
//   }
// }