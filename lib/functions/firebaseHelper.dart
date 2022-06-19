import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_own_event/navigationsBar/naviagationBar.dart';
import 'package:flutter_own_event/navigationsBar/persistentNavigationBar.dart';
import 'package:flutter_own_event/screens/gettingInformation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FirebaseHelper {
  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance.currentUser;
  final googleSignIn = GoogleSignIn();
  final firebaseAuth = FirebaseAuth.instance;

  //Connection au compte google
  Future<void> Login(BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final res = await googleSignIn.signIn();
    final auth = await res!.authentication;
    final credentials = GoogleAuthProvider.credential(
      idToken: auth.idToken,
      accessToken: auth.accessToken,
    );
    //Info utilisateur ex : photoUrl, id, nom, email
    final firebaseUser =
        (await firebaseAuth.signInWithCredential(credentials)).user;

    if (firebaseAuth != null) {
      final result = (await FirebaseFirestore.instance
              .collection('Users')
              .where('id', isEqualTo: firebaseUser!.uid)
              .get())
          .docs;
      print('user id' + firebaseUser.uid.toString());
      // print(result.length);
      if (result.length == 0) {
        //Creation nouveau utilsateur ajout dans la base de donées
        await FirebaseFirestore.instance
            .collection('Users')
            .doc(firebaseUser.uid)
            .set({
          "id": firebaseUser.uid,
          "name": firebaseUser.displayName,
          "profile_pic": firebaseUser.photoURL,
          "created_at": DateTime.now().millisecondsSinceEpoch.toString(),
        });
        print('it do not work');
        sharedPreferences.setString("id", firebaseUser.uid);
        sharedPreferences.setString("name", firebaseUser.displayName ?? '');
        sharedPreferences.setString("profile_pic", firebaseUser.photoURL ?? '');
        await Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => GetMoreInformationScreen()),
            (Route<dynamic> route) => false);
      } else {
        //old user
        //Sinon recuper les N
        sharedPreferences.setString("id", result[0]["id"]);
        sharedPreferences.setString("name", result[0]["name"]);
        sharedPreferences.setString("profile_pic", result[0]["profile_pic"]);
        // sharedPreferences.setString("status", result[0]["status"]);

        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => NavigationBottomBar()),
            (Route<dynamic> route) => false);
      }
    }
  }

  // Future<String> getCurrentUser() async {
  //   String data = FirebaseAuth.instance.currentUser!.uid.toString();
  //   return data;
  // }
  //ajouter les information de l'utilisateur dans la base de donnée
  Future<void> addInformationData(nom, prenom, age, pays) async {
    db.collection('Users').doc(auth?.uid).update({
      'nom': nom,
      'prenom': prenom,
      'age': age,
      'pays': pays,
      'events': 0,
      'following': 0,
      'follower': 0,
      'description': ''
    });
  }

  //Création d'un evenement
  Future createPost(
    image,
    nom,
    descri,
    date,
    prix,
    payant,
    nombrePersonne,
    TypeEvenement,
    adress,
    day,
    month,
  ) async {
    // print(auth?.uid.toString());
    db.collection('Users').doc(auth?.uid).collection('MyEvent').add({
      'username': auth?.displayName.toString(),
      'userId': auth?.uid,
      'NomEvenement': nom,
      'Description': descri,
      'Date': date,
      'timestamp': DateTime.now().microsecondsSinceEpoch.toString(),
      'Prix': prix,
      'Payant': payant,
      'NombrePersonne': nombrePersonne,
      'TypeEvenement': TypeEvenement,
      'NbParticipant': 0,
      'adress': adress,
      'day': day,
      'month': month,
      // 'image': image,
    }).then((value) => {
          print('adding post to uses table'),
          uploadPicPost(image, FirebaseAuth.instance.currentUser, value.id),
        });
    db.collection('Feeds').add({
      'username': auth?.displayName.toString(),
      'userId': auth?.uid,
      'NomEvenement': nom,
      'Description': descri,
      'Date': date,
      'timestamp': DateTime.now().microsecondsSinceEpoch.toString(),
      'Prix': prix,
      'Payant': payant,
      'NombrePersonne': nombrePersonne,
      'TypeEvenement': TypeEvenement,
      'adress': adress,
      'day': day,
      'month': month,
    }).then((value) => {
          print('adding post to feeds table'),
          db.collection('Feeds').doc(value.id).update({
            'docId': value.id,
          }),
          uploadPicPost(image, FirebaseAuth.instance.currentUser, value.id),
        });
  }

  Future<void> addComment(docName, username, content) async {
    db
        .collection('Feeds')
        .doc(docName)
        .collection('Comments')
        .doc()
        .set({
          'username': username,
          'timestamp': DateTime.now().microsecondsSinceEpoch.toString(),
          'content': content,
          'profile_pic': auth?.photoURL.toString(),
        })
        .then((value) => {print('comment added ! ')})
        .catchError((onError) => {
              print('There is an error for adding comment'),
              print(onError),
            });
  }
}

Future uploadPic(image, userData) async {
  // String userMail = FirebaseAuth.instance.currentUser!.email.toString();
  String fileName = image.path.split('/').last;
  Reference firebaseStorageRef = FirebaseStorage.instance
      .ref('Users')
      .child(userData.email)
      .child(fileName);
  UploadTask uploadTask = firebaseStorageRef.putFile(image);

  String url;
  await uploadTask.whenComplete(() async {
    url = await uploadTask.snapshot.ref.getDownloadURL();
    print('adding url to profile_pic');
    FirebaseFirestore.instance.collection('Users').doc(userData.uid).update({
      "profile_pic": url,
    });
  });

  Fluttertoast.showToast(
      msg:
          'Attendez quelque instant, et ça devrait être bon pour la photo, Bonne journée !');
}

Future uploadPicPost(image, userData, docId) async {
  String fileName = image.path.split('/').last;
  Reference firebaseStorageRef = FirebaseStorage.instance
      .ref('Users')
      .child(userData.email)
      .child('Posts')
      .child(docId)
      .child(fileName);
  UploadTask uploadTask = firebaseStorageRef.putFile(image);

  String url;
  await uploadTask.whenComplete(() async {
    url = await uploadTask.snapshot.ref.getDownloadURL();
    print('adding post picture to Post table');
    FirebaseFirestore.instance.collection('Feeds').doc(docId).update({
      "post_picture": url,
    });
    FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('MyEvent')
        .doc(docId)
        .update({
      "post_picture": url,
    });
  });

  Fluttertoast.showToast(
      msg:
          'Attendez quelque instant , et ça devrait être bon pour la photo dans la table users, Bonne journée !');
}
