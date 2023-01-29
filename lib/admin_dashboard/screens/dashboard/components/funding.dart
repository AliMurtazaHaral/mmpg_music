import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../model/user_model.dart';
import '../../main/components/side_menu.dart';

class Funding extends StatefulWidget {
  const Funding({Key? key}) : super(key: key);

  @override
  _FundingState createState() => _FundingState();
}

class _FundingState extends State<Funding> {
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
            'Funding',
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
                                                        FundingSection(
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

class FundingSection extends StatefulWidget {
  final String uid;
  const FundingSection({Key? key, required this.uid}) : super(key: key);

  @override
  _FundingSectionState createState() => _FundingSectionState();
}

class _FundingSectionState extends State<FundingSection> {
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
              'Enable/Disable',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 250,
            ),
            Material(
              elevation: 5,
              borderRadius: BorderRadius.circular(10),
              color: Colors.blue,
              child: MaterialButton(
                padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                minWidth: MediaQuery.of(context).size.width,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Funding(),
                    ),
                  );
                },
                child: const Text(
                  "Enable Funding",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(
              height: 80,
            ),
            Material(
              elevation: 5,
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey,
              child: MaterialButton(
                padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                minWidth: MediaQuery.of(context).size.width,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Funding(),
                    ),
                  );
                },
                child: const Text(
                  "Disable Funding",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ));
  }
}
