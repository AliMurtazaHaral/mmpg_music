import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_app/model/realtime_database_model.dart';
import 'package:music_app/screens/dashboard.dart';
import 'package:music_app/screens/home_page.dart';
import 'package:music_app/screens/step2_upload.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:music_app/screens/storage_class.dart';
import 'package:music_app/screens/upload_screen.dart';
import 'package:path/path.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';

import '../model/user_model.dart';

class Step1Upload extends StatefulWidget {
  final String? docid;
  const Step1Upload({Key? key, required this.docid}) : super(key: key);

  @override
  _Step1UploadState createState() => _Step1UploadState();
}

class _Step1UploadState extends State<Step1Upload> {
  final releaseTitleController = TextEditingController();
  DatabaseModel databaseModel = DatabaseModel();
  late Reference getUrl;
  final _auth = FirebaseAuth.instance;
  postDetailsToFirestore() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    // writing all the values
    userModel.releaseTitle = releaseTitleController.text;
    userModel.imageReference = getUrl.fullPath.toString();
    print('this is song step1 ${widget.docid}');
    await firebaseFirestore
        .collection("users")
        .doc(user?.uid)
        .collection('songs')
        .doc(widget.docid)
        .update(userModel.toMap1());
  }

  @override
  Widget build(BuildContext context) {
    final Storage storage = Storage();

    print("this is doc sid ${widget.docid}");
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
                          databaseModel.s1(
                              releaseTitleController.text.toString(),
                              getUrl.fullPath.toString());
                          postDetailsToFirestore();
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
                          'Step 1',
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
                "      Basics",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "      Let's start with some basic information about your release",
                style: TextStyle(color: Colors.grey),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 20, 20, 0),
              child: Image.asset(
                "assets/first.PNG",
                width: 500,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "      Release title",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextFormField(
                autofocus: false,
                controller: releaseTitleController,
                keyboardType: TextInputType.name,
                validator: (value) {
                  if (value!.isEmpty) {
                    return ("Second Name cannot be Empty");
                  }
                  return null;
                },
                onSaved: (value) {
                  releaseTitleController.text = value!;
                },
                style: TextStyle(color: Colors.white),
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  fillColor: Color(0xFF161616),
                  filled: true,
                  contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                  hintText: "Name your release",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            const Padding(
              padding: EdgeInsets.all(20),
              child: Divider(
                height: 1,
                color: Colors.grey,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "      Add cover art\n",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "        Add your cover art to your release. Make sure your image is high quality, a square, and\n        void of:"
                "\n\n          1. Blurriness/Pixelation\n          2. Text that doesn't match your metadata\n          3. Uneven borders",
                style: TextStyle(color: Colors.grey, fontSize: 10),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            DottedBorder(
              color: Colors.grey,
              strokeWidth: 1,
              child: Padding(
                padding: EdgeInsets.all(5),
                child: Material(
                  elevation: 5,
                  //borderRadius: BorderRadius.circular(10),
                  color: Color(0xFF161616),
                  child: MaterialButton(
                    padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                    minWidth: 450,
                    height: 200,
                    onPressed: () async {
                      final result = await FilePicker.platform.pickFiles(
                        allowMultiple: false,
                        type: FileType.custom,
                        allowedExtensions: ['jpg', 'png'],
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
                            .uploadFileImage(path, fileName)
                            .then((value) => const SnackBar(
                                  content: Text(
                                      "FIle Has been uploaded successfully"),
                                ));
                        getUrl =
                            FirebaseStorage.instance.ref().child(fileName!);
                      }
                      //signIn(emailController.text, passwordController.text);
                    },
                    child: Image.asset("assets/pickImage.PNG"),
                  ),
                ),
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
                  padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset("assets/homeUpload.PNG"),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Material(
                            elevation: 5,
                            borderRadius: BorderRadius.circular(10),
                            color: const Color(0xFF009AEE),
                            child: MaterialButton(
                              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                              minWidth: MediaQuery.of(context).size.width * 0.3,
                              onPressed: () {
                                databaseModel.s1(
                                    releaseTitleController.text.toString(),
                                    getUrl.fullPath.toString());
                                postDetailsToFirestore();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            Step2Upload(docid: widget.docid)));
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
}
