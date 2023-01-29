import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../main/components/side_menu.dart';
import 'notification_collection.dart';

class NotificationManagement extends StatefulWidget {
  const NotificationManagement({Key? key}) : super(key: key);

  @override
  _NotificationManagementState createState() => _NotificationManagementState();
}

class _NotificationManagementState extends State<NotificationManagement> {
  Stream<QuerySnapshot<Map<String, dynamic>>> _foundUsers =
      FirebaseFirestore.instance.collection('users').snapshots();
  final Stream<QuerySnapshot<Map<String, dynamic>>> _allUsers =
      FirebaseFirestore.instance.collection('users').snapshots();
  void _runFilter(String enteredKeyword) {
    Stream<QuerySnapshot<Map<String, dynamic>>> results =
        FirebaseFirestore.instance.collection('users').snapshots();
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = _allUsers;
    } else {
      // we use the toLowerCase() method to make it case-insensitive
      results = FirebaseFirestore.instance
          .collection('users')
          .where('fullName'.toString(), isEqualTo: '$enteredKeyword'.toString())
          .snapshots();
    }

    // Refresh the UI
    setState(() {
      _foundUsers = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      drawer: const SideMenu(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Align(
          alignment: Alignment.center,
          child: Text(
            'Notification',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: TextField(
                onChanged: (value) => _runFilter(value),
                decoration: const InputDecoration(
                    labelText: 'Search', suffixIcon: Icon(Icons.search)),
              ),
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
              child: SizedBox(
                width: 450,
                height: 400,
                child: StreamBuilder(
                  stream: _foundUsers,
                  builder:
                      (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                    return Padding(
                      padding: const EdgeInsets.all(20),
                      child: Expanded(
                        child: streamSnapshot.data?.docs.length != 0
                            ? ListView.builder(
                                itemCount: streamSnapshot.data?.docs.length,
                                itemBuilder: (ctx, index) => Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "${index + 1}: ${streamSnapshot.data?.docs[index]['fullName']}",
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    NotificationComponent(
                                                  uid: streamSnapshot
                                                      .data?.docs[index]['uid'],
                                                ),
                                              ),
                                            );
                                          },
                                          child: Row(
                                            children: const [
                                              Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Text(
                                                  "Send Notification",
                                                  style: TextStyle(
                                                      color: Colors.blue,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontSize: 12,
                                                      decoration: TextDecoration
                                                          .underline),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Divider(
                                      height: 1,
                                      color: Colors.grey,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              )
                            : const Text(
                                'No results found',
                                style: TextStyle(fontSize: 24),
                              ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NotificationComponent extends StatefulWidget {
  final String uid;
  const NotificationComponent({Key? key, required String this.uid})
      : super(key: key);

  @override
  _NotificationComponentState createState() => _NotificationComponentState();
}

class _NotificationComponentState extends State<NotificationComponent> {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  final TextEditingController _textController = TextEditingController();
  final CollectionReference _tokensDB =
      FirebaseFirestore.instance.collection('Tokens');
  final FCMNotificationService _fcmNotificationService =
      FCMNotificationService();

  String _otherDeviceToken = "";

  @override
  void initState() {
    super.initState();

    //Subscribe to the NEWS topic.
    _fcmNotificationService.subscribeToTopic(topic: 'NEWS');

    load();
  }

  Future<void> load() async {
    //Request permission from user.
    if (Platform.isIOS) {
      _fcm.requestPermission();
    }

    //Fetch the fcm token for this device.
    String? token = await _fcm.getToken();

    //Validate that it's not null.
    assert(token != null);

    //Determine what device we are on.
    late String thisDevice;
    late String otherDevice;

    if (Platform.isIOS) {
      thisDevice = 'iOS';
      otherDevice = 'Android';
    } else {
      thisDevice = 'Android';
      otherDevice = 'iOS';
    }

    //Update fcm token for this device in firebase.
    DocumentReference docRef = _tokensDB.doc(thisDevice);
    docRef.set({'token': token});

    //Fetch the fcm token for the other device.
    DocumentSnapshot docSnapshot = await _tokensDB.doc(otherDevice).get();
    _otherDeviceToken = docSnapshot['token'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            // passing this to our root
            Navigator.of(context).pop();
          },
        ),
        title: const Align(
          alignment: Alignment.center,
          child: Text(
            'Notifications',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextField(
                controller: _textController,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  icon: const Icon(Icons.send),
                  label: const Text('Send Notification'),
                  onPressed: () async {
                    try {
                      await _fcmNotificationService.sendNotificationToUser(
                        title: 'New Notification!',
                        body: _textController.text,
                        fcmToken: _otherDeviceToken,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Notification sent.'),
                        ),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Error, ${e.toString()}.'),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
