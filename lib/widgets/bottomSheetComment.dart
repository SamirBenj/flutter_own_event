import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_own_event/constants/colors.dart';
import 'package:flutter_own_event/constants/fontsCustom.dart';
import 'package:flutter_own_event/functions/firebaseHelper.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class BottomSheetCommentSection extends StatefulWidget {
  const BottomSheetCommentSection({
    Key? key,
    required this.docId,
  }) : super(key: key);

  final String docId;

  @override
  State<BottomSheetCommentSection> createState() =>
      _BottomSheetCommentSectionState();
}

class _BottomSheetCommentSectionState extends State<BottomSheetCommentSection> {
  var userData = FirebaseAuth.instance.currentUser;
  TextEditingController textEditingController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: PRIMARY_COLOR,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        height: 100.h,
        child: Padding(
          padding: EdgeInsets.only(top: 2.h),
          child: Column(
            children: [
              Text(
                'COMMENTER',
                style: MONTSERRAT_BOLD_WHITE,
              ),
              Divider(
                thickness: 1,
                color: Colors.white,
              ),
              Expanded(
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("Feeds")
                        .doc(widget.docId)
                        .collection('Comments')
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      return ListView.builder(
                        itemCount: snapshot.data?.docs.length ?? 0,
                        itemBuilder: (BuildContext context, int index) {
                          var cardData = snapshot.data!.docs;
                          final username = cardData[index]['username'];
                          final profile_pic = cardData[index]['profile_pic'];
                          final content = cardData[index]['content'];

                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              elevation: 3.0,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 2.0.w, vertical: 1.5.h),
                                child: ListTile(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  leading: CircleAvatar(
                                      // backgroundColor: Colors.white,
                                      radius: 25.0,
                                      child: ClipOval(
                                        child: FancyShimmerImage(
                                          imageUrl: profile_pic,
                                          boxFit: BoxFit.cover,
                                          width: 15.0.w,
                                          height: 15.0.h,
                                        ),
                                      )),
                                  title: Text('Tom Cruise'),
                                  subtitle: Text(
                                    content,
                                    maxLines: 2,
                                    style: GoogleFonts.montserrat(
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }),
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 1.0.w, vertical: 0.5.h),
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.only(left: 1.0.w, right: 4.0.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                            child: TextFormField(
                          controller: textEditingController,
                          textInputAction: TextInputAction.go,
                          decoration: InputDecoration(
                            fillColor: Colors.red,
                            hintText: 'Commenter . . . ',
                            contentPadding: EdgeInsets.only(left: 5.w),
                          ),
                          onTap: () {},
                        )),
                        IconButton(
                          icon: Icon(Icons.send),
                          onPressed: () {
                            FirebaseHelper()
                                .addComment(
                                  widget.docId,
                                  userData?.displayName,
                                  textEditingController.text.toString(),
                                )
                                .then(
                                  (value) => ScaffoldMessenger.of(context)
                                      .showSnackBar(
                                    const SnackBar(
                                        duration: Duration(milliseconds: 500),
                                        backgroundColor: Colors.green,
                                        content:
                                            Text('Publication en cours....')),
                                  ),
                                );
                            FocusScope.of(context).unfocus();
                            textEditingController.clear();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
