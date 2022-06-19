import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_own_event/constants/colors.dart';
import 'package:flutter_own_event/constants/fontsCustom.dart';
import 'package:flutter_own_event/screens/loginScreen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  // SharedPreferences sharedPreferences =
  //     SharedPreferences.getInstance() as SharedPreferences;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // checkIfLoggedIn();
  }

  checkIfLoggedIn() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // bool userLoggedINn = (sharedPreferences.getString('id') ?? '').isNotEmpty;
    // String userIDToken = sharedPreferences.getString('id').toString();
    // print('user id' + userIDToken);
    sharedPreferences.clear();
  }

  bool isShowWidget = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PRIMARY_COLOR,
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                checkIfLoggedIn();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                    ),
                    (route) => false);
              },
              icon: Icon(Icons.logout_outlined))
        ],
        title: Text('PARAMÈTRE'),
        leading: IconButton(
          onPressed: () {
            isShowWidget = !isShowWidget;
            setState(() {});
          },
          icon: Icon(Icons.edit),
          color: Colors.white,
        ),
        backgroundColor: PRIMARY_COLOR_LIGHT,
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: 7,
        itemBuilder: (BuildContext context, int index) {
          //associer le type dans une variable;
          return Card(
            color: Colors.white,
            elevation: 5,
            margin: EdgeInsets.all(20),
            child: Container(
              margin: EdgeInsets.all(5),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Nom',
                        style: MONTSERRAT_BOLD_DARK,
                      ),
                      // IconButton(
                      //   onPressed: () {
                      //     isShowWidget = !isShowWidget;
                      //     setState(() {});
                      //   },
                      //   icon: Icon(Icons.edit),
                      //   color: PRIMARY_COLOR_LIGHT,
                      // ),
                    ],
                  ),
                  isShowWidget
                      ? Text('')
                      : Padding(
                          padding: const EdgeInsets.only(left: 100, right: 100),
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: "C'est Par ICI 👋",
                              hintStyle: GoogleFonts.montserrat(
                                fontSize: 13,
                                color: Colors.white,
                              ),
                              fillColor: PRIMARY_COLOR_LIGHT,
                              filled: true,
                            ),
                          ),
                        ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
