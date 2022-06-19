import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_own_event/constants/colors.dart';
import 'package:flutter_own_event/widgets/UserPostWidget.dart';
import 'package:flutter_own_event/widgets/categoryList.dart';
import 'package:flutter_own_event/widgets/usersStoryList.dart';
import 'package:sizer/sizer.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FixedExtentScrollController fixedExtentScrollController =
      new FixedExtentScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PRIMARY_COLOR_LIGHT,
      // appBar: AppBar(
      //   elevation: 0,
      //   backgroundColor: PRIMARY_COLOR,
      //   centerTitle: true,
      //   title: Text(
      //     'MakeEvent',
      //   ),
      // ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 15.0.h,
              child: StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection('Users').snapshots(),
                // initialData: initialData,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        var userid = snapshot.data.docs[index]['id'].toString();
                        var photoUrl =
                            snapshot.data.docs[index]['profile_pic'].toString();

                        var username =
                            snapshot.data.docs[index]['name'].toString();
                        return UserStoryList(
                          userid: userid,
                          username: username,
                          photoUrl: photoUrl,
                        );
                      },
                    );
                  }
                },
              ),
            ),
            //  return Container(
            //       child: ListView.builder(
            //         physics: ScrollPhysics(
            //           parent: BouncingScrollPhysics(),
            //         ),
            //         itemCount: snapshot.data.docs.length,
            //         scrollDirection: Axis.horizontal,
            //         itemBuilder: (context, index) {
            //           return Text('dd');
            //         },
            //       ),
            //     );
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: ClipRRect(
            //     borderRadius: BorderRadius.circular(30),
            //     child: Container(
            //       padding: EdgeInsets.all(15),
            //       color: PRIMARY_COLOR,
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: [
            //           Text(
            //             'Search . . . . . . . ',
            //             style: GoogleFonts.montserrat(
            //               color: Colors.white,
            //             ),
            //           ),
            //           Icon(
            //             Ionicons.search,
            //             color: Colors.white,
            //           )
            //         ],
            //       ),
            //       width: double.infinity,
            //     ),
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CategoryList(),
            ),
            Expanded(
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('Feeds')
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      return ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          var cardData = snapshot.data!.docs;
                          // DocumentSnapshot ds = snapshot.data?.docs[index];
                          // print(cardData[index]);
                          final username = cardData[index]['username'];
                          final docId = cardData[index]['docId'];
                          final date = cardData[index]['Date'];
                          final description = cardData[index]['Description'];
                          final nomEvenement = cardData[index]['NomEvenement'];
                          final payant = cardData[index]['Payant'];
                          final prix = cardData[index]['TypeEvenement'];
                          final postPicture = cardData[index]['post_picture'];
                          final eventDay = cardData[index]['day'];
                          final eventMonth = cardData[index]['month'];
                          final nbPers = cardData[index]['NombrePersonne'];
                          final adress = cardData[index]['adress'];

                          return Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: UserPostWidget(
                                date: date,
                                description: description,
                                nomEvenement: nomEvenement,
                                payant: payant,
                                prix: prix,
                                postPicture: postPicture,
                                username: username,
                                docId: docId,
                                eventDay: eventDay,
                                eventMonth: eventMonth,
                                nbPers: nbPers,
                                adress: adress,
                              ),
                            ),
                          );
                        },
                      );
                    }
                  }),
            ),
          ],
        ),
      ),
      // floatingActionButton: SpeedDial(
      //   overlayColor: PRIMARY_COLOR,
      //   backgroundColor: PRIMARY_COLOR,
      //   animatedIcon: AnimatedIcons.menu_close,
      //   child: Icon(
      //     Icons.question_answer,
      //     color: Colors.white,
      //   ),
      //   children: [
      //     SpeedDialChild(
      //       onTap: () => Navigator.push(
      //           context,
      //           MaterialPageRoute(
      //             builder: (context) => CameraScreen(),
      //           )),
      //       backgroundColor: PRIMARY_COLOR_LIGHT,
      //       child: Icon(
      //         Icons.camera,
      //         color: Colors.white,
      //       ),
      //     ),
      //     SpeedDialChild(
      //       onTap: () => Navigator.push(
      //           context,
      //           MaterialPageRoute(
      //             builder: (context) => UserProfilePage(),
      //           )),
      //       backgroundColor: PRIMARY_COLOR_LIGHT,
      //       child: Icon(
      //         Icons.account_circle,
      //         color: Colors.white,
      //       ),
      //     ),
      //     SpeedDialChild(
      //       onTap: () => Navigator.push(
      //           context,
      //           MaterialPageRoute(
      //             builder: (context) => CameraScreen(),
      //           )),
      //       backgroundColor: PRIMARY_COLOR_LIGHT,
      //       child: Icon(
      //         Icons.settings,
      //         color: Colors.white,
      //       ),
      //     ),
      //     SpeedDialChild(
      //       onTap: () => Navigator.push(
      //           context,
      //           MaterialPageRoute(
      //             builder: (context) => CreateEvent(),
      //           )),
      //       backgroundColor: PRIMARY_COLOR_LIGHT,
      //       child: Icon(
      //         Icons.publish,
      //         color: Colors.white,
      //       ),
      //     )
      //   ],
      // )
      // floatingActionButton: Padding(
      //   padding: const EdgeInsets.only(left: 30.0, right: 30),
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //     children: [
      //       FloatingActionButton(
      //         backgroundColor: Colors.red,
      //         onPressed: () {
      //           Navigator.push(
      //             context,
      //             MaterialPageRoute(
      //               builder: (context) => UserProfilePage(),
      //             ),
      //           );
      //         },
      //         child: Icon(Icons.account_box_rounded),
      //       ),
      //       FloatingActionButton(
      //         backgroundColor: Colors.red,
      //         onPressed: () {
      //           Navigator.push(
      //             context,
      //             MaterialPageRoute(
      //               builder: (context) => CreateEvent(),
      //             ),
      //           );
      //         },
      //         child: Icon(Icons.create),
      //       ),
      //       FloatingActionButton(
      //         backgroundColor: Colors.red,
      //         onPressed: () {
      //           Navigator.push(
      //             context,
      //             MaterialPageRoute(
      //               builder: (context) => CameraScreen(),
      //             ),
      //           );
      //         },
      //         child: Icon(Icons.camera),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
