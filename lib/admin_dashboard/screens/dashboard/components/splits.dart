import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../model/user_model.dart';
import '../../main/components/side_menu.dart';

class Splits extends StatefulWidget {
  const Splits({Key? key}) : super(key: key);

  @override
  _SplitsState createState() => _SplitsState();
}

class _SplitsState extends State<Splits> {
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
            'Split Pay',
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
                                                        SplitPay(
                                                            uid: streamSnapshot
                                                                .data
                                                                ?.docs[index]
                                                                .id)));
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

class SplitPay extends StatefulWidget {
  final String? uid;
  const SplitPay({Key? key, required this.uid}) : super(key: key);

  @override
  _SplitPayState createState() => _SplitPayState();
}

class _SplitPayState extends State<SplitPay> {
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
          .where('releaseTitle'.toString(),
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
    print(widget.uid);
    return Scaffold(
      backgroundColor: Colors.black,
      drawer: const SideMenu(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Align(
          alignment: Alignment.center,
          child: Text(
            'Split Pay',
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
                                            "${streamSnapshot.data?.docs[index]['releaseTitle']}",
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
                                                        SplitPayExplanation(
                                                            uid: widget.uid,
                                                            songId:
                                                                streamSnapshot
                                                                    .data
                                                                    ?.docs[
                                                                        index]
                                                                    .id,
                                                            songName:
                                                                streamSnapshot
                                                                            .data
                                                                            ?.docs[
                                                                        index][
                                                                    'title'])));
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

class SplitPayExplanation extends StatefulWidget {
  final String? uid;
  final String? songId;
  final String? songName;
  const SplitPayExplanation(
      {Key? key,
      required this.uid,
      required this.songId,
      required this.songName})
      : super(key: key);

  @override
  State<SplitPayExplanation> createState() => _SplitPayExplanationState();
}

class _SplitPayExplanationState extends State<SplitPayExplanation> {
  final artistPercentController = TextEditingController();
  final email1PercentController = TextEditingController();
  final email2PercentController = TextEditingController();
  final artistController = TextEditingController();
  final email1Controller = TextEditingController();
  final email2Controller = TextEditingController();
  UserModel loggedInUser = UserModel();
  @override
  void initState() {
    print(widget.uid);
    print(widget.songId);
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(widget.uid)
        .collection("songs")
        .doc(widget.songId)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
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
            'Payments',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.93,
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
                  Container(
                    width: MediaQuery.of(context).size.width * 0.93,
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0),
                        bottomLeft: Radius.circular(10.0),
                        bottomRight: Radius.circular(10.0),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "   ${widget.songName}",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                        child: Column(
                          children: [
                            Text(
                              "Revenue Share",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              width: 100,
                              child: Flexible(
                                child: TextFormField(
                                  style: TextStyle(color: Colors.white),
                                  autofocus: false,
                                  controller: artistPercentController,
                                  keyboardType: TextInputType.number,
                                  onSaved: (value) {
                                    artistPercentController.text = value!;
                                  },
                                  textInputAction: TextInputAction.next,
                                  decoration: InputDecoration(
                                    fillColor: Color(0xFF282828),
                                    filled: true,
                                    contentPadding:
                                        EdgeInsets.fromLTRB(20, 15, 20, 15),
                                    hintText:
                                        "${loggedInUser.revenueShareArtist}",
                                    hintStyle: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                      fontStyle: FontStyle.normal,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              width: 100,
                              child: Flexible(
                                child: TextFormField(
                                  style: TextStyle(color: Colors.white),
                                  autofocus: false,
                                  controller: email1PercentController,
                                  keyboardType: TextInputType.text,
                                  onSaved: (value) {
                                    email1PercentController.text = value!;
                                  },
                                  textInputAction: TextInputAction.next,
                                  decoration: InputDecoration(
                                    fillColor: Color(0xFF282828),
                                    filled: true,
                                    contentPadding:
                                        EdgeInsets.fromLTRB(20, 15, 20, 15),
                                    hintText:
                                        "${loggedInUser.revenueShareEmail1}",
                                    hintStyle: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                      fontStyle: FontStyle.normal,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              width: 100,
                              child: Flexible(
                                child: TextFormField(
                                  style: TextStyle(color: Colors.white),
                                  autofocus: false,
                                  controller: email2PercentController,
                                  keyboardType: TextInputType.number,
                                  onSaved: (value) {
                                    email2PercentController.text = value!;
                                  },
                                  textInputAction: TextInputAction.next,
                                  decoration: InputDecoration(
                                    fillColor: Color(0xFF282828),
                                    filled: true,
                                    contentPadding:
                                        EdgeInsets.fromLTRB(20, 15, 20, 15),
                                    hintText:
                                        "${loggedInUser.revenueShareEmail2}",
                                    hintStyle: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                      fontStyle: FontStyle.normal,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const VerticalDivider(
                        color: Colors.white,
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Collaborator",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              width: 250,
                              child: Flexible(
                                child: TextFormField(
                                  style: TextStyle(color: Colors.white),
                                  autofocus: false,
                                  controller: artistController,
                                  keyboardType: TextInputType.text,
                                  onSaved: (value) {
                                    artistController.text = value!;
                                  },
                                  textInputAction: TextInputAction.next,
                                  decoration: InputDecoration(
                                    fillColor: Color(0xFF282828),
                                    filled: true,
                                    contentPadding:
                                        EdgeInsets.fromLTRB(20, 15, 20, 15),
                                    hintText:
                                        "${loggedInUser.collaboratorArtist}",
                                    hintStyle: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                      fontStyle: FontStyle.normal,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              width: 250,
                              child: Flexible(
                                child: TextFormField(
                                  style: TextStyle(color: Colors.white),
                                  autofocus: false,
                                  controller: email1Controller,
                                  keyboardType: TextInputType.text,
                                  onSaved: (value) {
                                    email1Controller.text = value!;
                                  },
                                  textInputAction: TextInputAction.next,
                                  decoration: InputDecoration(
                                    fillColor: Color(0xFF282828),
                                    filled: true,
                                    contentPadding:
                                        EdgeInsets.fromLTRB(20, 15, 20, 15),
                                    hintText:
                                        "${loggedInUser.collaboratorEmail1}",
                                    hintStyle: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                      fontStyle: FontStyle.normal,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              width: 250,
                              child: Flexible(
                                child: TextFormField(
                                  style: TextStyle(color: Colors.white),
                                  autofocus: false,
                                  controller: email2Controller,
                                  keyboardType: TextInputType.text,
                                  onSaved: (value) {
                                    email2Controller.text = value!;
                                  },
                                  textInputAction: TextInputAction.next,
                                  decoration: InputDecoration(
                                    fillColor: Color(0xFF282828),
                                    filled: true,
                                    contentPadding:
                                        EdgeInsets.fromLTRB(20, 15, 20, 15),
                                    hintText:
                                        "${loggedInUser.collaboratorEmail2}",
                                    hintStyle: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                      fontStyle: FontStyle.normal,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
