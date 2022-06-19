import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_own_event/constants/colors.dart';
import 'package:flutter_own_event/constants/fontsCustom.dart';

class CreatedEventWidget extends StatelessWidget {
  const CreatedEventWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('Users')
                .doc(uid)
                .collection('MyEvent')
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              return GridView.builder(
                scrollDirection: Axis.vertical,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: 130,
                  mainAxisSpacing: 30,
                  crossAxisSpacing: 20,
                ),
                itemCount: snapshot.data?.docs.length ?? 0,
                itemBuilder: (BuildContext context, int index) {
                  var cardData = snapshot.data!.docs;
                  final eventTitle = cardData[index]['NomEvenement'];
                  final eventPicture = cardData[index]['post_picture'];
                  return Material(
                    elevation: 5.0,
                    color: PRIMARY_COLOR,
                    borderRadius: BorderRadius.circular(20),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.network(
                            eventPicture,
                            height: 70,
                            fit: BoxFit.contain,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            eventTitle,
                            style: MONTSERRAT_LIGHT_WHITE,
                          ),
                        )
                      ],
                    ),
                  );
                },
              );
            }),
      ),
    );
  }
}
