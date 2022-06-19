//3H45
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_own_event/screens/loginScreen.dart';

import 'package:sizer/sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // void eraseData() async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   FirebaseAuth.instance.signOut();
  //   sharedPreferences.clear();
  //   sharedPreferences.setString('id', '');
  // }

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          // theme: ThemeData(),
          home: LoginScreen()
          // home: Scaffold(
          //   appBar: AppBar(
          //     title: Text('ehl'),
          //   ),
          //   body: Column(children: []),
          // ),
          );
    });
  }
}
