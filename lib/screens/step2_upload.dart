import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:music_app/model/realtime_database_model.dart';
import 'package:music_app/screens/step1_upload.dart';
import 'package:music_app/screens/step3_upload.dart';
import 'package:music_app/screens/storage_class.dart';
import 'package:music_app/screens/upload_screen.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';

import '../model/user_model.dart';
import 'dashboard.dart';

class Step2Upload extends StatefulWidget {
  final String? docid;
  Step2Upload({Key? key, required this.docid}) : super(key: key);

  @override
  _Step2UploadState createState() => _Step2UploadState();
}

class _Step2UploadState extends State<Step2Upload> {
  DatabaseModel databaseModel = DatabaseModel();
  late Reference getUrl;
  String a = "";
  final _auth = FirebaseAuth.instance;
  postDetailsToFirestore() async {
    // calling our firestore
    // calling our user model
    // sedning these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    // writing all the values
    userModel.audioReference = getUrl.fullPath.toString();

    await firebaseFirestore
        .collection("users")
        .doc(user?.uid)
        .collection("songs")
        .doc(widget.docid)
        .update(userModel.toMap2());
  }

  @override
  Widget build(BuildContext context) {
    final Storage storage = Storage();
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
                          postDetailsToFirestore();
                          databaseModel.s2(getUrl.fullPath.toString());
                          // passing this to our root
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
                          'Step 2',
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
                "      Audio Files",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Please ensure that the audio file is stereo WAV that is at least 16-bit/44.1KHz"
                  "We accept upto 24-bit/96 KHz and recommend uploading your highest"
                  "highest quality files.\n\n"
                  "The upload process will begin when you enter your release.\n\n"
                  "All metadata associated with those tracks will be retained and grayed out"
                  "during this upload.",
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 20, 20, 0),
              child: Image.asset(
                "assets/second.PNG",
                width: 500,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.fromLTRB(30, 0, 20, 20),
                child: Material(
                  elevation: 5,
                  //borderRadius: BorderRadius.circular(10),
                  color: const Color(0xFF009AEE),
                  child: MaterialButton(
                      padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                      minWidth: 150,
                      onPressed: () async {
                        final result = await FilePicker.platform.pickFiles(
                          allowMultiple: false,
                          type: FileType.custom,
                          allowedExtensions: ['mp3', 'wav'],
                        );
                        if (result == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('no file selected'),
                            ),
                          );
                        } else {
                          final path = result?.files.single.path;
                          final fileName = result?.files.single.name;
                          storage
                              .uploadFileAudio(path, fileName)
                              .then((value) => const SnackBar(
                                    content: Text(
                                        "FIle Has been uploaded successfully"),
                                  ));
                        }
                        //signIn(emailController.text, passwordController.text);
                      },
                      child: const Text(
                        "+ BROWSE TRACKS",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      )),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "      Your Files",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "\n        Review your audio files below. You can change their order and other details\n        later",
                style: TextStyle(color: Colors.grey, fontSize: 11),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            DottedBorder(
              color: Colors.grey,
              strokeWidth: 1,
              child: Material(
                elevation: 5,
                //borderRadius: BorderRadius.circular(10),
                color: Colors.transparent,
                child: MaterialButton(
                  padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                  minWidth: MediaQuery.of(context).size.width * 0.93,
                  height: 300,
                  onPressed: () async {
                    final result = await FilePicker.platform.pickFiles(
                      allowMultiple: false,
                      type: FileType.custom,
                      allowedExtensions: ['wav', 'mp3'],
                    );
                    if (result == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('no file selected'),
                        ),
                      );
                    } else {
                      final path = result?.files.single.path;
                      final fileName = result?.files.single.name;
                      storage
                          .uploadFileAudio(path, fileName)
                          .then((value) => const SnackBar(
                                content:
                                    Text("FIle Has been uploaded successfully"),
                              ));
                      getUrl = FirebaseStorage.instance.ref().child(fileName!);
                      a = "1";
                    }
                    //signIn(emailController.text, passwordController.text);
                  },
                  child: (a == "")
                      ? Image.asset("assets/pickAudio.PNG")
                      : Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Image.asset("assets/uploaded.PNG"),
                                    Text(getUrl.fullPath.toString()),
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () {
                                    a = "";
                                  },
                                  child: Image.asset("assets/deleteUpload.PNG"),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                ),
              ),
            ),
            const MySeparator(color: Colors.grey),
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
                  padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset("assets/homeUpload.PNG",
                          width: MediaQuery.of(context).size.width * 0.15),
                      const SizedBox(
                        width: 30,
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                        child: Row(
                          children: [
                            Material(
                              elevation: 5,
                              borderRadius: BorderRadius.circular(10),
                              color: const Color(0xFF009AEE),
                              child: MaterialButton(
                                minWidth:
                                    MediaQuery.of(context).size.width * 0.3,
                                padding:
                                    const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Step1Upload(
                                                docid: widget.docid,
                                              )));
                                  //signIn(emailController.text, passwordController.text);
                                },
                                child: const Text(
                                  "Previous",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Material(
                                elevation: 5,
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0xFF009AEE),
                                child: MaterialButton(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                  minWidth:
                                      MediaQuery.of(context).size.width * 0.3,
                                  onPressed: () {
                                    postDetailsToFirestore();
                                    //databaseModel.s2(getUrl.fullPath.toString());
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Step3Upload(
                                                  docid: widget.docid,
                                                )));
                                    //signIn(emailController.text, passwordController.text);
                                  },
                                  child: const Text(
                                    "Next",
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
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MySeparator extends StatelessWidget {
  final double height;
  final Color color;

  const MySeparator({this.height = 1, this.color = Colors.black});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        final dashWidth = 2.0;
        final dashHeight = height;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
        );
      },
    );
  }
}
