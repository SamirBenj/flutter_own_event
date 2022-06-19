import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_own_event/constants/colors.dart';
import 'package:flutter_own_event/screens/pageViewStory.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class UserStoryList extends StatelessWidget {
  const UserStoryList({
    Key? key,
    required this.userid,
    required this.username,
    required this.photoUrl,
  }) : super(key: key);
  final String userid;
  final String username;
  final String photoUrl;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(1.3.h),
      child: Column(
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                // var test = FirebaseFirestore.instance
                //     .collection('Users')
                //     .doc('DWhAyPbZ0SMzX6VVsZpjIlvqSZl1')
                //     .collection('story')
                //     .snapshots()
                //     .map((e) => {
                //           print(e.
                //               .map((e) => print(e.get('image').toString()))),
                //         });
                // print(test);
                // if (FirebaseFirestore.instance
                //         .collection('Users')
                //         .doc(userid)
                //         .collection('story')
                //         .get().hashCode ==
                //     0) {
                //   print('hello');
                // } else {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        PageViewStory(userid: userid, username: username),
                  ),
                );
              },
              child: CircleAvatar(
                backgroundColor: Colors.red,
                radius: 40,
                child: CircleAvatar(
                    // backgroundColor: Colors.white,
                    radius: 35.0,
                    child: ClipOval(
                      child: FancyShimmerImage(
                        imageUrl: photoUrl,
                        boxFit: BoxFit.cover,
                        width: 20.0.w,
                        height: 20.0.h,
                      ),
                    )),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Text(
              username.toString(),
              style: GoogleFonts.montserrat(
                fontSize: 10,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
