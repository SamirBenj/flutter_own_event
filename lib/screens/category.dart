import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_own_event/constants/colors.dart';

import '../widgets/UserPostWidget.dart';

class CategoryScreen extends StatefulWidget {
  CategoryScreen({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PRIMARY_COLOR_LIGHT,
      appBar: AppBar(
        backgroundColor: PRIMARY_COLOR_LIGHT,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.logout_outlined))
        ],
        title: Text(widget.title.toString()),
        centerTitle: true,
        elevation: 0,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Feeds')
            .where("TypeEvenement", isEqualTo: widget.title.toString())
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return ListView.builder(
            itemCount: snapshot.data.docs!.length,
            itemBuilder: (BuildContext context, int index) {
              // print(snapshot.data.docs[index]['NombrePersonne'].toString());
              var cardData = snapshot.data!.docs;

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
              if (snapshot.hasData) {
                return Padding(
                  padding: const EdgeInsets.all(20.0),
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
                );
              } else if (snapshot.data == null) {
                return Text('error');
              } else {
                return CircularProgressIndicator();
              }
            },
          );
        },
      ),
    );
  }
}
