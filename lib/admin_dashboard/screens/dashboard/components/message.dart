import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

import '../../main/components/side_menu.dart';

class MessageSection extends StatefulWidget {
  const MessageSection({Key? key}) : super(key: key);

  @override
  _MessageSectionState createState() => _MessageSectionState();
}

class _MessageSectionState extends State<MessageSection> {
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
            'MESSAGES',
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
                                  key: ValueKey(
                                      streamSnapshot.data?.docs[index]["uid"]),
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "${index + 1}: ${streamSnapshot.data?.docs[index]['fullName']}",
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                        ),
                                        Flexible(
                                          child: RichText(
                                            overflow: TextOverflow.ellipsis,
                                            strutStyle: const StrutStyle(
                                                fontSize: 12.0),
                                            text: TextSpan(
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 19),
                                                text: streamSnapshot.data
                                                    ?.docs[index]['message']
                                                    .toString()),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => Message(
                                                  uid: streamSnapshot
                                                      .data?.docs[index]['uid'],
                                                  name: streamSnapshot.data
                                                      ?.docs[index]['fullName'],
                                                  email: streamSnapshot.data
                                                      ?.docs[index]['email'],
                                                  message: streamSnapshot.data
                                                      ?.docs[index]['message'],
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
                                                  "SEND FEEDBACK",
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

class Message extends StatefulWidget {
  final String uid;
  final String name;
  final String email;
  final String message;
  const Message(
      {Key? key,
      required this.uid,
      required this.message,
      required this.email,
      required this.name})
      : super(key: key);

  @override
  _MessageState createState() => _MessageState();
}

class _MessageState extends State<Message> {
  final _formKey = GlobalKey<FormState>();
  // firebase
  final _auth = FirebaseAuth.instance;
  final TextEditingController helpController = TextEditingController();
  sendEmail(
      {required String name,
      required String email,
      required String message}) async {
    const serviceId = 'service_t21s749';
    const tempelateId = 'template_toco95j';
    const userId = 'user_xLibJVe1ZyDm9xKt4TLCw';
    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    final response = await http.post(url,
        headers: {
          'Content-Type': "application/json",
        },
        body: json.encode({
          'service_id': serviceId,
          'template_id': tempelateId,
          'user_id': userId,
          'template_params': {
            'to_name': name,
            'reply_to': email,
            'message': message,
          }
        }));
    print("Sent successfully");
    print(name);
    print(email);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //email field
    final emailField = Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: TextFormField(
        autofocus: false,
        controller: helpController,
        keyboardType: TextInputType.text,
        validator: (value) {
          if (value!.length > 5000) {
            return ("Please Enter Your Less Characters");
          }
          return null;
        },
        onSaved: (value) {
          helpController.text = value!;
        },
        textInputAction: TextInputAction.next,
        maxLines: 10,
        decoration: const InputDecoration(
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Your Message",
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: null,
            fontStyle: FontStyle.normal,
          ),
          border: OutlineInputBorder(),
        ),
      ),
    );

    final sendMessageButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(10),
      color: Colors.blue,
      child: MaterialButton(
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: 100,
          onPressed: () async {
            sendEmail(
                name: widget.name,
                email: widget.email,
                message: helpController.text);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const MessageSection()));
          },
          child: const Text(
            "Send Messages",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );

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
            'Help',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.black,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
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
                        child: Column(
                          children: [
                            const SizedBox(height: 10),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "     Message: ${widget.message}",
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(height: 20),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "     Reply",
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            emailField,
                            const Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "5000 Character(s) left    ",
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            const SizedBox(height: 25),
                            const SizedBox(height: 35),
                            Row(
                              children: [
                                const SizedBox(
                                  width: 120,
                                ),
                                Material(
                                  elevation: 5,
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.transparent,
                                  child: MaterialButton(
                                    padding: const EdgeInsets.fromLTRB(
                                        20, 15, 20, 15),
                                    minWidth: 100,
                                    onPressed: () {},
                                    child: const Text(
                                      "Cancel",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                sendMessageButton,
                              ],
                            ),
                            const SizedBox(height: 15),
                          ],
                        )),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
