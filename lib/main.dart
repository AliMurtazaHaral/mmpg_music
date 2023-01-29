import 'package:flutter/material.dart';
import 'package:music_app/admin_dashboard/screens/dashboard/components/login.dart';
import 'package:music_app/screens/earning_page.dart';
import 'package:music_app/screens/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:music_app/screens/signup_login.dart';
import 'package:music_app/screens/splash_screen.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'admin_dashboard/constants.dart';
import 'admin_dashboard/controllers/MenuController.dart';
import 'admin_dashboard/screens/main/main_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SignUpLogin(),
    );
  }
}
