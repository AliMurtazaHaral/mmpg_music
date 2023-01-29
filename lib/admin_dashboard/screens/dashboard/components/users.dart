import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../model/user_model.dart';
import '../../main/components/side_menu.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Users extends StatefulWidget {
  const Users({Key? key}) : super(key: key);

  @override
  _UsersState createState() => _UsersState();
}

class _UsersState extends State<Users> {
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
            'Users',
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
                                                        UsersSection(
                                                          uid: streamSnapshot
                                                                  .data
                                                                  ?.docs[index]
                                                              ['uid'],
                                                          name: streamSnapshot
                                                                  .data
                                                                  ?.docs[index]
                                                              ['fullName'],
                                                          membership:
                                                              streamSnapshot
                                                                          .data
                                                                          ?.docs[
                                                                      index]
                                                                  ['payment'],
                                                          expiryDate:
                                                              streamSnapshot
                                                                          .data
                                                                          ?.docs[
                                                                      index][
                                                                  'expiryDate'],
                                                          earning: streamSnapshot
                                                                  .data
                                                                  ?.docs[index]
                                                              ['earning'],
                                                        )));
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

class UsersSection extends StatefulWidget {
  final String uid;
  final String name;
  final String membership;
  final String expiryDate;
  final String earning;
  const UsersSection(
      {Key? key,
      required this.name,
      required this.membership,
      required this.expiryDate,
      required this.uid,
      required this.earning})
      : super(key: key);

  @override
  _UsersSectionState createState() => _UsersSectionState();
}

class _UsersSectionState extends State<UsersSection> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController taskController = TextEditingController();
  final TextEditingController expiryDateController = TextEditingController();
  final TextEditingController membershipController = TextEditingController();
  final TextEditingController earningController = TextEditingController();
  UserModel loggedInUser = UserModel();
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(widget.uid)
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
            'Edit Users',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  "Account Details",
                  style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.normal,
                      fontSize: 20),
                ),
              ),
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: Text(
                  "This is real name and contact information",
                  style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.normal,
                      fontSize: 10),
                ),
              ),
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  "Full Name",
                  style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.normal,
                      fontSize: 13),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              autofocus: false,
              controller: nameController,
              keyboardType: TextInputType.text,
              validator: (value) {},
              onSaved: (value) {
                nameController.text = value!;
              },
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xFF161616),
                contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                hintText: "${widget.name}",
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
            const SizedBox(
              height: 20,
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: Text(
                  "Membership",
                  style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.normal,
                      fontSize: 13),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              autofocus: false,
              controller: membershipController,
              keyboardType: TextInputType.text,
              validator: (value) {
                if (value!.isEmpty) {
                  return ("Please Enter Membership");
                }
                // reg expression for email validation
                return null;
              },
              onSaved: (value) {
                membershipController.text = value!;
              },
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xFF161616),
                contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                hintText: "${widget.membership}",
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
            const SizedBox(
              height: 20,
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: Text(
                  "Expiry Date",
                  style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.normal,
                      fontSize: 13),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              autofocus: false,
              controller: expiryDateController,
              keyboardType: TextInputType.text,
              validator: (value) {
                if (value!.isEmpty) {
                  return ("Please Enter Your Expiry Date");
                }
                // reg expression for email validation
                return null;
              },
              onSaved: (value) {
                expiryDateController.text = value!;
              },
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xFF161616),
                contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                hintText: "${widget.expiryDate}",
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
            const SizedBox(
              height: 20,
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: Text(
                  "Royalty Balance",
                  style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.normal,
                      fontSize: 13),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              autofocus: false,
              controller: earningController,
              keyboardType: TextInputType.text,
              onSaved: (value) {
                earningController.text = value!;
              },
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xFF161616),
                contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                hintText: "${loggedInUser.earning}",
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
            const SizedBox(
              height: 20,
            ),
            Material(
              elevation: 5,
              borderRadius: BorderRadius.circular(10),
              color: Colors.blue,
              child: MaterialButton(
                padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                minWidth: MediaQuery.of(context).size.width,
                onPressed: () {
                  postDetailsToFirestore1();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Users(),
                    ),
                  );
                },
                child: const Text(
                  "Add Expiry Date",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
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
            Material(
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
                      builder: (context) => const Users(),
                    ),
                  );
                },
                child: const Text(
                  "Cancel Membership",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: TextFormField(
                autofocus: false,
                controller: taskController,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.length > 5000) {
                    return ("Please Enter Your Less Characters");
                  }
                  return null;
                },
                onSaved: (value) {
                  taskController.text = value!;
                },
                textInputAction: TextInputAction.next,
                maxLines: 10,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                  hintText: "Assign Task",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: null,
                    fontStyle: FontStyle.normal,
                  ),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Material(
              elevation: 5,
              borderRadius: BorderRadius.circular(10),
              color: Colors.blue,
              child: MaterialButton(
                  padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                  minWidth: MediaQuery.of(context).size.width * 1,
                  onPressed: () {
                    postDetailsToFirestoreTask();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Users(),
                      ),
                    );
                  },
                  child: const Text(
                    "Assign Task",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  )),
            )
          ],
        ),
      ),
    );
  }

  postDetailsToFirestore() async {
    UserModel userModel = UserModel();

    // writing all the values
    userModel.payment = "";
    userModel.type = "";
    await FirebaseFirestore.instance
        .collection("users")
        .doc(widget.uid)
        .update(userModel.toMapPayment());
  }

  postDetailsToFirestoreTask() async {
    UserModel userModel = UserModel();
    userModel.task = taskController.text;
    FirebaseFirestore.instance
        .collection("users")
        .doc(widget.uid)
        .update(userModel.toMapTask());
  }

  postDetailsToFirestore1() async {
    UserModel userModel = UserModel();

    // writing all the values
    userModel.expiryDate = expiryDateController.text;
    userModel.earning = earningController.text;
    FirebaseFirestore.instance
        .collection("users")
        .doc(widget.uid)
        .update(userModel.toMapExpiryDate());
    FirebaseFirestore.instance
        .collection("users")
        .doc(widget.uid)
        .update(userModel.toMapEarning());
  }
}
