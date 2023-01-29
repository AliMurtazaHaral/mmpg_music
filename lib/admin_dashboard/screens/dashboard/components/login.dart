import 'package:music_app/screens/promotion_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../model/user_model.dart';
import '../../../../screens/login_screen.dart';
import '../../../constants.dart';
import '../../../controllers/MenuController.dart';
import '../../main/main_screen.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // form key
  final _formKey = GlobalKey<FormState>();
  // firebase
  final _auth = FirebaseAuth.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  // editing controller
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  UserModel loggedInUser = UserModel();
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("admin")
        .doc("jFEg1fSzf5fGAIKInMVkTFabcmJ3")
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMapAdmin(value.data());
      setState(() {});
    });
  }

  @override
  Future<void> resetPassword(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  @override
  Widget build(BuildContext context) {
    //email field

    final nameField = TextFormField(
        autofocus: false,
        controller: usernameController,
        keyboardType: TextInputType.emailAddress,
        onSaved: (value) {
          usernameController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Username",
          hintStyle: const TextStyle(
            color: Colors.grey,
            fontSize: null,
            fontStyle: FontStyle.normal,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));
    //password field
    final passwordField = TextFormField(
        autofocus: false,
        controller: passwordController,
        obscureText: true,
        validator: (value) {
          RegExp regex = RegExp(r'^.{6,}$');
          if (value!.isEmpty) {
            return ("Password is required for login");
          }
          if (!regex.hasMatch(value)) {
            return ("Enter Valid Password(Min. 6 Character)");
          }
        },
        onSaved: (value) {
          passwordController.text = value!;
        },
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Password",
          hintStyle: const TextStyle(
            color: Colors.grey,
            fontSize: null,
            fontStyle: FontStyle.normal,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    final loginButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(10),
      color: Colors.blue,
      child: MaterialButton(
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () {
            if (usernameController.text.toString() == loggedInUser.adminName) {
              signIn("admin@mmpgmusic.com", passwordController.text);
            } else {
              Fluttertoast.showToast(msg: "Login Unsuccessful");
            }
          },
          child: const Text(
            "SIGN IN",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
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
          alignment: Alignment.centerRight,
          child: Text('WELCOME ADMIN'),
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
                    const SizedBox(height: 30),
                    nameField,
                    const SizedBox(height: 25),
                    passwordField,
                    GestureDetector(
                      onTap: () {
                        resetPassword("admin@mmpgmusic.com");
                        Fluttertoast.showToast(
                            msg: "Link has sent to your email");
                      },
                      child: Row(
                        children: const [
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "                                                                Reset Password",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 35),
                    loginButton,
                    const SizedBox(height: 15),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void signIn(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((uid) => {
                Fluttertoast.showToast(msg: "Login Successful"),
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MultiProvider(
                      providers: [
                        ChangeNotifierProvider(
                          create: (context) => MenuController(),
                        ),
                      ],
                      child: MainScreen(),
                    ),
                  ),
                ),
              })
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }
}
