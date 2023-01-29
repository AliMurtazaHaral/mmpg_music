import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_app/screens/dashboard.dart';
import 'package:music_app/screens/home_screen.dart';
import 'package:music_app/screens/smart_link_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../model/user_model.dart';

class Step6Upload extends StatefulWidget {
  final String? docid;
  const Step6Upload({Key? key, required this.docid}) : super(key: key);

  @override
  _Step6UploadState createState() => _Step6UploadState();
}

class _Step6UploadState extends State<Step6Upload> {
  late DateTime dateTime;
  bool isChecked = false;
  bool isChecked1 = false;
  String releasePlan = "";
  DateTime selectedDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  postDetailsToFirestore() async {
    // calling our firestore
    // calling our user model
    // sending these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = FirebaseAuth.instance.currentUser;

    UserModel userModel = UserModel();

    // writing all the values
    userModel.releasePlan = releasePlan;
    userModel.date = dateTime.toString();

    await firebaseFirestore
        .collection("users")
        .doc(user?.uid)
        .collection("songs")
        .doc(widget.docid)
        .update(userModel.toMap6());
  }

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.white;
    }

    _selectDate(BuildContext context) async {
      final DateTime? selected = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2010),
        lastDate: DateTime(2025),
      );
      if (selected != null && selected != selectedDate)
        setState(() {
          selectedDate = selected;
        });
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFF161616),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(12, 0, 0, 0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Dashboard()));
                        },
                        child: Image.asset("assets/backButton.PNG"),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'Step 6',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "      Release Plan",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "\n        Create a plan for when you want your music out there"
                "\n\n        Choose the dates that will support your marketing and promotion plans.",
                style: TextStyle(color: Colors.grey, fontSize: 10),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 20, 20, 0),
              child: Image.asset(
                "assets/sixth.PNG",
                width: 500,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 35,
                ),
                Container(
                  width: 200,
                  height: 350,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Color(0xFF00abe9)),
                    onPressed: () {
                      _selectDate(context);
                      releasePlan = "Simple";
                    },
                    child: Column(
                      children: [
                        SizedBox(
                          height: 80,
                        ),
                        Image.asset("assets/simple.PNG"),
                        const Text(
                          'SIMPLE',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              " If you don't require a pre-order\n   date for your release, this is \n               the plan for you",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          '✔ Release date',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  width: 200,
                  height: 350,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Color(0xFF00abe9)),
                    onPressed: () {
                      releasePlan = "Custom";
                      showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2022));
                    },
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 80,
                        ),
                        Image.asset("assets/simple.PNG"),
                        const Text(
                          'CUSTOM',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(0),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "  Plan your release and pre-order\n"
                              '    dates around your marketing \n'
                              '                 and promotions',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          '✔ Release date\n✔Pre-order plan',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.85,
              decoration: const BoxDecoration(
                color: Color(0xFF161616),
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(30),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Terms & Conditions',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Row(
                      children: [
                        Checkbox(
                          checkColor: Colors.blue,
                          fillColor:
                              MaterialStateProperty.resolveWith(getColor),
                          value: isChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              isChecked = value!;
                            });
                          },
                        ),
                        const Flexible(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '    I confirmed that this submission has been checked, is correct, and I\n'
                              '    understand that it may not be possible to amend once the product has\n'
                              '    been sent to services.',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 8,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Row(
                      children: [
                        Checkbox(
                          checkColor: Colors.blue,
                          fillColor:
                              MaterialStateProperty.resolveWith(getColor),
                          value: isChecked1,
                          onChanged: (bool? value) {
                            setState(() {
                              isChecked1 = value!;
                            });
                          },
                        ),
                        const Flexible(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '    I confirm that I have all the necessary rights to submit this product for\n'
                              '    distribution',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 8,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFF161616),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                    bottomLeft: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 5, 10, 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset("assets/homeUpload.PNG"),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Material(
                          elevation: 5,
                          borderRadius: BorderRadius.circular(10),
                          color: const Color(0xFF009AEE),
                          child: MaterialButton(
                            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                            minWidth: MediaQuery.of(context).size.width * 0.35,
                            onPressed: () {
                              postDetailsToFirestore();
                              postDetailsToFirestore1();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Dashboard()));
                              //signIn(emailController.text, passwordController.text);
                            },
                            child: const Text(
                              "Submit",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  postDetailsToFirestore1() async {
    UserModel userModel = UserModel();
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = FirebaseAuth.instance.currentUser;
    // writing all the values
    userModel.pending = "Pending";
    await FirebaseFirestore.instance
        .collection("users")
        .doc(user?.uid)
        .collection("songs")
        .doc(widget.docid)
        .update(userModel.toMapPendings());
  }
}
