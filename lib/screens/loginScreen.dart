import 'package:flutter/material.dart';
import 'package:flutter_own_event/constants/colors.dart';
import 'package:flutter_own_event/functions/firebaseHelper.dart';
import 'package:flutter_own_event/navigationsBar/naviagationBar.dart';
import 'package:flutter_own_event/screens/WelcomeScreen.dart';
import 'package:flutter_own_event/screens/splashScreen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:lottie/lottie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_own_event/navigationsBar/persistentNavigationBar.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool pageInitialised = false;
  checkIfLoggedIn() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // sharedPreferences.clear();
    bool userLoggedINn = (sharedPreferences.getString('id') ?? '').isNotEmpty;
    String userIDToken = sharedPreferences.getString('id').toString();
    print('user id' + userIDToken);

    if (userLoggedINn) {
      var userData = FirebaseAuth.instance.currentUser;
      sharedPreferences.setString('email', userData!.email.toString());
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => SplashScreen()));
      print('not moving');
    } else {
      print('not moving');
      setState(() {
        pageInitialised = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    checkIfLoggedIn();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: PRIMARY_COLOR_LIGHT,
      body: SafeArea(
        child: pageInitialised
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Welcome 👋 ! Time to Login !',
                      style: GoogleFonts.montserrat(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            color: Colors.black.withOpacity(0.2),
                            offset: Offset(6, 7),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                    ),
                    LottieBuilder.asset(
                      'assets/event.json',
                      width: width / 2,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(10),
                        color: PRIMARY_COLOR,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: InkWell(
                                  onTap: () {
                                    FirebaseHelper().Login(context);
                                  },
                                  child: Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            'CONNECTION AVEC GOOGLE',
                                            style: GoogleFonts.montserrat(
                                              color: Colors.orange,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Icon(Ionicons.logo_google),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          'CONNECTION AVEC FACEBOOK',
                                          style: GoogleFonts.montserrat(
                                            color: Colors.orange,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Icon(
                                          Ionicons.logo_facebook,
                                          color: Colors.blue,
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
                    )
                  ],
                ),
              )
            : CircularProgressIndicator(
                color: Colors.red,
              ),
      ),
    );
  }
}
