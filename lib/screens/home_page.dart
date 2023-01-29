import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_app/model/notification_model.dart';
import 'package:music_app/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:music_app/screens/storage_class.dart';
import 'package:file_picker/file_picker.dart';
import 'package:music_app/screens/upload_screen.dart';
import 'home_screen.dart';
import 'package:intl/intl.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final FirebaseMessaging _messaging;
  late int totalNotifications = 0;
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  late Stream<QuerySnapshot<Map<String, dynamic>>> pendings = FirebaseFirestore
      .instance
      .collection('users')
      .doc(user!.uid)
      .collection("songs")
      .snapshots();
  int pending = 0, released = 0;
  late firebase_storage.ListResult result;
  Notifications? pushNotificationInfo;
  Storage s = Storage();

  void registerNotifications() async {
    _messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("User granted the permission");
    } else {
      print("Permission declined by user");
    }

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      Notifications notification = Notifications(
        title: message.notification!.title,
        body: message.notification!.body,
        dataTitle: message.data['title'],
        dataBody: message.data['body'],
      );
      setState(() {
        totalNotifications++;
        pushNotificationInfo = notification;
      });
      if (notification != null) {
        showSimpleNotification(
          Text(pushNotificationInfo!.title!),
          leading: NotificationBadge(
            totalNotification: totalNotifications,
          ),
          subtitle: Text(pushNotificationInfo!.body!),
          background: Colors.cyan.shade700,
          duration: const Duration(seconds: 2),
        );
      }
    });
  }

  UserModel loggedInUser = UserModel();
  User? user = FirebaseAuth.instance.currentUser;
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
    registerNotifications();
    monthSet();
  }

  final DateTime now = DateTime.now();
  String month = DateFormat('MM').format(DateTime.now()).toString();
  String day = DateFormat('dd').format(DateTime.now()).toString();
  String year = DateFormat('yyyy').format(DateTime.now()).toString();
  void monthSet() {
    if (month == '01') {
      setState(() {
        month = 'JAN';
      });
    }
    if (month == '02') {
      setState(() {
        month = 'FEB';
      });
    }
    if (month == '03') {
      setState(() {
        month = 'MAR';
      });
    }
    if (month == '04') {
      setState(() {
        month = 'APRIL';
      });
    }
    if (month == '05') {
      setState(() {
        month = 'MAY';
      });
    }
    if (month == '06') {
      setState(() {
        month = 'JUN';
      });
    }
    if (month == '07') {
      setState(() {
        month = 'JUL';
      });
    }
    if (month == '08') {
      setState(() {
        month = 'AUG';
      });
    }
    if (month == '09') {
      setState(() {
        month = 'SEP';
      });
    }
    if (month == '10') {
      setState(() {
        month = 'OCT';
      });
    }
    if (month == '11') {
      setState(() {
        month = 'NOV';
      });
    }
    if (month == '12') {
      setState(() {
        month = 'DEC';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Storage storage = Storage();
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 20, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: SizedBox(
                            height: 35,
                            width: 150,
                            child: Image.asset("assets/logo.PNG",
                                fit: BoxFit.contain, height: 10.0),
                          ),
                        ),
                        const Text('fbhhj '),
                      ],
                    ),
                    const Text(
                      "Dashboard",
                      style: TextStyle(color: Colors.white, fontSize: 19),
                    ),
                  ]),
                  const SizedBox(
                    height: 20,
                  ),
                  Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blue,
                    child: MaterialButton(
                        padding: const EdgeInsets.fromLTRB(40, 15, 40, 15),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const UploadScreen()));
                        },
                        child: const Text(
                          "Uploader",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.normal),
                        )),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Container(
              margin: const EdgeInsets.only(left: 30),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Hello, ${loggedInUser.fullName}",
                  style: const TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                      fontWeight: FontWeight.normal),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 20, 20, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.55,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10.0),
                                  topRight: Radius.circular(10.0),
                                  bottomLeft: Radius.circular(10.0),
                                  bottomRight: Radius.circular(10.0),
                                ),
                              ),
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      '$day',
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 33,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      '$month',
                                      style: const TextStyle(
                                          color: Colors.white70,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                              margin: const EdgeInsets.only(left: 30),
                              height: 70,
                              width: 80,
                              // color: const Color(0xFF58CCED),
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                color: Color(0xFF161616),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10.0),
                                  topRight: Radius.circular(10.0),
                                  bottomLeft: Radius.circular(10.0),
                                  bottomRight: Radius.circular(10.0),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      '0',
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 40,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                    child: Align(
                                      alignment: Alignment.topCenter,
                                      child: Text(
                                        ' Pending',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              margin: const EdgeInsets.only(left: 10),
                              height: 70,
                              width: 120,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                color: Color(0xFF161616),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10.0),
                                  topRight: Radius.circular(10.0),
                                  bottomLeft: Radius.circular(10.0),
                                  bottomRight: Radius.circular(10.0),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                                    child: Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Text(
                                        'Releases',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      '0',
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 40,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                              margin: const EdgeInsets.only(left: 30),
                              height: 70,
                              width: 120,
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 10),
                              height: 70,
                              width: 80,
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "${year[0]}${year[1]}\n${year[2]}${year[3]}",
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 27,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              decoration: const BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10.0),
                                  topRight: Radius.circular(10.0),
                                  bottomLeft: Radius.circular(10.0),
                                  bottomRight: Radius.circular(10.0),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 30, 0),
                    child: Container(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          "assets/profilepics.gif",
                          fit: BoxFit.fill,
                          width: MediaQuery.of(context).size.width * 0.34,
                          height: MediaQuery.of(context).size.height * 0.18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            buildNotifications(
              context,
              "Notification",
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              decoration: const BoxDecoration(
                color: Color(0xFF161616),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                  bottomLeft: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0),
                ),
              ),
              width: MediaQuery.of(context).size.width * 0.9,
              height: 400,
              child: pushNotificationInfo != null
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Title: ${pushNotificationInfo!.dataTitle ?? pushNotificationInfo!.title}",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.white),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Body: ${pushNotificationInfo!.dataBody ?? pushNotificationInfo!.body}",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.white),
                        ),
                      ],
                    )
                  : Container(
                      child: (loggedInUser.pending == "Pending")
                          ? Row(
                              children: [
                                const SizedBox(
                                  width: 10,
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: Image.asset(
                                    "assets/logo.PNG",
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                const Expanded(
                                    child: Text(
                                  "Your Track Has been uploaded and waiting for Released",
                                  style: TextStyle(color: Colors.white),
                                )),
                              ],
                            )
                          : Container(),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector buildNotifications(BuildContext context, String title) {
    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const SizedBox(
                  width: 15,
                ),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
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
}

class NotificationBadge extends StatefulWidget {
  final int totalNotification;
  const NotificationBadge({Key? key, required this.totalNotification})
      : super(key: key);

  @override
  _NotificationBadgeState createState() => _NotificationBadgeState();
}

class _NotificationBadgeState extends State<NotificationBadge> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: const BoxDecoration(
        color: Colors.orange,
        shape: BoxShape.circle,
      ),
      child: const Center(
        child: Padding(
          padding: EdgeInsets.all(8),
        ),
      ),
    );
  }
}
