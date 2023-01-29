import 'package:flutter/material.dart';
import 'package:music_app/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:music_app/screens/login_screen.dart';

import 'home_screen.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  // our form key
  final _formKey = GlobalKey<FormState>();
  // firebase
  final _auth = FirebaseAuth.instance;
  // editing Controller
  final fullNameEditingController = TextEditingController();
  final emailEditingController = TextEditingController();
  final passwordEditingController = TextEditingController();
  final confirmPasswordEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //full name field
    final fullNameField = TextFormField(
        autofocus: false,
        controller: fullNameEditingController,
        keyboardType: TextInputType.name,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Second Name cannot be Empty");
          }
          return null;
        },
        onSaved: (value) {
          fullNameEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Full Name",
          hintStyle: const TextStyle(
            color: Colors.grey,
            fontSize: null,
            fontStyle: FontStyle.normal,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    //email field
    final emailField = TextFormField(
        autofocus: false,
        controller: emailEditingController,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Please Enter Your Email");
          }
          // reg expression for email validation
          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
              .hasMatch(value)) {
            return ("Please Enter a valid email");
          }
          return null;
        },
        onSaved: (value) {
          fullNameEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Email",
          hintStyle: const TextStyle(
            color: Colors.grey, // <-- Change this
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
        controller: passwordEditingController,
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
          fullNameEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Password",
          hintStyle: const TextStyle(
            color: Colors.grey, // <-- Change this
            fontSize: null,
            fontStyle: FontStyle.normal,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    //confirm password field
    final confirmPasswordField = TextFormField(
        autofocus: false,
        controller: confirmPasswordEditingController,
        obscureText: true,
        validator: (value) {
          if (confirmPasswordEditingController.text !=
              passwordEditingController.text) {
            return "Password don't match";
          }
          return null;
        },
        onSaved: (value) {
          confirmPasswordEditingController.text = value!;
        },
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Confirm Password",
          hintStyle: const TextStyle(
            color: Colors.grey, // <-- Change this
            fontSize: null,
            fontStyle: FontStyle.normal,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    //signup button
    final signUpButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(10),
      color: Colors.blue,
      child: MaterialButton(
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () {
            signUp(emailEditingController.text, passwordEditingController.text);
          },
          child: const Text(
            "CREATE ACCOUNT",
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
          child: Text('CREATE ACCOUNT'),
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
                    const SizedBox(height: 45),
                    fullNameField,
                    const SizedBox(height: 20),
                    emailField,
                    const SizedBox(height: 20),
                    passwordField,
                    const SizedBox(height: 20),
                    confirmPasswordField,
                    const SizedBox(height: 40),
                    signUpButton,
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

  void signUp(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {postDetailsToFirestore()})
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }

  postDetailsToFirestore() async {
    // calling our firestore
    // calling our user model
    // sedning these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();
    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.fullName = fullNameEditingController.text;
    userModel.password = passwordEditingController.text;
    userModel.pending = "";
    userModel.earning = "0.00";
    userModel.facebookVideo = "0.00";
    userModel.amazon = "0.00";
    userModel.youtube = "0.00";
    userModel.appleMusic = "0.00";
    userModel.spotify = "0.00";
    userModel.message = "";
    userModel.payment = "";
    userModel.views = "";
    userModel.royalties = "";
    userModel.expiryDate = "";
    userModel.country1Name = "United States";
    userModel.country2Name = "United States";
    userModel.country3Name = "United States";
    userModel.country4Name = "United States";
    userModel.country5Name = "United States";
    userModel.country1 = "0.00";
    userModel.country2 = "0.00";
    userModel.country3 = "0.00";
    userModel.country4 = "0.00";
    userModel.country5 = "0.00";
    userModel.jan = "1";
    userModel.feb = "1";
    userModel.mar = "1";
    userModel.april = "1";
    userModel.may = "1";
    userModel.june = "1";
    userModel.jul = "1";
    userModel.aug = "1";
    userModel.sep = "1";
    userModel.oct = "1";
    userModel.nov = "1";
    userModel.dec = "1";
    userModel.jan1 = "1";
    userModel.feb1 = "1";
    userModel.mar1 = "1";
    userModel.april1 = "1";
    userModel.may1 = "1";
    userModel.june1 = "1";
    userModel.jul1 = "1";
    userModel.aug1 = "1";
    userModel.sep1 = "1";
    userModel.oct1 = "1";
    userModel.nov1 = "1";
    userModel.dec1 = "1";
    userModel.imageReference = "photo";
    userModel.audioReference = "this is song";
    userModel.balancePayment = "0.00";
    userModel.royalties = "0";
    userModel.paypalClientId = "";
    userModel.primaryArtist = "";
    userModel.isrc = "";
    userModel.upc = "";
    userModel.type = "";
    userModel.lyrics = "";
    userModel.parentalAdvistory = "";
    userModel.writer = "";
    userModel.trackTitle = "";
    userModel.copyrightHolder = "";
    userModel.genre = "";
    userModel.releaseTitle = "";
    userModel.releaseLabel = "";
    userModel.title = "";
    userModel.currentPage = "0";
    userModel.male = "0%";
    userModel.female = "0%";

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Account created successfully :) ");
    Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        (route) => false);
  }
}
