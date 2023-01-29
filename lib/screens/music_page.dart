import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:music_app/screens/smart_link_screen.dart';
import 'package:music_app/screens/storage_class.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/user_model.dart';

class MusicPage extends StatefulWidget {
  const MusicPage({Key? key}) : super(key: key);

  @override
  _MusicPageState createState() => _MusicPageState();
}

class _MusicPageState extends State<MusicPage> {
  String url = "";
  String urlS = "";
  bool showPlay = false;
  bool showPause = true;
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  AssetsAudioPlayer player = AssetsAudioPlayer();

  getImg(String s) async {
    final ref =
        firebase_storage.FirebaseStorage.instance.ref('music/images/').child(s);
    url = await ref.getDownloadURL();
  }

  Color? pending = Colors.white;
  Color? approved = Colors.white;
  Color? released = Colors.white;
  Color? backg = Colors.black;
  Color? backg1 = Colors.black;
  Color? backg2 = Colors.black;
  late Stream<QuerySnapshot<Map<String, dynamic>>> songsList;
  @override
  void initState() {
    super.initState();
    songsList = FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .collection("songs")
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    void colors(String status) {
      if (status == "Pending") {
        pending = Colors.orange;
        approved = Colors.white;
        released = Colors.white;
        backg1 = Colors.white;
      }
      if (status == "Approved") {
        pending = Colors.white;
        approved = Colors.green;
        released = Colors.white;
        backg = Colors.white;
      }
      if (status == "Released") {
        pending = Colors.white;
        approved = Colors.white;
        released = Colors.red;
        backg2 = Colors.white;
      }
    }

    int songListLength = 0;
    if (songsList.length != null) {
      songListLength = 1;
    }

    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width * 0.93,
              decoration: const BoxDecoration(
                color: Color(0xFF161616),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                  ),
                  const Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Artists/Tracks',
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                  Image.asset(
                    "assets/square.PNG",
                    width: 40,
                    height: 40,
                  ),
                ],
              ),
            ),
            (songListLength > 0)
                ? StreamBuilder(
                    stream: songsList,
                    builder:
                        (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                      int len =
                          int.parse("${streamSnapshot.data?.docs.length}");
                      return Container(
                        padding: const EdgeInsets.all(20),
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: len,
                            itemBuilder: (BuildContext context, int index) {
                              colors(
                                  "${streamSnapshot.data?.docs[index]["pending"].toString()}");
                              getImg(
                                  "${streamSnapshot.data?.docs[index]["imageReference"]}");
                              return (streamSnapshot.data?.docs[index]
                                          ["pending"] !=
                                      "")
                                  ? Column(
                                      key: ValueKey(
                                          streamSnapshot.data?.docs[index].id),
                                      children: [
                                        Center(
                                          child: Column(
                                            children: [
                                              const SizedBox(
                                                height: 30,
                                              ),
                                              Container(
                                                width: 450,
                                                decoration: const BoxDecoration(
                                                  color: Color(0xFF161616),
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(10.0),
                                                    topRight:
                                                        Radius.circular(10.0),
                                                    bottomLeft:
                                                        Radius.circular(10.0),
                                                    bottomRight:
                                                        Radius.circular(10.0),
                                                  ),
                                                ),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  20),
                                                          child: Align(
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              child: (url != "")
                                                                  ? Image
                                                                      .network(
                                                                      url,
                                                                      height:
                                                                          200,
                                                                      width:
                                                                          200,
                                                                    )
                                                                  : Container(),
                                                            ),
                                                          ),
                                                        ),
                                                        Column(
                                                          children: const [
                                                            Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .fromLTRB(
                                                                          0,
                                                                          20,
                                                                          10,
                                                                          0),
                                                              child: Align(
                                                                alignment:
                                                                    Alignment
                                                                        .topRight,
                                                                child: Text(
                                                                  "2022",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          20,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .fromLTRB(
                                                                          0,
                                                                          0,
                                                                          10,
                                                                          0),
                                                              child: Align(
                                                                alignment: Alignment
                                                                    .centerRight,
                                                                child: Text(
                                                                  "   12 Feb",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .grey,
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal),
                                                                ),
                                                              ),
                                                            ),
                                                            Text(
                                                              "",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                  fontSize: 120,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(height: 30),
                                                    Row(
                                                      children: [
                                                        const SizedBox(
                                                            width: 40),
                                                        Container(
                                                          height: 20,
                                                          width: 20,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: approved,
                                                            borderRadius:
                                                                const BorderRadius
                                                                    .only(
                                                              topLeft: Radius
                                                                  .circular(
                                                                      2.0),
                                                              topRight: Radius
                                                                  .circular(
                                                                      2.0),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          2.0),
                                                              bottomLeft: Radius
                                                                  .circular(
                                                                      2.0),
                                                            ),
                                                          ),
                                                          child: Text(
                                                            " A",
                                                            style: TextStyle(
                                                                color: backg,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            width: 10),
                                                        Container(
                                                          height: 20,
                                                          width: 20,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: pending,
                                                            borderRadius:
                                                                const BorderRadius
                                                                    .only(
                                                              topLeft: Radius
                                                                  .circular(
                                                                      2.0),
                                                              topRight: Radius
                                                                  .circular(
                                                                      2.0),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          2.0),
                                                              bottomLeft: Radius
                                                                  .circular(
                                                                      2.0),
                                                            ),
                                                          ),
                                                          child: Text(
                                                            " P",
                                                            style: TextStyle(
                                                                color: backg1,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            width: 10),
                                                        Container(
                                                          height: 20,
                                                          width: 20,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: released,
                                                            borderRadius:
                                                                const BorderRadius
                                                                    .only(
                                                              topLeft: Radius
                                                                  .circular(
                                                                      2.0),
                                                              topRight: Radius
                                                                  .circular(
                                                                      2.0),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          2.0),
                                                              bottomLeft: Radius
                                                                  .circular(
                                                                      2.0),
                                                            ),
                                                          ),
                                                          child: Text(
                                                            " R",
                                                            style: TextStyle(
                                                                color: backg2,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Padding(
                                                          padding: EdgeInsets
                                                              .fromLTRB(40, 20,
                                                                  20, 20),
                                                          child: Align(
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            child: Text(
                                                              "${streamSnapshot.data?.docs[index]["title"]}/${streamSnapshot.data?.docs[index]["primaryArtist"]}",
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 20),
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsets
                                                              .fromLTRB(
                                                                  0, 0, 20, 0),
                                                          child: Container(
                                                            width: 25,
                                                            height: 25,
                                                            decoration:
                                                                const BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        50.0),
                                                                topRight: Radius
                                                                    .circular(
                                                                        50.0),
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        50.0),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        50.0),
                                                              ),
                                                            ),
                                                            child:
                                                                GestureDetector(
                                                              onTap: () {
                                                                Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                    builder: (context) => SmartLink(
                                                                        songId: streamSnapshot
                                                                            .data
                                                                            ?.docs[index]
                                                                            .id),
                                                                  ),
                                                                );
                                                              },
                                                              child: const Icon(
                                                                Icons
                                                                    .arrow_forward,
                                                                color: Colors
                                                                    .black,
                                                                size: 15,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                      ],
                                    )
                                  : Container();
                            }),
                      );
                    })
                : Container(),
          ],
        ),
      ),
    );
  }
}
