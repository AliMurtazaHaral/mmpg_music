import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_app/admin_dashboard/screens/dashboard/components/message.dart';
import 'package:music_app/model/user_model.dart';
import 'package:music_app/screens/accounts.dart';
import 'package:music_app/screens/delete_account.dart';
import 'package:music_app/screens/help_screen.dart';
import 'package:music_app/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:music_app/screens/membership.dart';
import 'package:music_app/screens/membership2.dart';
import 'package:music_app/screens/paypal_payment.dart';
import 'package:music_app/screens/promotion_package_screen.dart';
import 'package:music_app/screens/push_notification.dart';
import 'package:music_app/screens/signup_login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            Container(
              height: 50,
              width: 450,
              decoration: const BoxDecoration(
                color: Color(0xFF161616),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
              ),
              child: const Align(
                alignment: Alignment.center,
                child: Text(
                  'Settings',
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.normal),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
              width: 20,
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: ListView(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                children: [
                  Row(
                    children: const [
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        'General',
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  buildAccount(
                    context,
                    "Account",
                    Image.asset(
                      "assets/account.PNG",
                      height: 32,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  buildNotifications(
                    context,
                    "Notifications",
                    Image.asset(
                      "assets/notification.PNG",
                      height: 30,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  buildMembership(
                    context,
                    "Membership",
                    Image.asset(
                      "assets/membership.PNG",
                      height: 30,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  buildDeleteAccount(
                    context,
                    "Delete Account",
                    Image.asset(
                      "assets/delete.PNG",
                      height: 30,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  buildLogout(
                    context,
                    "Logout",
                    Image.asset(
                      "assets/logout.PNG",
                      height: 30,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: const [
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        'Feedback',
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  buildHelp(
                    context,
                    "Help",
                    Image.asset(
                      "assets/help.PNG",
                      height: 30,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector buildAccount(BuildContext context, String title, Image i) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Accounts()));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                i,
                const SizedBox(
                  width: 20,
                ),
                Text(
                  title,
                  style: const TextStyle(fontSize: 20, color: Colors.white),
                ),
              ],
            ),
            const SizedBox(
              width: 19,
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }

  GestureDetector buildDeleteAccount(
      BuildContext context, String title, Image i) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const DeleteAccount()));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                i,
                const SizedBox(
                  width: 20,
                ),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(
              width: 19,
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }

  GestureDetector buildNotifications(
      BuildContext context, String title, Image i) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const PushNotification()));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                i,
                const SizedBox(
                  width: 20,
                ),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(
              width: 19,
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }

  GestureDetector buildMembership(BuildContext context, String title, Image i) {
    return GestureDetector(
      onTap: () {
        if (loggedInUser.payment == '10.99') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Membership2()),
          );
        } else if (loggedInUser.payment == '73.99') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Membership()),
          );
        } else {
          Container();
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                i,
                const SizedBox(
                  width: 20,
                ),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(
              width: 19,
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }

  GestureDetector buildHelp(BuildContext context, String title, Image i) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const HelpScreen()));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                i,
                const SizedBox(
                  width: 20,
                ),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(
              width: 19,
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }

  GestureDetector buildLogout(BuildContext context, String title, Image i) {
    return GestureDetector(
      onTap: () {
        logout(context);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                i,
                const SizedBox(
                  width: 20,
                ),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(
              width: 19,
            ),
          ],
        ),
      ),
    );
  }

  // the logout function
  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const SignUpLogin()));
  }
}
