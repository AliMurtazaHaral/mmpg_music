import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:music_app/screens/setting_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/user_model.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({Key? key}) : super(key: key);

  @override
  _HelpScreenState createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  final _formKey = GlobalKey<FormState>();
  User? user = FirebaseAuth.instance.currentUser;
  // firebase
  final _auth = FirebaseAuth.instance;
  final TextEditingController helpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //email field
    final emailField = Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: TextFormField(
        autofocus: false,
        controller: helpController,
        keyboardType: TextInputType.text,
        validator: (value) {
          if (value!.length > 5000) {
            return ("Please Enter Your Less Characters");
          }
          return null;
        },
        onSaved: (value) {
          helpController.text = value!;
        },
        textInputAction: TextInputAction.next,
        maxLines: 10,
        decoration: const InputDecoration(
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Your Message",
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: null,
            fontStyle: FontStyle.normal,
          ),
          border: OutlineInputBorder(),
        ),
      ),
    );

    final sendMessageButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(10),
      color: Colors.blue,
      child: MaterialButton(
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width * 0.2,
          onPressed: () {
            postDetailsToFirestore();
            Navigator.of(context).pop();
          },
          child: const Text(
            "Send Messages",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );

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
            'Help',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.black,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
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
                        child: Column(
                          children: [
                            const SizedBox(height: 10),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "     How can we help",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(height: 20),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "     Message",
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            emailField,
                            const Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "5000 Character(s) left    ",
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            const SizedBox(height: 25),
                            const SizedBox(height: 35),
                            Row(
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * .245,
                                ),
                                Material(
                                  elevation: 5,
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.transparent,
                                  child: MaterialButton(
                                    padding: const EdgeInsets.fromLTRB(
                                        20, 15, 20, 15),
                                    minWidth:
                                        MediaQuery.of(context).size.width * 0.2,
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const SettingPage(),
                                        ),
                                      );
                                    },
                                    child: const Text(
                                      "Cancel",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                sendMessageButton,
                              ],
                            ),
                            const SizedBox(height: 15),
                          ],
                        )),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  postDetailsToFirestore() async {
    UserModel userModel = UserModel();

    // writing all the values
    userModel.message = helpController.text;
    print(helpController.text);
    await FirebaseFirestore.instance
        .collection("users")
        .doc(user?.uid)
        .update(userModel.toMapMessage());
  }
}
