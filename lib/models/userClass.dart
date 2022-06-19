import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String name;
  final String id;
  final String prenom;
  final String nom;
  final String photo_pic;
  final String description;
  final String follower;
  const User({
    required this.name,
    required this.id,
    required this.prenom,
    required this.nom,
    required this.photo_pic,
    required this.description,
    required this.follower,
  });

  factory User.fromDocument(DocumentSnapshot document) {
    return User(
      description: document.data().toString().contains('description')
          ? document.get('description')
          : 'veuillez faire une description de vous',
      photo_pic: document.data().toString().contains('profile_pic')
          ? document.get('profile_pic')
          : '',
      name: document.data().toString().contains('profile_pic')
          ? document.get('name')
          : '',
      id: document.data().toString().contains('profile_pic')
          ? document.get('id')
          : '',
      // photoURL: document['photoURL'],
      nom: document.data().toString().contains('profile_pic')
          ? document.get('nom')
          : '',
      prenom: document.data().toString().contains('profile_pic')
          ? document.get('prenom')
          : '',
      follower: document.data().toString().contains('follower')
          ? document.get('follower')
          : '',
    );
  }
}
