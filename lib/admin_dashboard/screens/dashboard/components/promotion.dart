import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_app/screens/dashboard.dart';

import '../../main/components/side_menu.dart';

class Promotion extends StatefulWidget {
  const Promotion({Key? key}) : super(key: key);

  @override
  _PromotionState createState() => _PromotionState();
}

class _PromotionState extends State<Promotion> {
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController linkController = TextEditingController();
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
            'Promotion',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 200,
              ),
              TextFormField(
                autofocus: false,
                controller: linkController,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return ("Please Enter UPC");
                  }
                  // reg expression for email validation
                  return null;
                },
                onSaved: (value) {
                  linkController.text = value!;
                },
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                  hintText: "Please Enter link Here",
                  hintStyle: const TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              TextFormField(
                autofocus: false,
                controller: descriptionController,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return ("Please Enter ISRC");
                  }
                  // reg expression for email validation
                  return null;
                },
                onSaved: (value) {
                  descriptionController.text = value!;
                },
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                  hintText: "Please Enter Link's Description Here",
                  hintStyle: const TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                    fontStyle: FontStyle.normal,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
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
                          builder: (context) => const Dashboard(),
                        ),
                      );
                    },
                    child: const Text(
                      "Update Page",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
