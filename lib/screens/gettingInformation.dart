import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_own_event/constants/colors.dart';
import 'package:flutter_own_event/constants/fontsCustom.dart';
import 'package:flutter_own_event/functions/firebaseHelper.dart';
import 'package:flutter_own_event/navigationsBar/naviagationBar.dart';
import 'package:google_fonts/google_fonts.dart';

class GetMoreInformationScreen extends StatefulWidget {
  GetMoreInformationScreen({Key? key}) : super(key: key);

  @override
  GetMoreInformationScreenState createState() =>
      GetMoreInformationScreenState();
}

class GetMoreInformationScreenState extends State<GetMoreInformationScreen> {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    TextEditingController textEditingControllerNom =
        new TextEditingController();
    TextEditingController textEditingControllerPrenom =
        new TextEditingController();
    TextEditingController textEditingControllerAge =
        new TextEditingController();
    TextEditingController textEditingControllerPays =
        new TextEditingController();
    TextEditingController textEditingControllerMail =
        new TextEditingController();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: PRIMARY_COLOR_LIGHT,
      body: SafeArea(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.all(0.0),
              child: Text(
                'Bientôt Fini !',
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      color: Colors.black.withOpacity(0.2),
                      offset: Offset(6, 7),
                      blurRadius: 10,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: PRIMARY_COLOR,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Form(
                key: _formKey,
                child: Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text("PLUS D'INFORMATION",
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                  color: Colors.black.withOpacity(0.2),
                                  offset: Offset(6, 7),
                                  blurRadius: 10,
                                ),
                              ],
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextFormField(
                          controller: textEditingControllerNom,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            // prefixIcon: IconButton(
                            //   icon: Icon(
                            //     Icons.title,
                            //     color: PRIMARY_COLOR,
                            //   ),
                            //   onPressed: () {},
                            //   color: Colors.white,
                            // ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            filled: false,
                            fillColor: Colors.white,
                            label: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                'Votre Nom . . . . ',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                            labelStyle: GoogleFonts.montserrat(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextFormField(
                          controller: textEditingControllerPrenom,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            // prefixIcon: IconButton(
                            //   icon: Icon(
                            //     Icons.title,
                            //     color: PRIMARY_COLOR,
                            //   ),
                            //   onPressed: () {},
                            //   color: Colors.white,
                            // ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            filled: false,
                            fillColor: Colors.white,
                            label: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                'Votre Prénom . . . . .',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                            labelStyle: GoogleFonts.montserrat(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextFormField(
                          controller: textEditingControllerAge,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            // prefixIcon: IconButton(
                            //   icon: Icon(
                            //     Icons.title,
                            //     color: PRIMARY_COLOR,
                            //   ),
                            //   onPressed: () {},
                            //   color: Colors.white,
                            // ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            filled: false,
                            fillColor: Colors.white,
                            label: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                'Age . . . ',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                            labelStyle: GoogleFonts.montserrat(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextFormField(
                          controller: textEditingControllerPays,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            // prefixIcon: IconButton(
                            //   icon: Icon(
                            //     Icons.title,
                            //     color: PRIMARY_COLOR,
                            //   ),
                            //   onPressed: () {},
                            //   color: Colors.white,
                            // ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            filled: false,
                            fillColor: Colors.white,
                            label: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                'Pays . . . . .',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                            labelStyle: GoogleFonts.montserrat(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextFormField(
                          controller: textEditingControllerMail,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            // prefixIcon: IconButton(
                            //   icon: Icon(
                            //     Icons.title,
                            //     color: PRIMARY_COLOR,
                            //   ),
                            //   onPressed: () {},
                            //   color: Colors.white,
                            // ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            filled: false,
                            fillColor: Colors.white,
                            label: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                'Votre Adresse Mail . . . ',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                            labelStyle: GoogleFonts.montserrat(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            // If the form is valid, display a snackbar. In the real world,
                            // you'd often call a server or save the information in a database.
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  backgroundColor: Colors.green,
                                  content: Text('Enregistrement en cours....')),
                            );
                            FirebaseHelper().addInformationData(
                              textEditingControllerNom.text.toString(),
                              textEditingControllerPrenom.text.toString(),
                              textEditingControllerAge.text.toString(),
                              textEditingControllerPays.text.toString(),
                            );
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        NavigationBottomBar()),
                                (Route<dynamic> route) => false);
                          }
                        },
                        child: Container(
                          margin: EdgeInsets.all(20),
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'CONTINUER',
                                style: MONTSERRAT_BOLD_LIGHT_COLOR,
                              ),
                              Icon(
                                Icons.forward,
                                color: PRIMARY_COLOR,
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
