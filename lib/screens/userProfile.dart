import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_own_event/constants/colors.dart';
import 'package:flutter_own_event/constants/fontsCustom.dart';
import 'package:flutter_own_event/functions/firebaseHelper.dart';
import 'package:flutter_own_event/models/userClass.dart';
import 'package:flutter_own_event/widgets/createdEvent.dart';
import 'package:flutter_own_event/widgets/followerCounter.dart';
import 'package:flutter_own_event/widgets/participatedEvents.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:image_picker/image_picker.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({Key? key, this.userData}) : super(key: key);
  final userData;
  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  bool isShowWidget = false;
  final db = FirebaseFirestore.instance;
  late File image;
  final imagePicker = ImagePicker();
  bool isEditing = true;
  TextEditingController textEditingController = new TextEditingController();
  Future<void> getImagePic() async {
    var pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      image = new File(pickedImage!.path);
      print('mon image' + image.toString());
    });

    uploadPic(image, widget.userData);
    setState(() {});
  }

  // String description = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: PRIMARY_COLOR_LIGHT,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: PRIMARY_COLOR_LIGHT,
        child: Icon(
          Icons.add_a_photo,
          color: Colors.white,
        ),
        onPressed: () {
          getImagePic();
        },
      ),
      body: Column(
        children: [
          StreamBuilder(
              stream:
                  db.collection('Users').doc(widget.userData.uid).snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData || snapshot.hasError) {
                  return CircularProgressIndicator();
                } else {
                  var profileOrNot = false;
                  User user =
                      User.fromDocument(snapshot.data as DocumentSnapshot);

                  if (user.photo_pic != '') {
                    profileOrNot = true;
                  } else {
                    profileOrNot = false;
                  }
                  print(user.follower);
                  return Column(
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.25,
                            child: Image.network(
                              'https://www.aphp.fr/sites/default/files/styles/grande_image_896_x_504/public/concert.jpg?itok=2fdSXurJ',
                              // 'https://upload.wikimedia.org/wikipedia/commons/7/7f/Emma_Watson_2013.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: MediaQuery.of(context).size.height * 0.15,
                            child: Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                CircleAvatar(
                                    // backgroundColor: Colors.white,
                                    radius: 65.0,
                                    child: ClipOval(
                                      child: profileOrNot
                                          ? Image.network(
                                              user.photo_pic,
                                              fit: BoxFit.cover,
                                              width: 140.0,
                                              height: 140.0,
                                            )
                                          : Image.network(
                                              widget.userData.photoURL,
                                              fit: BoxFit.cover,
                                              width: 140.0,
                                              height: 140.0,
                                            ),
                                    )),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: PRIMARY_COLOR,
                                  ),
                                  child: GestureDetector(
                                    onTap: () => {
                                      print('hello'),
                                      db
                                          .collection('Users')
                                          .doc(widget.userData.uid)
                                          .update({
                                        'follower': 'FieldValue.increment(1)',
                                      })
                                    },
                                    child: Icon(
                                      Icons.add,
                                      size: 35,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      FollowerCounter(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  user.name,
                                  style: MONTSERRAT_BOLD_WHITE,
                                ),
                                InkWell(
                                  onTap: () {
                                    isEditing = !isEditing;
                                    setState(() {});
                                  },
                                  child: isEditing
                                      ? Icon(Icons.edit_outlined)
                                      : InkWell(
                                          onTap: () {
                                            db
                                                .collection('Users')
                                                .doc(widget.userData.uid)
                                                .update({
                                              'description':
                                                  textEditingController.text
                                                      .toString()
                                            });
                                            FocusScope.of(context).unfocus();

                                            isEditing = !isEditing;
                                            setState(() {});
                                          },
                                          child: Icon(Icons.check),
                                        ),
                                ),
                              ],
                            ),
                            Divider(
                              color: Colors.white,
                              thickness: 0,
                              endIndent: 50,
                              indent: 50,
                            ),
                            isEditing
                                ? Text(
                                    user.description.toString(),
                                    maxLines: 2,
                                    style: MONTSERRAT_LIGHT_WHITE,
                                  )
                                : TextField(
                                    controller: textEditingController,
                                  ),
                            Divider(
                              color: Colors.white,
                              height: MediaQuery.of(context).size.height * 0.04,
                              indent: 100,
                              endIndent: 100,
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }
              }),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton.icon(
                icon: Icon(Icons.create_new_folder),
                label: Text(
                  'EVÉNEMENT',
                  style: MONTSERRAT_LIGHT_WHITE,
                ),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  primary: isShowWidget ? PRIMARY_COLOR : Colors.red,
                ),
                onPressed: () {
                  isShowWidget = true;
                  setState(() {});
                },
              ),
              ElevatedButton.icon(
                icon: Icon(Icons.event_available),
                style: ElevatedButton.styleFrom(
                  primary: isShowWidget ? Colors.red : PRIMARY_COLOR,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () {
                  isShowWidget = false;
                  setState(() {});
                },
                label: Text(
                  'PARTICIPÉ',
                  style: MONTSERRAT_LIGHT_WHITE,
                ),
              ),
            ],
          ),
          isShowWidget ? CreatedEventWidget() : ParticipatedEvents(),
        ],
      ),
    );
  }
}
