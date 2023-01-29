import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';
import '../admin_dashboard/constants.dart';
import '../model/payment_history.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PayoutPage extends StatefulWidget {
  const PayoutPage({Key? key}) : super(key: key);

  @override
  _PayoutPageState createState() => _PayoutPageState();
}

class _PayoutPageState extends State<PayoutPage> {
  late Stream<QuerySnapshot<Map<String, dynamic>>> statements =
      FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .collection("statements")
          .snapshots();
  late Stream<QuerySnapshot<Map<String, dynamic>>> songs = FirebaseFirestore
      .instance
      .collection('users')
      .doc(user!.uid)
      .collection("songs")
      .snapshots();
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
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
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(
                width: 95,
              ),
              const Align(
                alignment: Alignment.center,
                child: Text(
                  'Payments',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                width: 140,
              ),
              Image.asset(
                "assets/square.PNG",
                width: 40,
                height: 40,
              ),
            ],
          )),
      body: SingleChildScrollView(
        child: Center(
          child: Column(children: [
            Container(
              width: 450,
              height: 200,
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
                  const SizedBox(
                    height: 10,
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "  Payment",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "   To set yourself up for payment, connect to your Paypal",
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.normal,
                          fontSize: 12),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Material(
                    shape: (const RoundedRectangleBorder(
                      side: BorderSide(color: Colors.grey, width: 1),
                    )),
                    elevation: 5,
                    //borderRadius: BorderRadius.circular(10),
                    color: Colors.transparent,
                    child: MaterialButton(
                      padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                      minWidth: 300,
                      height: 70,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ConnectPaypal()));
                      },
                      child: const Text(
                        "Connect to Paypal",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              child: (loggedInUser.pending.toString() == "Released" ||
                      loggedInUser.pending.toString() == "Pending" ||
                      loggedInUser.pending.toString() == "Approved")
                  ? Container(
                      width: MediaQuery.of(context).size.width * 0.93,
                      height: 400,
                      decoration: const BoxDecoration(
                        color: Color(0xFF161616),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0),
                          bottomLeft: Radius.circular(10.0),
                          bottomRight: Radius.circular(10.0),
                        ),
                      ),
                    )
                  : Container(),
            ),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      "Split Pay",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 0, 20),
                    child: Text(
                      "All tracks with active royalty splits will appear here",
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.normal,
                          fontSize: 15),
                    ),
                  ),
                  const Padding(
                      padding: EdgeInsets.all(20),
                      child: Divider(
                        height: 1,
                        color: Colors.grey,
                      )),
                  StreamBuilder(
                      stream: songs,
                      builder: (context,
                          AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                        int len =
                            int.parse("${streamSnapshot.data?.docs.length}");
                        return Container(
                          padding: const EdgeInsets.all(20),
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: len,
                              itemBuilder: (BuildContext context, int index) {
                                return Column(
                                  key: ValueKey(
                                      streamSnapshot.data?.docs[index].id),
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "${index + 1} ${streamSnapshot.data!.docs[index]["title"]}/${streamSnapshot.data!.docs[index]["primaryArtist"]}",
                                            style: const TextStyle(
                                                color: Colors.grey,
                                                fontSize: 10),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            GestureDetector(
                                              onTap: () => {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) => SPlitPay(
                                                            uid: streamSnapshot
                                                                .data!
                                                                .docs[index]
                                                                .id,
                                                            songName: streamSnapshot
                                                                    .data!
                                                                    .docs[index]
                                                                ["title"]))),
                                              },
                                              child: Image.asset(
                                                "assets/splitPay.PNG",
                                                height: 35,
                                              ),
                                            ),
                                            GestureDetector(
                                              child: const Icon(
                                                Icons.delete,
                                                color: Colors.white,
                                                size: 25,
                                              ),
                                            ),
                                          ],
                                        )
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
                                );
                              }),
                        );
                      }),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              child: (loggedInUser.pending.toString() == "Released")
                  ? Container(
                      width: MediaQuery.of(context).size.width * 0.93,
                      height: 400,
                      decoration: const BoxDecoration(
                        color: Color(0xFF161616),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0),
                          bottomLeft: Radius.circular(10.0),
                          bottomRight: Radius.circular(10.0),
                        ),
                      ),
                    )
                  : Container(),
            ),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      "Statements",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 0, 20),
                    child: Text(
                      "monthly",
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.normal,
                          fontSize: 15),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 40, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'Period',
                          style: TextStyle(color: Colors.grey),
                        ),
                        Text(
                          'Balance Payment',
                          style: TextStyle(color: Colors.grey),
                        ),
                        Text(
                          'Royalties',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  StreamBuilder(
                    stream: statements,
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
                            return Column(
                              key:
                                  ValueKey(streamSnapshot.data?.docs[index].id),
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        streamSnapshot.data!.docs[index]
                                            ["period"],
                                        style: const TextStyle(
                                            color: Colors.grey, fontSize: 10),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "${streamSnapshot.data!.docs[index]["balancePayment1"]}                   ",
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 10),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "${streamSnapshot.data!.docs[index]["royalties1"]}        ",
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 10),
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
                            );
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

class ConnectPaypal extends StatefulWidget {
  const ConnectPaypal({Key? key}) : super(key: key);

  @override
  _ConnectPaypalState createState() => _ConnectPaypalState();
}

class _ConnectPaypalState extends State<ConnectPaypal> {
  final paypalClientIdController = TextEditingController();
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                "Enter your Paypal Client ID Here to get paid",
                style: TextStyle(color: Colors.white, fontSize: 20),
              )),
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextFormField(
              autofocus: false,
              controller: paypalClientIdController,
              keyboardType: TextInputType.text,
              validator: (value) {
                if (value!.isEmpty) {
                  return ("Second Name cannot be Empty");
                }
                return null;
              },
              onSaved: (value) {
                paypalClientIdController.text = value!;
              },
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                fillColor: Color(0xFF161616),
                filled: true,
                contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                hintText: "Enter you Paypal Client ID",
                hintStyle: TextStyle(
                  color: Colors.white,
                  fontSize: null,
                  fontStyle: FontStyle.normal,
                ),
              ),
            ),
          ),
          Material(
            elevation: 5,
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xFF009AEE),
            child: MaterialButton(
              padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
              minWidth: 300,
              onPressed: () {
                if (paypalClientIdController.text != "") {
                  postDetailsToFirestore();
                  //databaseModel.s2(getUrl.fullPath.toString());
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PayoutPage(),
                    ),
                  );
                } else {
                  Fluttertoast.showToast(msg: "Login Successful");
                }
              },
              child: const Text(
                "Add",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  final _auth = FirebaseAuth.instance;
  postDetailsToFirestore() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    // writing all the values
    userModel.paypalClientId = paypalClientIdController.text;

    await firebaseFirestore
        .collection("users")
        .doc(user?.uid)
        .update(userModel.toMapPaypalClientId());
  }
}

class SPlitPay extends StatefulWidget {
  final String? uid;
  final String? songName;
  const SPlitPay({Key? key, required this.uid, required this.songName})
      : super(key: key);

  @override
  State<SPlitPay> createState() => _SPlitPayState();
}

class _SPlitPayState extends State<SPlitPay> {
  final artistPercentController = TextEditingController();
  final email1PercentController = TextEditingController();
  final email2PercentController = TextEditingController();
  final artistController = TextEditingController();
  final email1Controller = TextEditingController();
  final email2Controller = TextEditingController();
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
                                  decoration: const InputDecoration(
                                    fillColor: Color(0xFF282828),
                                    filled: true,
                                    contentPadding:
                                        EdgeInsets.fromLTRB(20, 15, 20, 15),
                                    hintText: "50%",
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
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return ("Please enter copyright holder");
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    email1PercentController.text = value!;
                                  },
                                  textInputAction: TextInputAction.next,
                                  decoration: const InputDecoration(
                                    fillColor: Color(0xFF282828),
                                    filled: true,
                                    contentPadding:
                                        EdgeInsets.fromLTRB(20, 15, 20, 15),
                                    hintText: "50%",
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
                                  decoration: const InputDecoration(
                                    fillColor: Color(0xFF282828),
                                    filled: true,
                                    contentPadding:
                                        EdgeInsets.fromLTRB(20, 15, 20, 15),
                                    hintText: "50%",
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
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return ("Please enter copyright holder");
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    artistController.text = value!;
                                  },
                                  textInputAction: TextInputAction.next,
                                  decoration: const InputDecoration(
                                    fillColor: Color(0xFF282828),
                                    filled: true,
                                    contentPadding:
                                        EdgeInsets.fromLTRB(20, 15, 20, 15),
                                    hintText: "Artist Name",
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
                                  decoration: const InputDecoration(
                                    fillColor: Color(0xFF282828),
                                    filled: true,
                                    contentPadding:
                                        EdgeInsets.fromLTRB(20, 15, 20, 15),
                                    hintText: "Email",
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
                                  decoration: const InputDecoration(
                                    fillColor: Color(0xFF282828),
                                    filled: true,
                                    contentPadding:
                                        EdgeInsets.fromLTRB(20, 15, 20, 15),
                                    hintText: "Email",
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
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 30, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(""),
                        Material(
                          elevation: 5,
                          borderRadius: BorderRadius.circular(0),
                          color: const Color(0xFF009AEE),
                          child: MaterialButton(
                            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                            minWidth: MediaQuery.of(context).size.width * 0.3,
                            onPressed: () {
                              postDetailsToFirestore();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PayoutPage()));
                              //signIn(emailController.text, passwordController.text);
                            },
                            child: const Text(
                              "Save and Close",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                        ),
                      ],
                    ),
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

  postDetailsToFirestore() async {
    // calling our firestore
    // calling our user model
    // sedning these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = FirebaseAuth.instance.currentUser;

    UserModel userModel = UserModel();

    // writing all the values
    userModel.collaboratorArtist = artistController.text;
    userModel.collaboratorEmail1 = email1Controller.text;
    userModel.collaboratorEmail2 = email2Controller.text;
    userModel.revenueShareArtist = artistPercentController.text;
    userModel.revenueShareEmail1 = email1Controller.text;
    userModel.revenueShareEmail2 = email2Controller.text;

    await firebaseFirestore
        .collection("users")
        .doc(user?.uid)
        .collection("songs")
        .doc(widget.uid)
        .update(userModel.toMap5_1());
  }
}
