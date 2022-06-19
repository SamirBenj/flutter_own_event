import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_own_event/constants/colors.dart';
import 'package:flutter_own_event/screens/cameraScreen.dart';
import 'package:flutter_own_event/screens/createEvent.dart';
import 'package:flutter_own_event/screens/homepage.dart';
import 'package:flutter_own_event/screens/settingsPage.dart';
import 'package:flutter_own_event/screens/userProfile.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class PersistentNavBar extends StatefulWidget {
  const PersistentNavBar({Key? key}) : super(key: key);

  @override
  State<PersistentNavBar> createState() => _PersistentNavBarState();
}

class _PersistentNavBarState extends State<PersistentNavBar> {
  var userData;
  Future getUserName() async {
    // print('userIdPref1' + userIdPref1);
    // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // userName = sharedPreferences.getString('name');
    // print('userName' + userName);
    // profilepic = sharedPreferences.getString('profile_pic');
    // userID = sharedPreferences.getString('id');
    setState(() {
      userData = FirebaseAuth.instance.currentUser;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserName();
  }

  @override
  Widget build(BuildContext context) {
    late PersistentTabController _controller;
    _controller = PersistentTabController(initialIndex: 0);
    List<Widget> _buildScreen = [
      MyHomePage(),
      // UserProfilePage(),
      CreateEvent(),
      CameraScreen(),
      SettingsPage(),
    ];

    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreen,
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: PRIMARY_COLOR, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: PRIMARY_COLOR,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
          NavBarStyle.style16, // Choose the nav bar style with this property.
    );
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(
          Icons.feed,
        ),
        title: ("Home"),
        activeColorPrimary: CupertinoColors.white,
        inactiveColorPrimary: PRIMARY_COLOR_LIGHT,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(
          Icons.account_circle_rounded,
        ),
        title: ("Settings"),
        activeColorPrimary: CupertinoColors.white,
        inactiveColorPrimary: PRIMARY_COLOR_LIGHT,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(
          Icons.camera,
          color: Colors.red,
        ),
        title: ("CAMERA"),
        activeColorPrimary: CupertinoColors.white,
        inactiveColorPrimary: PRIMARY_COLOR_LIGHT,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(
          Icons.settings,
        ),
        title: ("Settings"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: PRIMARY_COLOR_LIGHT,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(
          Icons.publish,
        ),
        title: ("Settings"),
        activeColorPrimary: CupertinoColors.white,
        inactiveColorPrimary: PRIMARY_COLOR_LIGHT,
      ),
    ];
  }
}
