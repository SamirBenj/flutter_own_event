import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_own_event/navigationsBar/naviagationBar.dart';
import 'package:flutter_own_event/screens/WelcomeScreen.dart';
import 'package:flutter_own_event/screens/homepage.dart';
import 'package:flutter_own_event/screens/splashScreen.dart';
import 'package:flutter_own_event/widgets/testVideoOrImage.dart';

import '../constants/colors.dart';

class PageViewStory extends StatefulWidget {
  PageViewStory({Key? key, required this.userid, required this.username})
      : super(key: key);
  final String userid;
  final String username;
  @override
  _PageViewStoryState createState() => _PageViewStoryState();
}

class _PageViewStoryState extends State<PageViewStory> {
  late PageController _pageController = PageController(initialPage: 0);
  Future getData() async {
    return await FirebaseFirestore.instance.collection('video').snapshots();
  }

  final _momentDuration = const Duration(microseconds: 1000);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('Users')
                .doc(widget.userid)
                .collection('story')
                .snapshots(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.data?.size == 0) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        '🙁 pas de Story',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        NavigationBottomBar()));
                          },
                          child: Text('Home'))
                    ],
                  ),
                );
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return PageView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: NeverScrollableScrollPhysics(),
                    controller: _pageController,
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (BuildContext context, index) {
                      bool fileType = snapshot.data.docs[index]['image'];
                      String url = snapshot.data.docs[index]['url'];
                      return GestureDetector(
                        onTapDown: (value) {
                          // print(value);
                          // print(_pageController.page);
                          // double nextPage =
                          //     _pageController.page!.toDouble() - 1.0;
                          // _pageController.animateTo(index.toDouble() + 1.0,
                          //     duration: Duration(seconds: 2), curve: Curves.ease);
                          //NEEDED BEFORED
                          _pageController.jumpToPage(index + 1);
                          if (index == snapshot.data.docs.length - 1) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NavigationBottomBar(),
                              ),
                            );
                          }
                          //END NEEDED BDEFORE//
                          // print(snapshot.data.docs.length);
                          // setState(() {});
                        },
                        child: TestVideoOrImage(
                          fileType: fileType,
                          url: url,
                        ),
                      );
                    });
              }
            }),
      ),
    );
  }
}


//backup

// StreamBuilder<Object>(
//           stream: FirebaseFirestore.instance.collection('video').snapshots(),
//           builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
//             if (!snapshot.hasData) {
//               return Center(child: CircularProgressIndicator());
//             } else {
//               return PageView.builder(
//                 itemCount: snapshot.data.docs.length,
//                 itemBuilder: (context, index) {
//                   var url = snapshot.data.docs[index]['url'];
//                   print(url);
//                   return Text('');
//                 },
//               );
//             }
//           }),