import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_app/screens/login_screen.dart';
import 'package:music_app/screens/registration_screen.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class SignUpLogin extends StatefulWidget {
  const SignUpLogin({Key? key}) : super(key: key);

  @override
  _SignUpLoginState createState() => _SignUpLoginState();
}

class _SignUpLoginState extends State<SignUpLogin> {
  late VideoPlayerController videoPlayerController;

  ChewieController? chewieController;
  // init State
  @override
  void initState() {
    super.initState();
    videoPlayerController = VideoPlayerController.asset("assets/background.mp4")
      ..initialize().then((_) {
        // Once the video has been loaded we play the video and set looping to true.
        videoPlayerController.play();
        videoPlayerController.setLooping(true);
        // Ensure the first frame is shown after the video is initialized.
        setState(() {});
      });
  }

  @override
  void dispose() {
    super.dispose();
    videoPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final signInButton = ButtonTheme(
      height: 200,
      minWidth: MediaQuery.of(context).size.width * 0.3,
      child: GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const LoginScreen()));
          },
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.blue,
                  width: 5,
                ),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: const Padding(
              padding: EdgeInsets.fromLTRB(52, 9, 52, 9),
              child: Text(
                'SIGN IN',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.normal),
              ),
            ),
          )),
    );
    final signUpButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(10),
      color: Colors.blue,
      child: MaterialButton(
          padding: const EdgeInsets.fromLTRB(52, 15, 52, 15),
          minWidth: MediaQuery.of(context).size.width * 0.3,
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const RegistrationScreen()));
            //signIn(emailController.text, passwordController.text);
          },
          child: const Text(
            "SIGN UP",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.normal),
          )),
    );
    return Scaffold(
      body: Stack(
        fit: StackFit.passthrough,
        children: [
          SizedBox.expand(
            child: FittedBox(
              // If your background video doesn't look right, try changing the BoxFit property.
              // BoxFit.fill created the look I was going for.
              fit: BoxFit.fill,
              child: SizedBox(
                width: videoPlayerController.value.size?.width ?? 0,
                height: videoPlayerController.value.size?.height ?? 0,
                child: VideoPlayer(videoPlayerController),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 0),
                Padding(
                  padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: SizedBox(
                      child: Image.asset(
                        "assets/logo1.png",
                        fit: BoxFit.contain,
                        width: 90,
                        height: 130,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(40, 0, 0, 0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Expanded(
                      child: Text(
                        'YOUR \n'
                        'MUSIC...',
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(40, 0, 0, 0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'TAKE CONTROL!',
                      style: TextStyle(
                        fontSize: 30,
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 1
                          ..color = Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(40, 0, 0, 0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'EMPOWERING CREATORS WORLDWIDE.',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                          color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    signUpButton,
                    const SizedBox(
                      width: 20,
                    ),
                    signInButton,
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
