import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter_own_event/constants/colors.dart';
import 'package:flutter_own_event/screens/cameraScreen.dart';
import 'package:flutter_own_event/screens/createEvent.dart';
import 'package:flutter_own_event/screens/homepage.dart';
import 'package:flutter_own_event/screens/qrCodelist.dart';
import 'package:flutter_own_event/screens/settingsPage.dart';
import 'package:flutter_own_event/screens/userProfile.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';

class NavigationBottomBar extends StatefulWidget {
  NavigationBottomBar({Key? key}) : super(key: key);
  @override
  _NavigationBottomBarState createState() => _NavigationBottomBarState();
}

class _NavigationBottomBarState extends State<NavigationBottomBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> animation;
  late CurvedAnimation curve;

  var _bottomNavIndex = 0; //default index of a first screen
  final PageList = <Widget>[
    MyHomePage(),
    UserProfilePage(
      userData: FirebaseAuth.instance.currentUser,
    ),
    CreateEvent(
      userData: FirebaseAuth.instance.currentUser,
    ),
    QrCodeListScreen(),
  ];
  final iconList = <IconData>[
    Icons.feed,
    Icons.account_circle_rounded,
    Icons.publish,
    Icons.qr_code,
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getUserName();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // body: PageList[_bottomNavIndex],
      body: PageList[_bottomNavIndex],
      // IndexedStack(
      //   children: const [
      //     // _buildOffstageNavigator(0),
      //     // _buildOffstageNavigator(1),
      //     // _buildOffstageNavigator(2),
      //     // _buildOffstageNavigator(3),
      //     MyHomePage(),
      //     UserProfilePage(),
      //     CreateEvent(),
      //     SettingsPage(),
      //   ],
      // ),
      floatingActionButton: FloatingActionButton(
        elevation: 5,
        backgroundColor: PRIMARY_COLOR,
        child: Icon(
          Icons.camera,
        ),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => CameraScreen()));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        itemCount: iconList.length,
        tabBuilder: (int index, bool isActive) {
          final color = isActive ? Colors.white : Colors.grey;
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                iconList[index],
                size: 35,
                color: color,
              ),
              SizedBox(height: 0.h),
            ],
          );
        },
        backgroundColor: PRIMARY_COLOR,
        activeIndex: _bottomNavIndex,
        splashColor: Colors.white,
        // notchAndCornersAnimation: animation,
        splashSpeedInMilliseconds: 300,
        notchSmoothness: NotchSmoothness.softEdge,
        gapLocation: GapLocation.center,
        leftCornerRadius: 0,
        rightCornerRadius: 0,
        onTap: (index) => setState(() => _bottomNavIndex = index),
      ),
    );
  }

  Map _routeBuilders(BuildContext context, int index) {
    return {
      '/': (context) {
        return [
          MyHomePage(),
          UserProfilePage(
            userData: null,
          ),
          CreateEvent(),
          SettingsPage(),
        ].elementAt(index);
      },
    };
  }

  // Widget _buildOffstageNavigator(int index) {
  //   final routeBuilders = _routeBuilders(context, index);

  //   return Offstage(
  //     offstage: _bottomNavIndex != index,
  //     child: Navigator(
  //       onGenerateRoute: (routeSettings) {
  //         return MaterialPageRoute(
  //           builder: (context) {
  //             print(_bottomNavIndex);

  //             return routeBuilders[routeSettings.name](context);
  //           },
  //         );
  //       },
  //     ),
  //   );
  // }
}
