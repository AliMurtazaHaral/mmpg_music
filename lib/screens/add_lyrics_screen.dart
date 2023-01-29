import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_app/model/realtime_database_model.dart';
import 'package:music_app/screens/step5_upload.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/user_model.dart';

class AddLyrics extends StatefulWidget {
  final String? docid;
  AddLyrics({Key? key, required this.docid}) : super(key: key);

  @override
  _AddLyricsState createState() => _AddLyricsState();
}

class _AddLyricsState extends State<AddLyrics> {
  final TextEditingController addLyricsController = TextEditingController();
  DatabaseModel databaseModel = DatabaseModel();
  final _auth = FirebaseAuth.instance;
  postDetailsToFirestore() async {
    // calling our firestore
    // calling our user model
    // sedning these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    // writing all the values
    userModel.lyrics = addLyricsController.text;

    await firebaseFirestore
        .collection("users")
        .doc(user?.uid)
        .update(userModel.toMap5_1a());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: const Color(0xFF161616),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            postDetailsToFirestore();
            databaseModel.addLyrics(addLyricsController.text.toString());
            // passing this to our root
            Navigator.of(context).pop();
          },
        ),
        title: const Align(
          alignment: Alignment.centerRight,
          child: Text('Step 5'),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: 500,
                  child: TextField(
                    maxLines: 17,
                    style: TextStyle(
                        fontSize: 15, height: 1.5, color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Type lyrics here',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                      ),
                      fillColor: Colors.white,
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: MediaQuery.of(context).size.height * 0.6,
                  decoration: const BoxDecoration(
                    color: Color(0xFF161616),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Expanded(
                      child: Column(
                        children: [
                          Row(
                            children: const [
                              Align(
                                child: Text(
                                  'Overview',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              ),
                              Align(
                                child: Text(
                                  '',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Align(
                            child: Text(
                              'To ensure lyrics are delivered and shown'
                              'correctly on digital music services, it is'
                              'important to follow the below guidelines.\n\n'
                              'Lyrics must match the audio, including'
                              'everything related to the vocals. This'
                              'includes but this is not limited to: spoken'
                              'phrases, emphasis, and spoken content'
                              'where applicable.',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 10),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Divider(
                            height: 1,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Align(
                                child: Text(
                                  'Formatting',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              ),
                              Align(
                                child: Text(
                                  '',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Align(
                            child: Text(
                              'All lyric lines should be single spaced'
                              'and double spaces should be used to'
                              'separate each section break.\n\n'
                              'Common section breaks are:\n\n'
                              '  • a defined chorus, verse or hook\n'
                              '  • change in artist delivery (singing to\n'
                              '    spoken word)\n'
                              '  • Change in tempo\n'
                              '  • Changes in beat/rhythm\n\n'
                              'The following grammatical rules'
                              'should be follow:\n\n'
                              '  • Lyric lines must begin with a leading\n'
                              '    capital\n'
                              '  • Nouns should be capitalized\n'
                              '  • Yelling or screaming should be indicated',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 10),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Divider(
              height: 1,
              color: Colors.grey,
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(1),
                  color: const Color(0xFF009AEE),
                  child: MaterialButton(
                    padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                    minWidth: 180,
                    onPressed: () {
                      postDetailsToFirestore();
                      databaseModel
                          .addLyrics(addLyricsController.text.toString());
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Step5Upload(
                                    docid: widget.docid,
                                  )));
                      //signIn(emailController.text, passwordController.text);
                    },
                    child: const Text(
                      "SAVE AND CLOSE",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 12,
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
    );
  }
}
