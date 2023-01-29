import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import '../../../../model/user_model.dart';
import '../../main/components/side_menu.dart';

class Statistics extends StatefulWidget {
  const Statistics({Key? key}) : super(key: key);

  @override
  _StatisticsState createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
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
            'Statistics',
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
                                                        StatisticSection(
                                                          uid: streamSnapshot
                                                                  .data
                                                                  ?.docs[index]
                                                              ['uid'],
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

class StatisticSection extends StatefulWidget {
  final String uid;
  const StatisticSection({Key? key, required this.uid}) : super(key: key);

  @override
  _StatisticSectionState createState() => _StatisticSectionState();
}

class _StatisticSectionState extends State<StatisticSection> {
  final TextEditingController janController = TextEditingController();
  final TextEditingController febController = TextEditingController();
  final TextEditingController marController = TextEditingController();
  final TextEditingController mayController = TextEditingController();
  final TextEditingController aprilController = TextEditingController();
  final TextEditingController juneController = TextEditingController();
  final TextEditingController julController = TextEditingController();
  final TextEditingController augController = TextEditingController();
  final TextEditingController sepController = TextEditingController();
  final TextEditingController octController = TextEditingController();
  final TextEditingController novController = TextEditingController();
  final TextEditingController decController = TextEditingController();
  final TextEditingController country1Controller = TextEditingController();
  final TextEditingController country2Controller = TextEditingController();
  final TextEditingController country3Controller = TextEditingController();
  final TextEditingController country4Controller = TextEditingController();
  final TextEditingController country5Controller = TextEditingController();

  final TextEditingController jan1Controller = TextEditingController();
  final TextEditingController feb1Controller = TextEditingController();
  final TextEditingController mar1Controller = TextEditingController();
  final TextEditingController may1Controller = TextEditingController();
  final TextEditingController april1Controller = TextEditingController();
  final TextEditingController june1Controller = TextEditingController();
  final TextEditingController jul1Controller = TextEditingController();
  final TextEditingController aug1Controller = TextEditingController();
  final TextEditingController sep1Controller = TextEditingController();
  final TextEditingController oct1Controller = TextEditingController();
  final TextEditingController nov1Controller = TextEditingController();
  final TextEditingController dec1Controller = TextEditingController();

  final TextEditingController streamsController = TextEditingController();
  final TextEditingController royaltiesController = TextEditingController();
  final TextEditingController viewsController = TextEditingController();

  final TextEditingController facebookController = TextEditingController();
  final TextEditingController youtubeController = TextEditingController();
  final TextEditingController spotifyController = TextEditingController();
  final TextEditingController appleMusicController = TextEditingController();
  final TextEditingController amazonController = TextEditingController();
  final TextEditingController maleController = TextEditingController();
  final TextEditingController femaleController = TextEditingController();
  String value = 'United Kingdom';
  String value1 = 'United Kingdom';
  String value2 = 'United Kingdom';
  String value3 = 'United Kingdom';
  String value4 = 'United Kingdom';

  var now = new DateTime.now();
  String year = DateFormat('yyyy').format(DateTime.now()).toString();
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
              'Edit Statistics',
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
                    "Youtube Table",
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.normal,
                        fontSize: 20),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    "January ${year}",
                    style: const TextStyle(
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
                controller: janController,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return ("Please Enter February Stream");
                  }
                  // reg expression for email validation
                  return null;
                },
                onSaved: (value) {
                  janController.text = value!;
                },
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFF161616),
                  contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                  hintText: "",
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
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Text(
                    "February ${year}",
                    style: const TextStyle(
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
                controller: febController,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return ("Please Enter February Stream");
                  }
                  // reg expression for email validation
                  return null;
                },
                onSaved: (value) {
                  febController.text = value!;
                },
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFF161616),
                  contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                  hintText: "",
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
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Text(
                    "March $year",
                    style: const TextStyle(
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
                controller: marController,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return ("Please Enter March Streams");
                  }
                  // reg expression for email validation
                  return null;
                },
                onSaved: (value) {
                  marController.text = value!;
                },
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFF161616),
                  contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                  hintText: "",
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
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    "April ${year}",
                    style: const TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.normal,
                        fontSize: 13),
                  ),
                ),
              ),
              TextFormField(
                autofocus: false,
                controller: aprilController,
                keyboardType: TextInputType.text,
                validator: (value) {},
                onSaved: (value) {
                  aprilController.text = value!;
                },
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFF161616),
                  contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                  hintText: "",
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
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Text(
                    "May ${year}",
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
                controller: mayController,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return ("Please Enter May Stream");
                  }
                  // reg expression for email validation
                  return null;
                },
                onSaved: (value) {
                  mayController.text = value!;
                },
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFF161616),
                  contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                  hintText: "",
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
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Text(
                    "June $year",
                    style: const TextStyle(
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
                controller: juneController,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return ("Please Enter June Streams");
                  }
                  // reg expression for email validation
                  return null;
                },
                onSaved: (value) {
                  juneController.text = value!;
                },
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFF161616),
                  contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                  hintText: "",
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
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    "July ${year}",
                    style: const TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.normal,
                        fontSize: 13),
                  ),
                ),
              ),
              TextFormField(
                autofocus: false,
                controller: julController,
                keyboardType: TextInputType.text,
                validator: (value) {},
                onSaved: (value) {
                  julController.text = value!;
                },
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFF161616),
                  contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                  hintText: "",
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
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Text(
                    "August ${year}",
                    style: const TextStyle(
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
                controller: augController,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return ("Please Enter August Stream");
                  }
                  // reg expression for email validation
                  return null;
                },
                onSaved: (value) {
                  augController.text = value!;
                },
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFF161616),
                  contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                  hintText: "",
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
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Text(
                    "September $year",
                    style: const TextStyle(
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
                controller: sepController,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return ("Please Enter Septmber Streams");
                  }
                  // reg expression for email validation
                  return null;
                },
                onSaved: (value) {
                  sepController.text = value!;
                },
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFF161616),
                  contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                  hintText: "",
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
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    "October ${year}",
                    style: const TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.normal,
                        fontSize: 13),
                  ),
                ),
              ),
              TextFormField(
                autofocus: false,
                controller: octController,
                keyboardType: TextInputType.text,
                validator: (value) {},
                onSaved: (value) {
                  octController.text = value!;
                },
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFF161616),
                  contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                  hintText: "",
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
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Text(
                    "November ${year}",
                    style: const TextStyle(
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
                controller: novController,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return ("Please Enter November Stream");
                  }
                  // reg expression for email validation
                  return null;
                },
                onSaved: (value) {
                  novController.text = value!;
                },
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFF161616),
                  contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                  hintText: "",
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
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Text(
                    "December $year",
                    style: const TextStyle(
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
                controller: decController,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return ("Please Enter December");
                  }
                  // reg expression for email validation
                  return null;
                },
                onSaved: (value) {
                  decController.text = value!;
                },
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFF161616),
                  contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                  hintText: "",
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
                    janController.text = "";
                    febController.text = "";
                    marController.text = "";
                    aprilController.text = "";
                    mayController.text = "";
                    juneController.text = "";
                    julController.text = "";
                    augController.text = "";
                    sepController.text = "";
                    octController.text = "";
                    novController.text = "";
                    decController.text = "";
                    const SnackBar(
                      content: Text('Data Has Been Updated Successfully'),
                    );
                  },
                  child: const Text(
                    "Update Youtube Views",
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
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    "Streams and Royalties Table",
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.normal,
                        fontSize: 20),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    "January ${year}",
                    style: const TextStyle(
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
                controller: jan1Controller,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return ("Please Enter February Stream");
                  }
                  // reg expression for email validation
                  return null;
                },
                onSaved: (value) {
                  jan1Controller.text = value!;
                },
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFF161616),
                  contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                  hintText: "",
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
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Text(
                    "February ${year}",
                    style: const TextStyle(
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
                controller: feb1Controller,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return ("Please Enter February Stream");
                  }
                  // reg expression for email validation
                  return null;
                },
                onSaved: (value) {
                  feb1Controller.text = value!;
                },
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFF161616),
                  contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                  hintText: "",
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
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Text(
                    "March $year",
                    style: const TextStyle(
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
                controller: mar1Controller,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return ("Please Enter March Streams");
                  }
                  // reg expression for email validation
                  return null;
                },
                onSaved: (value) {
                  mar1Controller.text = value!;
                },
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFF161616),
                  contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                  hintText: "",
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
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    "April ${year}",
                    style: const TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.normal,
                        fontSize: 13),
                  ),
                ),
              ),
              TextFormField(
                autofocus: false,
                controller: april1Controller,
                keyboardType: TextInputType.text,
                validator: (value) {},
                onSaved: (value) {
                  april1Controller.text = value!;
                },
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFF161616),
                  contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                  hintText: "",
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
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Text(
                    "May ${year}",
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
                controller: may1Controller,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return ("Please Enter May Stream");
                  }
                  // reg expression for email validation
                  return null;
                },
                onSaved: (value) {
                  may1Controller.text = value!;
                },
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFF161616),
                  contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                  hintText: "",
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
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Text(
                    "June $year",
                    style: const TextStyle(
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
                controller: june1Controller,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return ("Please Enter June Streams");
                  }
                  // reg expression for email validation
                  return null;
                },
                onSaved: (value) {
                  june1Controller.text = value!;
                },
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFF161616),
                  contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                  hintText: "",
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
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    "July ${year}",
                    style: const TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.normal,
                        fontSize: 13),
                  ),
                ),
              ),
              TextFormField(
                autofocus: false,
                controller: jul1Controller,
                keyboardType: TextInputType.text,
                validator: (value) {},
                onSaved: (value) {
                  jul1Controller.text = value!;
                },
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFF161616),
                  contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                  hintText: "",
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
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Text(
                    "August ${year}",
                    style: const TextStyle(
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
                controller: aug1Controller,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return ("Please Enter August Stream");
                  }
                  // reg expression for email validation
                  return null;
                },
                onSaved: (value) {
                  aug1Controller.text = value!;
                },
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFF161616),
                  contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                  hintText: "",
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
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Text(
                    "September $year",
                    style: const TextStyle(
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
                controller: sep1Controller,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return ("Please Enter Septmber Streams");
                  }
                  // reg expression for email validation
                  return null;
                },
                onSaved: (value) {
                  sep1Controller.text = value!;
                },
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFF161616),
                  contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                  hintText: "",
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
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    "October ${year}",
                    style: const TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.normal,
                        fontSize: 13),
                  ),
                ),
              ),
              TextFormField(
                autofocus: false,
                controller: oct1Controller,
                keyboardType: TextInputType.text,
                validator: (value) {},
                onSaved: (value) {
                  oct1Controller.text = value!;
                },
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFF161616),
                  contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                  hintText: "",
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
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Text(
                    "November ${year}",
                    style: const TextStyle(
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
                controller: nov1Controller,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return ("Please Enter November Stream");
                  }
                  // reg expression for email validation
                  return null;
                },
                onSaved: (value) {
                  nov1Controller.text = value!;
                },
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFF161616),
                  contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                  hintText: "",
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
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Text(
                    "December $year",
                    style: const TextStyle(
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
                controller: dec1Controller,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return ("Please Enter December");
                  }
                  // reg expression for email validation
                  return null;
                },
                onSaved: (value) {
                  dec1Controller.text = value!;
                },
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFF161616),
                  contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                  hintText: "",
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
                    postDetailsToFirestore2();
                    jan1Controller.text = "";
                    feb1Controller.text = "";
                    mar1Controller.text = "";
                    april1Controller.text = "";
                    may1Controller.text = "";
                    june1Controller.text = "";
                    jul1Controller.text = "";
                    aug1Controller.text = "";
                    sep1Controller.text = "";
                    oct1Controller.text = "";
                    nov1Controller.text = "";
                    dec1Controller.text = "";
                    const SnackBar(
                      content: Text('Data Has Been Updated Successfully'),
                    );
                  },
                  child: const Text(
                    "Update Streams and royalties",
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
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    "Song/Artist",
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
                  padding: EdgeInsets.all(20),
                  child: Text(
                    "Enter Steams",
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.normal,
                        fontSize: 13),
                  ),
                ),
              ),
              TextFormField(
                autofocus: false,
                controller: streamsController,
                keyboardType: TextInputType.text,
                validator: (value) {},
                onSaved: (value) {
                  streamsController.text = value!;
                },
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFF161616),
                  contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                  hintText: "",
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
                    "Enter Views",
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
                controller: viewsController,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return ("Please Enter November Stream");
                  }
                  // reg expression for email validation
                  return null;
                },
                onSaved: (value) {
                  viewsController.text = value!;
                },
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFF161616),
                  contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                  hintText: "",
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
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Text(
                    "Enter Royalty Balance",
                    style: const TextStyle(
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
                controller: royaltiesController,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return ("Please Enter December");
                  }
                  // reg expression for email validation
                  return null;
                },
                onSaved: (value) {
                  royaltiesController.text = value!;
                },
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFF161616),
                  contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                  hintText: "",
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
                    postDetailsToFirestore3();
                    viewsController.text = "";
                    streamsController.text = "";
                    royaltiesController.text = "";
                    const SnackBar(
                      content: Text('Data Has Been Updated Successfully'),
                    );
                  },
                  child: const Text(
                    "Update Song/Artist",
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
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    "Top Locations",
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.normal,
                        fontSize: 20),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              DropdownButton<String>(
                value: value,
                icon: const Icon(Icons.arrow_downward),
                elevation: 16,
                style: const TextStyle(color: Colors.white),
                underline: Container(
                  height: 2,
                  color: Colors.white,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    value = newValue!;
                  });
                },
                items: <String>[
                  'Afghanistan',
                  'Albania',
                  'Algeria',
                  'Andorra',
                  'Angola',
                  'Antigua and Barbuda',
                  'Argentina',
                  'Armenia',
                  'Australia',
                  'Austria',
                  'Austrian Empire*',
                  'Azerbaijan',
                  'Baden*',
                  'Bahamas',
                  'Bahrain',
                  'Bangladesh',
                  'Barbados',
                  'Bavaria*',
                  'Belarus',
                  'Belgium',
                  'Belize',
                  'Benin (Dahomey)',
                  'Bolivia',
                  'Bosnia and Herzegovina',
                  'Botswana',
                  'Brazil',
                  'Brunei',
                  'Brunswick and Lüneburg',
                  'Bulgaria',
                  'Burkina Faso (Upper Volta)',
                  'Burma',
                  'Burundi',
                  'Cabo Verde',
                  'Cambodia',
                  'Cameroon',
                  'Canada',
                  'Cayman Islands, The',
                  'Central African Republic',
                  'Central American Federation*',
                  'Chad',
                  'Chile',
                  'China',
                  'Colombia',
                  'Comoros',
                  'Congo Free State',
                  'The Costa Rica',
                  "Cote d’Ivoire (Ivory Coast)",
                  'Croatia',
                  'Cuba',
                  'Cyprus',
                  'Czechia',
                  'Czechoslovakia',
                  'Democratic Republic of the Congo',
                  'Denmark',
                  'Djibouti',
                  'Dominica',
                  'Dominican Republic',
                  'Duchy of Parma, The*',
                  'Fiji',
                  'Finland',
                  'France',
                  'Gabon',
                  'Gambia',
                  'Georgia',
                  'Germany',
                  'Ghana',
                  'Grand Duchy of Tuscany',
                  'Greece',
                  'Grenada',
                  'Guatemala',
                  'Guinea',
                  'Guinea-Bissau',
                  'Guyana',
                  'Haiti',
                  'Hanover',
                  'Hanseatic Republics',
                  'Hawaii',
                  'Hesse',
                  'Holy See',
                  'Honduras',
                  'Hungary',
                  'Iceland',
                  'India',
                  'Indonesia',
                  'Iran',
                  'Iraq',
                  'Ireland',
                  'Israel',
                  'Italy',
                  'Jamaica',
                  'Japan',
                  'Jordan',
                  'Kazakhstan',
                  'Kenya',
                  'Kingdom of Serbia/Yugoslavia',
                  'Kiribati',
                  'Korea',
                  'Kosovo',
                  'Kuwait',
                  'Kyrgyzstan',
                  'Laos',
                  'Latvia',
                  'Lebanon',
                  'Lesotho',
                  'Lew Chew (Loochoo)',
                  'Liberia',
                  'Libya',
                  'Liechtenstein',
                  'Lithuania',
                  'Luxembourg',
                  'Madagascar',
                  'Malawi',
                  'Malaysia',
                  'Maldives',
                  'Mali',
                  'Malta',
                  'Marshall Islands',
                  'Mauritania',
                  'Mauritius',
                  'Mecklenburg-Schwerin',
                  'Mecklenburg-Strelitz',
                  'Mexico',
                  'Micronesia',
                  'Moldova',
                  'Monaco',
                  'Mongolia',
                  'Montenegro',
                  'Morocco',
                  'Mozambique',
                  'Namibia',
                  'Nassau',
                  'Nauru',
                  'Nepal',
                  'Netherlands',
                  'New Zealand',
                  'Nicaragua',
                  'Niger',
                  'Nigeria',
                  'North German Confederation',
                  'North German Union',
                  'North Macedonia',
                  'Norway',
                  'Oldenburg',
                  'Oman',
                  'Orange Free State',
                  'Pakistan',
                  'Palau',
                  'Panama',
                  'Papal States',
                  'Papua New Guinea',
                  'Paraguay',
                  'Peru',
                  'Philippines',
                  'Piedmont-Sardinia',
                  'Poland',
                  'Portugal',
                  'Qatar',
                  'Republic of Genoa',
                  'Republic of Korea (South Korea)',
                  'Republic of the Congo',
                  'Romania',
                  'Russia',
                  'Rwanda',
                  'Saint Kitts and Nevis',
                  'Saint Lucia',
                  'Saint Vincent and the Grenadines',
                  'Samoa',
                  'San Marino',
                  'Sao Tome and Principe',
                  'Saudi Arabia',
                  'Schaumburg-Lippe',
                  'Senegal',
                  'Serbia',
                  'Seychelles',
                  'Sierra Leone',
                  'Singapore',
                  'Slovakia',
                  'Slovenia',
                  'Solomon Islands',
                  'Somalia',
                  'South Africa',
                  'South Sudan',
                  'Spain',
                  'Sri Lanka',
                  'Sudan',
                  'Suriname',
                  'Sweden',
                  'Switzerland',
                  'Syria',
                  'Tajikistan',
                  'Tanzania',
                  'Thailand',
                  'Timor-Leste',
                  'Togo',
                  'Tonga',
                  'Trinidad and Tobago',
                  'Tunisia',
                  'Turkey',
                  'Turkmenistan',
                  'Tuvalu',
                  'Uganda',
                  'Ukraine',
                  'United Arab Emirates',
                  'United Kingdom',
                  'United States of America',
                  'Uruguay',
                  'Uzbekistan',
                  'Vanuatu',
                  'Venezuela',
                  'Vietnam',
                  'Yemen',
                  'Zambia',
                  'Zimbabwe'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                autofocus: false,
                controller: country1Controller,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return ("Please Enter Streams");
                  }
                  // reg expression for email validation
                  return null;
                },
                onSaved: (value) {
                  country1Controller.text = value!;
                },
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFF161616),
                  contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                  hintText: "",
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
              DropdownButton<String>(
                value: value1,
                icon: const Icon(Icons.arrow_downward),
                elevation: 16,
                style: const TextStyle(color: Colors.white),
                underline: Container(
                  height: 2,
                  color: Colors.white,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    value1 = newValue!;
                  });
                },
                items: <String>[
                  'Afghanistan',
                  'Albania',
                  'Algeria',
                  'Andorra',
                  'Angola',
                  'Antigua and Barbuda',
                  'Argentina',
                  'Armenia',
                  'Australia',
                  'Austria',
                  'Austrian Empire*',
                  'Azerbaijan',
                  'Baden*',
                  'Bahamas',
                  'Bahrain',
                  'Bangladesh',
                  'Barbados',
                  'Bavaria*',
                  'Belarus',
                  'Belgium',
                  'Belize',
                  'Benin (Dahomey)',
                  'Bolivia',
                  'Bosnia and Herzegovina',
                  'Botswana',
                  'Brazil',
                  'Brunei',
                  'Brunswick and Lüneburg',
                  'Bulgaria',
                  'Burkina Faso (Upper Volta)',
                  'Burma',
                  'Burundi',
                  'Cabo Verde',
                  'Cambodia',
                  'Cameroon',
                  'Canada',
                  'Cayman Islands, The',
                  'Central African Republic',
                  'Central American Federation*',
                  'Chad',
                  'Chile',
                  'China',
                  'Colombia',
                  'Comoros',
                  'Congo Free State',
                  'The Costa Rica',
                  "Cote d’Ivoire (Ivory Coast)",
                  'Croatia',
                  'Cuba',
                  'Cyprus',
                  'Czechia',
                  'Czechoslovakia',
                  'Democratic Republic of the Congo',
                  'Denmark',
                  'Djibouti',
                  'Dominica',
                  'Dominican Republic',
                  'Duchy of Parma, The*',
                  'Fiji',
                  'Finland',
                  'France',
                  'Gabon',
                  'Gambia',
                  'Georgia',
                  'Germany',
                  'Ghana',
                  'Grand Duchy of Tuscany',
                  'Greece',
                  'Grenada',
                  'Guatemala',
                  'Guinea',
                  'Guinea-Bissau',
                  'Guyana',
                  'Haiti',
                  'Hanover',
                  'Hanseatic Republics',
                  'Hawaii',
                  'Hesse',
                  'Holy See',
                  'Honduras',
                  'Hungary',
                  'Iceland',
                  'India',
                  'Indonesia',
                  'Iran',
                  'Iraq',
                  'Ireland',
                  'Israel',
                  'Italy',
                  'Jamaica',
                  'Japan',
                  'Jordan',
                  'Kazakhstan',
                  'Kenya',
                  'Kingdom of Serbia/Yugoslavia',
                  'Kiribati',
                  'Korea',
                  'Kosovo',
                  'Kuwait',
                  'Kyrgyzstan',
                  'Laos',
                  'Latvia',
                  'Lebanon',
                  'Lesotho',
                  'Lew Chew (Loochoo)',
                  'Liberia',
                  'Libya',
                  'Liechtenstein',
                  'Lithuania',
                  'Luxembourg',
                  'Madagascar',
                  'Malawi',
                  'Malaysia',
                  'Maldives',
                  'Mali',
                  'Malta',
                  'Marshall Islands',
                  'Mauritania',
                  'Mauritius',
                  'Mecklenburg-Schwerin',
                  'Mecklenburg-Strelitz',
                  'Mexico',
                  'Micronesia',
                  'Moldova',
                  'Monaco',
                  'Mongolia',
                  'Montenegro',
                  'Morocco',
                  'Mozambique',
                  'Namibia',
                  'Nassau',
                  'Nauru',
                  'Nepal',
                  'Netherlands',
                  'New Zealand',
                  'Nicaragua',
                  'Niger',
                  'Nigeria',
                  'North German Confederation',
                  'North German Union',
                  'North Macedonia',
                  'Norway',
                  'Oldenburg',
                  'Oman',
                  'Orange Free State',
                  'Pakistan',
                  'Palau',
                  'Panama',
                  'Papal States',
                  'Papua New Guinea',
                  'Paraguay',
                  'Peru',
                  'Philippines',
                  'Piedmont-Sardinia',
                  'Poland',
                  'Portugal',
                  'Qatar',
                  'Republic of Genoa',
                  'Republic of Korea (South Korea)',
                  'Republic of the Congo',
                  'Romania',
                  'Russia',
                  'Rwanda',
                  'Saint Kitts and Nevis',
                  'Saint Lucia',
                  'Saint Vincent and the Grenadines',
                  'Samoa',
                  'San Marino',
                  'Sao Tome and Principe',
                  'Saudi Arabia',
                  'Schaumburg-Lippe',
                  'Senegal',
                  'Serbia',
                  'Seychelles',
                  'Sierra Leone',
                  'Singapore',
                  'Slovakia',
                  'Slovenia',
                  'Solomon Islands',
                  'Somalia',
                  'South Africa',
                  'South Sudan',
                  'Spain',
                  'Sri Lanka',
                  'Sudan',
                  'Suriname',
                  'Sweden',
                  'Switzerland',
                  'Syria',
                  'Tajikistan',
                  'Tanzania',
                  'Thailand',
                  'Timor-Leste',
                  'Togo',
                  'Tonga',
                  'Trinidad and Tobago',
                  'Tunisia',
                  'Turkey',
                  'Turkmenistan',
                  'Tuvalu',
                  'Uganda',
                  'Ukraine',
                  'United Arab Emirates',
                  'United Kingdom',
                  'United States of America',
                  'Uruguay',
                  'Uzbekistan',
                  'Vanuatu',
                  'Venezuela',
                  'Vietnam',
                  'Yemen',
                  'Zambia',
                  'Zimbabwe'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                autofocus: false,
                controller: country2Controller,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return ("Please Enter Streams");
                  }
                  // reg expression for email validation
                  return null;
                },
                onSaved: (value) {
                  country2Controller.text = value!;
                },
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFF161616),
                  contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                  hintText: "",
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
              DropdownButton<String>(
                value: value2,
                icon: const Icon(Icons.arrow_downward),
                elevation: 16,
                style: const TextStyle(color: Colors.white),
                underline: Container(
                  height: 2,
                  color: Colors.white,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    value2 = newValue!;
                  });
                },
                items: <String>[
                  'Afghanistan',
                  'Albania',
                  'Algeria',
                  'Andorra',
                  'Angola',
                  'Antigua and Barbuda',
                  'Argentina',
                  'Armenia',
                  'Australia',
                  'Austria',
                  'Austrian Empire*',
                  'Azerbaijan',
                  'Baden*',
                  'Bahamas',
                  'Bahrain',
                  'Bangladesh',
                  'Barbados',
                  'Bavaria*',
                  'Belarus',
                  'Belgium',
                  'Belize',
                  'Benin (Dahomey)',
                  'Bolivia',
                  'Bosnia and Herzegovina',
                  'Botswana',
                  'Brazil',
                  'Brunei',
                  'Brunswick and Lüneburg',
                  'Bulgaria',
                  'Burkina Faso (Upper Volta)',
                  'Burma',
                  'Burundi',
                  'Cabo Verde',
                  'Cambodia',
                  'Cameroon',
                  'Canada',
                  'Cayman Islands, The',
                  'Central African Republic',
                  'Central American Federation*',
                  'Chad',
                  'Chile',
                  'China',
                  'Colombia',
                  'Comoros',
                  'Congo Free State',
                  'The Costa Rica',
                  "Cote d’Ivoire (Ivory Coast)",
                  'Croatia',
                  'Cuba',
                  'Cyprus',
                  'Czechia',
                  'Czechoslovakia',
                  'Democratic Republic of the Congo',
                  'Denmark',
                  'Djibouti',
                  'Dominica',
                  'Dominican Republic',
                  'Duchy of Parma, The*',
                  'Fiji',
                  'Finland',
                  'France',
                  'Gabon',
                  'Gambia',
                  'Georgia',
                  'Germany',
                  'Ghana',
                  'Grand Duchy of Tuscany',
                  'Greece',
                  'Grenada',
                  'Guatemala',
                  'Guinea',
                  'Guinea-Bissau',
                  'Guyana',
                  'Haiti',
                  'Hanover',
                  'Hanseatic Republics',
                  'Hawaii',
                  'Hesse',
                  'Holy See',
                  'Honduras',
                  'Hungary',
                  'Iceland',
                  'India',
                  'Indonesia',
                  'Iran',
                  'Iraq',
                  'Ireland',
                  'Israel',
                  'Italy',
                  'Jamaica',
                  'Japan',
                  'Jordan',
                  'Kazakhstan',
                  'Kenya',
                  'Kingdom of Serbia/Yugoslavia',
                  'Kiribati',
                  'Korea',
                  'Kosovo',
                  'Kuwait',
                  'Kyrgyzstan',
                  'Laos',
                  'Latvia',
                  'Lebanon',
                  'Lesotho',
                  'Lew Chew (Loochoo)',
                  'Liberia',
                  'Libya',
                  'Liechtenstein',
                  'Lithuania',
                  'Luxembourg',
                  'Madagascar',
                  'Malawi',
                  'Malaysia',
                  'Maldives',
                  'Mali',
                  'Malta',
                  'Marshall Islands',
                  'Mauritania',
                  'Mauritius',
                  'Mecklenburg-Schwerin',
                  'Mecklenburg-Strelitz',
                  'Mexico',
                  'Micronesia',
                  'Moldova',
                  'Monaco',
                  'Mongolia',
                  'Montenegro',
                  'Morocco',
                  'Mozambique',
                  'Namibia',
                  'Nassau',
                  'Nauru',
                  'Nepal',
                  'Netherlands',
                  'New Zealand',
                  'Nicaragua',
                  'Niger',
                  'Nigeria',
                  'North German Confederation',
                  'North German Union',
                  'North Macedonia',
                  'Norway',
                  'Oldenburg',
                  'Oman',
                  'Orange Free State',
                  'Pakistan',
                  'Palau',
                  'Panama',
                  'Papal States',
                  'Papua New Guinea',
                  'Paraguay',
                  'Peru',
                  'Philippines',
                  'Piedmont-Sardinia',
                  'Poland',
                  'Portugal',
                  'Qatar',
                  'Republic of Genoa',
                  'Republic of Korea (South Korea)',
                  'Republic of the Congo',
                  'Romania',
                  'Russia',
                  'Rwanda',
                  'Saint Kitts and Nevis',
                  'Saint Lucia',
                  'Saint Vincent and the Grenadines',
                  'Samoa',
                  'San Marino',
                  'Sao Tome and Principe',
                  'Saudi Arabia',
                  'Schaumburg-Lippe',
                  'Senegal',
                  'Serbia',
                  'Seychelles',
                  'Sierra Leone',
                  'Singapore',
                  'Slovakia',
                  'Slovenia',
                  'Solomon Islands',
                  'Somalia',
                  'South Africa',
                  'South Sudan',
                  'Spain',
                  'Sri Lanka',
                  'Sudan',
                  'Suriname',
                  'Sweden',
                  'Switzerland',
                  'Syria',
                  'Tajikistan',
                  'Tanzania',
                  'Thailand',
                  'Timor-Leste',
                  'Togo',
                  'Tonga',
                  'Trinidad and Tobago',
                  'Tunisia',
                  'Turkey',
                  'Turkmenistan',
                  'Tuvalu',
                  'Uganda',
                  'Ukraine',
                  'United Arab Emirates',
                  'United Kingdom',
                  'United States of America',
                  'Uruguay',
                  'Uzbekistan',
                  'Vanuatu',
                  'Venezuela',
                  'Vietnam',
                  'Yemen',
                  'Zambia',
                  'Zimbabwe'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                autofocus: false,
                controller: country3Controller,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return ("Please Enter Streams");
                  }
                  // reg expression for email validation
                  return null;
                },
                onSaved: (value) {
                  country3Controller.text = value!;
                },
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFF161616),
                  contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                  hintText: "",
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
              DropdownButton<String>(
                value: value3,
                icon: const Icon(Icons.arrow_downward),
                elevation: 16,
                style: const TextStyle(color: Colors.white),
                underline: Container(
                  height: 2,
                  color: Colors.white,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    value3 = newValue!;
                  });
                },
                items: <String>[
                  'Afghanistan',
                  'Albania',
                  'Algeria',
                  'Andorra',
                  'Angola',
                  'Antigua and Barbuda',
                  'Argentina',
                  'Armenia',
                  'Australia',
                  'Austria',
                  'Austrian Empire*',
                  'Azerbaijan',
                  'Baden*',
                  'Bahamas',
                  'Bahrain',
                  'Bangladesh',
                  'Barbados',
                  'Bavaria*',
                  'Belarus',
                  'Belgium',
                  'Belize',
                  'Benin (Dahomey)',
                  'Bolivia',
                  'Bosnia and Herzegovina',
                  'Botswana',
                  'Brazil',
                  'Brunei',
                  'Brunswick and Lüneburg',
                  'Bulgaria',
                  'Burkina Faso (Upper Volta)',
                  'Burma',
                  'Burundi',
                  'Cabo Verde',
                  'Cambodia',
                  'Cameroon',
                  'Canada',
                  'Cayman Islands, The',
                  'Central African Republic',
                  'Central American Federation*',
                  'Chad',
                  'Chile',
                  'China',
                  'Colombia',
                  'Comoros',
                  'Congo Free State',
                  'The Costa Rica',
                  "Cote d’Ivoire (Ivory Coast)",
                  'Croatia',
                  'Cuba',
                  'Cyprus',
                  'Czechia',
                  'Czechoslovakia',
                  'Democratic Republic of the Congo',
                  'Denmark',
                  'Djibouti',
                  'Dominica',
                  'Dominican Republic',
                  'Duchy of Parma, The*',
                  'Fiji',
                  'Finland',
                  'France',
                  'Gabon',
                  'Gambia',
                  'Georgia',
                  'Germany',
                  'Ghana',
                  'Grand Duchy of Tuscany',
                  'Greece',
                  'Grenada',
                  'Guatemala',
                  'Guinea',
                  'Guinea-Bissau',
                  'Guyana',
                  'Haiti',
                  'Hanover',
                  'Hanseatic Republics',
                  'Hawaii',
                  'Hesse',
                  'Holy See',
                  'Honduras',
                  'Hungary',
                  'Iceland',
                  'India',
                  'Indonesia',
                  'Iran',
                  'Iraq',
                  'Ireland',
                  'Israel',
                  'Italy',
                  'Jamaica',
                  'Japan',
                  'Jordan',
                  'Kazakhstan',
                  'Kenya',
                  'Kingdom of Serbia/Yugoslavia',
                  'Kiribati',
                  'Korea',
                  'Kosovo',
                  'Kuwait',
                  'Kyrgyzstan',
                  'Laos',
                  'Latvia',
                  'Lebanon',
                  'Lesotho',
                  'Lew Chew (Loochoo)',
                  'Liberia',
                  'Libya',
                  'Liechtenstein',
                  'Lithuania',
                  'Luxembourg',
                  'Madagascar',
                  'Malawi',
                  'Malaysia',
                  'Maldives',
                  'Mali',
                  'Malta',
                  'Marshall Islands',
                  'Mauritania',
                  'Mauritius',
                  'Mecklenburg-Schwerin',
                  'Mecklenburg-Strelitz',
                  'Mexico',
                  'Micronesia',
                  'Moldova',
                  'Monaco',
                  'Mongolia',
                  'Montenegro',
                  'Morocco',
                  'Mozambique',
                  'Namibia',
                  'Nassau',
                  'Nauru',
                  'Nepal',
                  'Netherlands',
                  'New Zealand',
                  'Nicaragua',
                  'Niger',
                  'Nigeria',
                  'North German Confederation',
                  'North German Union',
                  'North Macedonia',
                  'Norway',
                  'Oldenburg',
                  'Oman',
                  'Orange Free State',
                  'Pakistan',
                  'Palau',
                  'Panama',
                  'Papal States',
                  'Papua New Guinea',
                  'Paraguay',
                  'Peru',
                  'Philippines',
                  'Piedmont-Sardinia',
                  'Poland',
                  'Portugal',
                  'Qatar',
                  'Republic of Genoa',
                  'Republic of Korea (South Korea)',
                  'Republic of the Congo',
                  'Romania',
                  'Russia',
                  'Rwanda',
                  'Saint Kitts and Nevis',
                  'Saint Lucia',
                  'Saint Vincent and the Grenadines',
                  'Samoa',
                  'San Marino',
                  'Sao Tome and Principe',
                  'Saudi Arabia',
                  'Schaumburg-Lippe',
                  'Senegal',
                  'Serbia',
                  'Seychelles',
                  'Sierra Leone',
                  'Singapore',
                  'Slovakia',
                  'Slovenia',
                  'Solomon Islands',
                  'Somalia',
                  'South Africa',
                  'South Sudan',
                  'Spain',
                  'Sri Lanka',
                  'Sudan',
                  'Suriname',
                  'Sweden',
                  'Switzerland',
                  'Syria',
                  'Tajikistan',
                  'Tanzania',
                  'Thailand',
                  'Timor-Leste',
                  'Togo',
                  'Tonga',
                  'Trinidad and Tobago',
                  'Tunisia',
                  'Turkey',
                  'Turkmenistan',
                  'Tuvalu',
                  'Uganda',
                  'Ukraine',
                  'United Arab Emirates',
                  'United Kingdom',
                  'United States of America',
                  'Uruguay',
                  'Uzbekistan',
                  'Vanuatu',
                  'Venezuela',
                  'Vietnam',
                  'Yemen',
                  'Zambia',
                  'Zimbabwe'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                autofocus: false,
                controller: country4Controller,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return ("Please Enter Streams");
                  }
                  // reg expression for email validation
                  return null;
                },
                onSaved: (value) {
                  country4Controller.text = value!;
                },
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFF161616),
                  contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                  hintText: "",
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
              DropdownButton<String>(
                value: value4,
                icon: const Icon(Icons.arrow_downward),
                elevation: 16,
                style: const TextStyle(color: Colors.white),
                underline: Container(
                  height: 2,
                  color: Colors.white,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    value4 = newValue!;
                  });
                },
                items: <String>[
                  'Afghanistan',
                  'Albania',
                  'Algeria',
                  'Andorra',
                  'Angola',
                  'Antigua and Barbuda',
                  'Argentina',
                  'Armenia',
                  'Australia',
                  'Austria',
                  'Austrian Empire*',
                  'Azerbaijan',
                  'Baden*',
                  'Bahamas',
                  'Bahrain',
                  'Bangladesh',
                  'Barbados',
                  'Bavaria*',
                  'Belarus',
                  'Belgium',
                  'Belize',
                  'Benin (Dahomey)',
                  'Bolivia',
                  'Bosnia and Herzegovina',
                  'Botswana',
                  'Brazil',
                  'Brunei',
                  'Brunswick and Lüneburg',
                  'Bulgaria',
                  'Burkina Faso (Upper Volta)',
                  'Burma',
                  'Burundi',
                  'Cabo Verde',
                  'Cambodia',
                  'Cameroon',
                  'Canada',
                  'Cayman Islands, The',
                  'Central African Republic',
                  'Central American Federation*',
                  'Chad',
                  'Chile',
                  'China',
                  'Colombia',
                  'Comoros',
                  'Congo Free State',
                  'The Costa Rica',
                  "Cote d’Ivoire (Ivory Coast)",
                  'Croatia',
                  'Cuba',
                  'Cyprus',
                  'Czechia',
                  'Czechoslovakia',
                  'Democratic Republic of the Congo',
                  'Denmark',
                  'Djibouti',
                  'Dominica',
                  'Dominican Republic',
                  'Duchy of Parma, The*',
                  'Fiji',
                  'Finland',
                  'France',
                  'Gabon',
                  'Gambia',
                  'Georgia',
                  'Germany',
                  'Ghana',
                  'Grand Duchy of Tuscany',
                  'Greece',
                  'Grenada',
                  'Guatemala',
                  'Guinea',
                  'Guinea-Bissau',
                  'Guyana',
                  'Haiti',
                  'Hanover',
                  'Hanseatic Republics',
                  'Hawaii',
                  'Hesse',
                  'Holy See',
                  'Honduras',
                  'Hungary',
                  'Iceland',
                  'India',
                  'Indonesia',
                  'Iran',
                  'Iraq',
                  'Ireland',
                  'Israel',
                  'Italy',
                  'Jamaica',
                  'Japan',
                  'Jordan',
                  'Kazakhstan',
                  'Kenya',
                  'Kingdom of Serbia/Yugoslavia',
                  'Kiribati',
                  'Korea',
                  'Kosovo',
                  'Kuwait',
                  'Kyrgyzstan',
                  'Laos',
                  'Latvia',
                  'Lebanon',
                  'Lesotho',
                  'Lew Chew (Loochoo)',
                  'Liberia',
                  'Libya',
                  'Liechtenstein',
                  'Lithuania',
                  'Luxembourg',
                  'Madagascar',
                  'Malawi',
                  'Malaysia',
                  'Maldives',
                  'Mali',
                  'Malta',
                  'Marshall Islands',
                  'Mauritania',
                  'Mauritius',
                  'Mecklenburg-Schwerin',
                  'Mecklenburg-Strelitz',
                  'Mexico',
                  'Micronesia',
                  'Moldova',
                  'Monaco',
                  'Mongolia',
                  'Montenegro',
                  'Morocco',
                  'Mozambique',
                  'Namibia',
                  'Nassau',
                  'Nauru',
                  'Nepal',
                  'Netherlands',
                  'New Zealand',
                  'Nicaragua',
                  'Niger',
                  'Nigeria',
                  'North German Confederation',
                  'North German Union',
                  'North Macedonia',
                  'Norway',
                  'Oldenburg',
                  'Oman',
                  'Orange Free State',
                  'Pakistan',
                  'Palau',
                  'Panama',
                  'Papal States',
                  'Papua New Guinea',
                  'Paraguay',
                  'Peru',
                  'Philippines',
                  'Piedmont-Sardinia',
                  'Poland',
                  'Portugal',
                  'Qatar',
                  'Republic of Genoa',
                  'Republic of Korea (South Korea)',
                  'Republic of the Congo',
                  'Romania',
                  'Russia',
                  'Rwanda',
                  'Saint Kitts and Nevis',
                  'Saint Lucia',
                  'Saint Vincent and the Grenadines',
                  'Samoa',
                  'San Marino',
                  'Sao Tome and Principe',
                  'Saudi Arabia',
                  'Schaumburg-Lippe',
                  'Senegal',
                  'Serbia',
                  'Seychelles',
                  'Sierra Leone',
                  'Singapore',
                  'Slovakia',
                  'Slovenia',
                  'Solomon Islands',
                  'Somalia',
                  'South Africa',
                  'South Sudan',
                  'Spain',
                  'Sri Lanka',
                  'Sudan',
                  'Suriname',
                  'Sweden',
                  'Switzerland',
                  'Syria',
                  'Tajikistan',
                  'Tanzania',
                  'Thailand',
                  'Timor-Leste',
                  'Togo',
                  'Tonga',
                  'Trinidad and Tobago',
                  'Tunisia',
                  'Turkey',
                  'Turkmenistan',
                  'Tuvalu',
                  'Uganda',
                  'Ukraine',
                  'United Arab Emirates',
                  'United Kingdom',
                  'United States of America',
                  'Uruguay',
                  'Uzbekistan',
                  'Vanuatu',
                  'Venezuela',
                  'Vietnam',
                  'Yemen',
                  'Zambia',
                  'Zimbabwe'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                autofocus: false,
                controller: country5Controller,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return ("Please Enter Streams");
                  }
                  // reg expression for email validation
                  return null;
                },
                onSaved: (value) {
                  country5Controller.text = value!;
                },
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFF161616),
                  contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                  hintText: "",
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
                  padding: EdgeInsets.all(20),
                  child: Text(
                    "Enter Male Percentage",
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.normal,
                        fontSize: 13),
                  ),
                ),
              ),
              TextFormField(
                autofocus: false,
                controller: maleController,
                keyboardType: TextInputType.text,
                validator: (value) {},
                onSaved: (value) {
                  maleController.text = value!;
                },
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFF161616),
                  contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                  hintText: "",
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
                  padding: EdgeInsets.all(20),
                  child: Text(
                    "Enter Female Percentage",
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.normal,
                        fontSize: 13),
                  ),
                ),
              ),
              TextFormField(
                autofocus: false,
                controller: femaleController,
                keyboardType: TextInputType.text,
                validator: (value) {},
                onSaved: (value) {
                  femaleController.text = value!;
                },
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFF161616),
                  contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                  hintText: "",
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
                    postDetailsToFirestore();
                    country1Controller.text = "";
                    country2Controller.text = "";
                    country3Controller.text = "";
                    country4Controller.text = "";
                    country5Controller.text = "";
                    const SnackBar(
                      content: Text('Data Has Been Updated Successfully'),
                    );
                  },
                  child: const Text(
                    "Update Data",
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
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    "Social Media Earning Statistics",
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.normal,
                        fontSize: 20),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    "Facebook Videos",
                    style: const TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.normal,
                        fontSize: 13),
                  ),
                ),
              ),
              TextFormField(
                autofocus: false,
                controller: facebookController,
                keyboardType: TextInputType.text,
                validator: (value) {},
                onSaved: (value) {
                  facebookController.text = value!;
                },
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFF161616),
                  contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                  hintText: "",
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
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Text(
                    "Youtube",
                    style: const TextStyle(
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
                controller: youtubeController,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return ("Please Enter November Stream");
                  }
                  // reg expression for email validation
                  return null;
                },
                onSaved: (value) {
                  youtubeController.text = value!;
                },
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFF161616),
                  contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                  hintText: "",
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
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Text(
                    "Spotify",
                    style: const TextStyle(
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
                controller: spotifyController,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return ("Please Enter December");
                  }
                  // reg expression for email validation
                  return null;
                },
                onSaved: (value) {
                  spotifyController.text = value!;
                },
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFF161616),
                  contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                  hintText: "",
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
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Text(
                    "Apple Music",
                    style: const TextStyle(
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
                controller: appleMusicController,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return ("Please Enter November Stream");
                  }
                  // reg expression for email validation
                  return null;
                },
                onSaved: (value) {
                  appleMusicController.text = value!;
                },
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFF161616),
                  contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                  hintText: "",
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
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Text(
                    "Amazon",
                    style: const TextStyle(
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
                controller: amazonController,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return ("Please Enter Streams");
                  }
                  // reg expression for email validation
                  return null;
                },
                onSaved: (value) {
                  amazonController.text = value!;
                },
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFF161616),
                  contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                  hintText: "",
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
                    postDetailsToFirestore4();
                    facebookController.text = "";
                    youtubeController.text = "";
                    spotifyController.text = "";
                    appleMusicController.text = "";
                    amazonController.text = "";
                    const SnackBar(
                      content: Text('Data Has Been Updated Successfully'),
                    );
                  },
                  child: const Text(
                    "Update Social Media balance",
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
            ],
          ),
        ));
  }

  postDetailsToFirestore() async {
    UserModel userModel = UserModel();

    // writing all the values
    userModel.country1 = country1Controller.text;
    userModel.country2 = country2Controller.text;
    userModel.country3 = country3Controller.text;
    userModel.country4 = country4Controller.text;
    userModel.country5 = country5Controller.text;
    userModel.country1Name = value;
    userModel.country2Name = value1;
    userModel.country3Name = value2;
    userModel.country4Name = value3;
    userModel.country5Name = value4;
    userModel.male = maleController.text;
    userModel.female = femaleController.text;
    await FirebaseFirestore.instance
        .collection("users")
        .doc(widget.uid)
        .update(userModel.toMapPieData());
  }

  postDetailsToFirestore1() async {
    UserModel userModel = UserModel();

    // writing all the values
    if (janController.text == "") {
      userModel.jan = '0';
    } else {
      userModel.jan = janController.text;
    }
    if (febController.text == "") {
      userModel.feb = '0';
    } else {
      userModel.feb = febController.text;
    }
    if (marController.text == "") {
      userModel.mar = '0';
    } else {
      userModel.mar = marController.text;
    }
    if (aprilController.text == "") {
      userModel.april = '0';
    } else {
      userModel.april = aprilController.text;
    }
    if (mayController.text == "") {
      userModel.may = '0';
    } else {
      userModel.may = mayController.text;
    }
    if (juneController.text == "") {
      userModel.june = '0';
    } else {
      userModel.june = juneController.text;
    }
    if (julController.text == "") {
      userModel.jul = '0';
    } else {
      userModel.jul = julController.text;
    }
    if (augController.text == "") {
      userModel.aug = '0';
    } else {
      userModel.aug = augController.text;
    }
    if (sepController.text == "") {
      userModel.sep = '0';
    } else {
      userModel.sep = sepController.text;
    }
    if (octController.text == "") {
      userModel.oct = '0';
    } else {
      userModel.oct = octController.text;
    }
    if (novController.text == "") {
      userModel.nov = '0';
    } else {
      userModel.nov = novController.text;
    }
    if (decController.text == "") {
      userModel.dec = '0';
    } else {
      userModel.dec = decController.text;
    }

    await FirebaseFirestore.instance
        .collection("users")
        .doc(widget.uid)
        .update(userModel.toMapYoutubeData());
  }

  postDetailsToFirestore2() async {
    UserModel userModel = UserModel();

    // writing all the values
    if (jan1Controller.text == "") {
      userModel.jan1 = '0';
    } else {
      userModel.jan1 = jan1Controller.text;
    }
    if (feb1Controller.text == "") {
      userModel.feb1 = '0';
    } else {
      userModel.feb1 = feb1Controller.text;
    }
    if (mar1Controller.text == "") {
      userModel.mar1 = '0';
    } else {
      userModel.mar1 = mar1Controller.text;
    }
    if (april1Controller.text == "") {
      userModel.april1 = '0';
    } else {
      userModel.april1 = april1Controller.text;
    }
    if (may1Controller.text == "") {
      userModel.may1 = '0';
    } else {
      userModel.may1 = may1Controller.text;
    }
    if (june1Controller.text == "") {
      userModel.june1 = '0';
    } else {
      userModel.june1 = june1Controller.text;
    }
    if (jul1Controller.text == "") {
      userModel.jul1 = '0';
    } else {
      userModel.jul1 = jul1Controller.text;
    }
    if (aug1Controller.text == "") {
      userModel.aug1 = '0';
    } else {
      userModel.aug1 = aug1Controller.text;
    }
    if (sep1Controller.text == "") {
      userModel.sep1 = '0';
    } else {
      userModel.sep1 = sep1Controller.text;
    }
    if (oct1Controller.text == "") {
      userModel.oct1 = '0';
    } else {
      userModel.oct1 = oct1Controller.text;
    }
    if (nov1Controller.text == "") {
      userModel.nov1 = '0';
    } else {
      userModel.nov1 = nov1Controller.text;
    }
    if (dec1Controller.text == "") {
      userModel.dec1 = '0';
    } else {
      userModel.dec1 = dec1Controller.text;
    }

    await FirebaseFirestore.instance
        .collection("users")
        .doc(widget.uid)
        .update(userModel.toMapStreamsAndRoyaltiesData());
  }

  postDetailsToFirestore3() async {
    UserModel userModel = UserModel();

    // writing all the values
    userModel.royalties = streamsController.text;
    userModel.views = viewsController.text;
    userModel.earning = royaltiesController.text;
    await FirebaseFirestore.instance
        .collection("users")
        .doc(widget.uid)
        .update(userModel.toMapStatements());
  }

  postDetailsToFirestore4() async {
    UserModel userModel = UserModel();

    // writing all the values
    userModel.amazon = streamsController.text;
    userModel.facebookVideo = viewsController.text;
    userModel.youtube = royaltiesController.text;
    userModel.spotify = royaltiesController.text;
    userModel.appleMusic = royaltiesController.text;
    await FirebaseFirestore.instance
        .collection("users")
        .doc(widget.uid)
        .update(userModel.toMapEarningSocialMedia());
  }
}
