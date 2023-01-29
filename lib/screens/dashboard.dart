import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_app/screens/earning_page.dart';
import 'package:music_app/screens/music_page.dart';
import 'package:music_app/screens/setting_page.dart';
import 'package:music_app/screens/user_page.dart';
import '../model/user_model.dart';
import 'home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'home_screen.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int currentIndex = 0;
  final screens = <Widget>[
    const HomePage(),
    const UserPage(),
    const MusicPage(),
    const EarningPage(),
    const SettingPage(),
  ];
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        backgroundColor: const Color(0xFF161616),
        selectedItemColor: Colors.blueAccent,
        currentIndex: currentIndex,
        onTap: (index) => setState(() {
          currentIndex = index;
        }),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 35.0,
              color: Colors.white,
            ),
            backgroundColor: Color(0xFF161616),
            label: "",
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                size: 35.0,
              ),
              backgroundColor: Color(0xFF161616),
              label: ""),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.music_note,
                size: 35.0,
              ),
              backgroundColor: Color(0xFF161616),
              label: ""),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.attach_money_rounded,
                size: 35.0,
              ),
              backgroundColor: Color(0xFF161616),
              label: ""),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.settings,
                size: 35.0,
              ),
              backgroundColor: Color(0xFF161616),
              label: ""),
        ],
      ),
    );
  }
}
