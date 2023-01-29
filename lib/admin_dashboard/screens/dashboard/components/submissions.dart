import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/services.dart';
import '../../../../model/user_model.dart';
import '../../../constants.dart';
import '../../main/components/side_menu.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:url_launcher/url_launcher.dart';

class Submissions extends StatefulWidget {
  const Submissions({Key? key}) : super(key: key);

  @override
  _SubmissionsState createState() => _SubmissionsState();
}

class _SubmissionsState extends State<Submissions> {
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
            'Submissions',
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
                width: MediaQuery.of(context).size.width * .93,
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
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    SubmittedSongList(
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
                                                  "Manage",
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

class SubmittedSongList extends StatefulWidget {
  final String uid;
  const SubmittedSongList({Key? key, required this.uid}) : super(key: key);

  @override
  _SubmittedSongListState createState() => _SubmittedSongListState();
}

class _SubmittedSongListState extends State<SubmittedSongList> {
  late Stream<QuerySnapshot<Map<String, dynamic>>> _foundUsers =
      FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .collection('songs')
          .snapshots();
  late final Stream<QuerySnapshot<Map<String, dynamic>>> _allUsers =
      FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .collection('songs')
          .snapshots();
  void _runFilter(String enteredKeyword) {
    Stream<QuerySnapshot<Map<String, dynamic>>> results = FirebaseFirestore
        .instance
        .collection('users')
        .doc(widget.uid)
        .collection('songs')
        .snapshots();
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = _allUsers;
    } else {
      // we use the toLowerCase() method to make it case-insensitive
      results = FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .collection('songs')
          .where('audioReference'.toString(),
              isEqualTo: '$enteredKeyword'.toString())
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
            'Submissions',
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
                width: MediaQuery.of(context).size.width * .93,
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
                                            "${index + 1}: ${streamSnapshot.data?.docs[index]['title']}",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    SubmittedSong(
                                                  uid: streamSnapshot
                                                      .data?.docs[index].id,
                                                  mainUid: widget.uid,
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
                                                  "Manage",
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

class SubmittedSong extends StatefulWidget {
  final String? uid;
  final String? mainUid;
  const SubmittedSong({Key? key, required this.uid, required this.mainUid})
      : super(key: key);

  @override
  _SubmittedSongState createState() => _SubmittedSongState();
}

class _SubmittedSongState extends State<SubmittedSong> {
  String audioUrl = "", imageUrl = "";
  final _formKey = GlobalKey<FormState>();
  UserModel loggedInUser = UserModel();
  late final Stream<QuerySnapshot<Map<String, dynamic>>> _foundUsers =
      FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .collection('songs')
          .snapshots();
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(widget.mainUid)
        .collection("songs")
        .doc(widget.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromSongMap(value.data());
    });
  }

  @override
  Widget build(BuildContext context) {
    print("thi is ${widget.uid}");
    print("thi is ${widget.mainUid}");
    return Scaffold(
      backgroundColor: Colors.black,
      drawer: const SideMenu(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Align(
          alignment: Alignment.center,
          child: Text(
            'Submissions',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Column(
              children: [
                const Text(
                  "Release Title",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                Text(
                  loggedInUser.releaseTitle.toString(),
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.normal),
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
                const Text(
                  "Image Link",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      MediaQuery.of(context).size.width * .45, 0, 0, 0),
                  child: GestureDetector(
                    onTap: () async {
                      imageUrlGet(loggedInUser.imageReference.toString());
                      Clipboard.setData(ClipboardData(text: imageUrl));
                      final url = imageUrl;
                      if (await canLaunch(url)) {
                        await launch(
                          url,
                          forceSafariVC: false,
                        );
                      }
                    },
                    child: Row(
                      children: const [
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "Image",
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.normal,
                                fontSize: 15,
                                decoration: TextDecoration.underline),
                          ),
                        ),
                      ],
                    ),
                  ),
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
                const Text(
                  "Audio Link",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      MediaQuery.of(context).size.width * .45, 0, 0, 0),
                  child: GestureDetector(
                    onTap: () async {
                      imageUrlGet(loggedInUser.audioReference.toString());
                      Clipboard.setData(ClipboardData(text: imageUrl));
                      final url = imageUrl;
                      if (await canLaunch(url)) {
                        await launch(
                          url,
                          forceSafariVC: false,
                        );
                      }
                    },
                    child: Row(
                      children: const [
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "Audio",
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.normal,
                                fontSize: 15,
                                decoration: TextDecoration.underline),
                          ),
                        ),
                      ],
                    ),
                  ),
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
                const Text(
                  "Primary Artist",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                Text(
                  loggedInUser.primaryArtist.toString(),
                  style: TextStyle(color: Colors.white, fontSize: 19),
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
                const Text(
                  "Title",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                Text(
                  loggedInUser.title.toString(),
                  style: TextStyle(color: Colors.white, fontSize: 19),
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
                const Text(
                  "Release Label",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                Text(
                  loggedInUser.releaseLabel.toString(),
                  style: TextStyle(color: Colors.white, fontSize: 19),
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
                const Text(
                  "Copyright Holder",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                Text(
                  loggedInUser.copyrightHolder.toString(),
                  style: TextStyle(color: Colors.white, fontSize: 19),
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
                const Text(
                  "Genre",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                Text(
                  loggedInUser.genre.toString(),
                  style: TextStyle(color: Colors.white, fontSize: 19),
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
                const Text(
                  "Track Title",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                Text(
                  loggedInUser.trackTitle.toString(),
                  style: TextStyle(color: Colors.white, fontSize: 19),
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
                const Text(
                  "Parental Advisory",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                Text(
                  loggedInUser.parentalAdvistory.toString(),
                  style: TextStyle(color: Colors.white, fontSize: 19),
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
                const Text(
                  "Writer",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                Text(
                  loggedInUser.writer.toString(),
                  style: TextStyle(color: Colors.white, fontSize: 19),
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
                const Text(
                  "Role",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                Text(
                  loggedInUser.role.toString(),
                  style: TextStyle(color: Colors.white, fontSize: 19),
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
                const Text(
                  "Lyrics",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                Text(
                  loggedInUser.lyrics.toString(),
                  style: TextStyle(color: Colors.white, fontSize: 19),
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
                const Text(
                  "Release Plan",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                Text(
                  loggedInUser.releasePlan.toString(),
                  style: const TextStyle(color: Colors.white, fontSize: 19),
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
                const Text(
                  "UPC",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                Text(
                  loggedInUser.upc.toString(),
                  style: const TextStyle(color: Colors.white, fontSize: 19),
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
                const Text(
                  "Date",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                Text(
                  loggedInUser.date.toString(),
                  style: TextStyle(color: Colors.white, fontSize: 19),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  imageUrlGet(String urls) async {
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child("music/images/$urls");
    imageUrl = (await ref.getDownloadURL()).toString();
  }

  audioUrlGet(String urls) async {
    late firebase_storage.Reference ref = firebase_storage
        .FirebaseStorage.instance
        .ref()
        .child("music/audio/$urls");
    audioUrl = (await ref.getDownloadURL()).toString();
  }
}

class SubmissionSection extends StatefulWidget {
  final String? songId;
  final String uid;
  final String pending;
  const SubmissionSection(
      {Key? key,
      required this.uid,
      required this.pending,
      required this.songId})
      : super(key: key);

  @override
  _SubmissionSectionState createState() => _SubmissionSectionState();
}

class _SubmissionSectionState extends State<SubmissionSection> {
  final TextEditingController pendingController = TextEditingController();

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
            'Submissions',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 140,
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: TextFormField(
                autofocus: false,
                controller: pendingController,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return ("Please Enter Your Expiry Date");
                  }
                  // reg expression for email validation
                  return null;
                },
                onSaved: (value) {
                  pendingController.text = value!;
                },
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFF161616),
                  contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                  hintText: "${widget.pending}",
                  hintStyle: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                    fontStyle: FontStyle.normal,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(10),
                color: Colors.blue,
                child: MaterialButton(
                  padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                  minWidth: MediaQuery.of(context).size.width,
                  onPressed: () {
                    postDetailsToFirestore();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Submissions(),
                      ),
                    );
                  },
                  child: const Text(
                    "Update",
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
    );
  }

  postDetailsToFirestore() async {
    UserModel userModel = UserModel();

    // writing all the values
    userModel.pending = pendingController.text;

    await FirebaseFirestore.instance
        .collection("users")
        .doc(widget.uid)
        .collection("songs")
        .doc(widget.songId)
        .update(userModel.toMapPendings());
  }
}
