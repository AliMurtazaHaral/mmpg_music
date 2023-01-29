import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../model/user_model.dart';
import '../../main/components/side_menu.dart';
import 'package:intl/intl.dart';

class Statement extends StatefulWidget {
  const Statement({Key? key}) : super(key: key);

  @override
  _StatementState createState() => _StatementState();
}

class _StatementState extends State<Statement> {
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
            'Statements',
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
                                                        StatementSection(
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

class StatementSection extends StatefulWidget {
  final String uid;

  const StatementSection({
    Key? key,
    required this.uid,
  }) : super(key: key);

  @override
  _StatementSectionState createState() => _StatementSectionState();
}

class _StatementSectionState extends State<StatementSection> {
  final TextEditingController janController = TextEditingController();
  final TextEditingController balancePaymentController =
      TextEditingController();
  final TextEditingController royaltiesController = TextEditingController();
  final TextEditingController paymentController = TextEditingController();
  String value = 'United Kingdom';
  String value1 = 'United Kingdom';
  String value2 = 'United Kingdom';
  String value3 = 'United Kingdom';
  String value4 = 'United Kingdom';
  DateTime currentDate = DateTime.now();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(2015),
        lastDate: DateTime(2050));
    if (pickedDate != null && pickedDate != currentDate) {
      setState(() {
        currentDate = pickedDate;
      });
    }
  }

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
              'Statements',
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
                    "Statements",
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
                    "Period",
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
                controller: janController,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return ("Please Enter Period");
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
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Text(
                    "Balance Payments",
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
                controller: balancePaymentController,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return ("Please Enter February Stream");
                  }
                  // reg expression for email validation
                  return null;
                },
                onSaved: (value) {
                  balancePaymentController.text = value!;
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
                    "Royalties",
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
                controller: royaltiesController,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return ("Please Enter March Streams");
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
                    postDetailsToFirestore();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Statement(),
                      ),
                    );
                  },
                  child: const Text(
                    "Apply Changes",
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
            ],
          ),
        ));
  }

  postDetailsToFirestore() async {
    UserModel userModel = UserModel();

    // writing all the values
    userModel.royalties1 = royaltiesController.text;
    userModel.period = janController.text;
    userModel.balancePayment1 = balancePaymentController.text;
    await FirebaseFirestore.instance
        .collection("users")
        .doc(widget.uid)
        .collection("statements")
        .add(userModel.toMapStatements1());
  }
}
