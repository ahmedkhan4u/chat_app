import 'package:chat_app/app_screens/login_screen.dart';
import 'package:chat_app/app_screens/register_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chat_app/components/my_raised_button.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = "welcome_screen";

  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(duration: Duration(seconds: 1), vsync: this);

    //animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);
    animation =
        ColorTween(begin: Colors.grey, end: Colors.white).animate(controller);
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Welcome'),
      ),
      body: Container(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Hero(
                  tag: 'logo',
                  child: Container(
                    height: 48,
                    child: Image.asset(
                      'assets/chat_icon.png',
                      color: Colors.lightBlue,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                TypewriterAnimatedTextKit(
                  text: ["Chat App"],
                  textStyle: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54),
                ),
              ],
            ),
            SizedBox(
              height: 16,
            ),
            MyRaisedButton(
              color: Colors.lightBlue,
              title: "Login",
              onPressed: (){
                Navigator.pushNamed(context, LoginScreen.id);
              },
            ),

            SizedBox(
              height: 16,
            ),
            MyRaisedButton(
              color: Colors.blue,
              title: "Register",
              onPressed: (){
                Navigator.pushNamed(context, RegisterScreen.id);
              },
            )
          ],
        ),
      ),
    );
  }
}

