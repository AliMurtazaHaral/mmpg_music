import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PushNotification extends StatefulWidget {
  const PushNotification({Key? key}) : super(key: key);

  @override
  _PushNotificationState createState() => _PushNotificationState();
}

class _PushNotificationState extends State<PushNotification> {
  bool valNotify = false;

  void onChangeFunction(bool newValue) {
    setState(() {
      valNotify = newValue;
    });
  }

  final _formKey = GlobalKey<FormState>();
  // firebase
  final _auth = FirebaseAuth.instance;
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
            'Notification',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Container(
          decoration: const BoxDecoration(
            color: Color(0xFF161616),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
              bottomLeft: Radius.circular(10.0),
              bottomRight: Radius.circular(10.0),
            ),
          ),
          child: buildNotification(
              "PUSH NOTIFICATION", valNotify, onChangeFunction)),
    );
  }

  Padding buildNotification(String title, bool value, Function onChangeMethod) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Transform.scale(
            scale: 0.7,
            child: CupertinoSwitch(
              value: value,
              activeColor: Colors.blue,
              trackColor: Colors.grey,
              onChanged: (bool newValue) {
                onChangeMethod(newValue);
              },
            ),
          ),
        ],
      ),
    );
  }
}
