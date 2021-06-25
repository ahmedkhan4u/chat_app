import 'package:chat_app/app_screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/constants.dart';
import 'package:chat_app/components/my_raised_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class RegisterScreen extends StatefulWidget{
  static String id = "register_screen";
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<RegisterScreen>{
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  String email, password;
  final _auth = FirebaseAuth.instance;
  bool _progress = false;
  @override
  void initState() {
    Firebase.initializeApp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Register'),
      ),
      
      body:ModalProgressHUD(
        inAsyncCall: _progress,
        child: Container(
          padding: EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Center(
              child: ListView(
                shrinkWrap: true,
                children: [

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Hero(
                        tag: 'logo',
                        child: Image(
                          width: 64,
                          height: 64,
                          color: Colors.lightBlue,
                          image: AssetImage('assets/chat_icon.png'),
                        ),
                      ),

                      SizedBox(width: 10),
                      //Text("Chat App", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
                    ],
                  ),

                  SizedBox(height: 16,),

                  TextFormField(

                    validator: (value){
                      if (value.isEmpty){
                        return 'Required';
                      }
                      return null;
                    },

                      keyboardType: TextInputType.emailAddress,
                    textAlign: TextAlign.center,
                      onChanged: (value){
                        email = value;
                      },
                    decoration: kTextFieldDecoration.copyWith(labelText: 'Email')
                  ),

                  SizedBox(height: 8,),

                  TextFormField(
                    validator: (value){
                      if (value.isEmpty){
                        return 'Required';
                      }
                      return null;
                    },
                    textAlign: TextAlign.center,
                      obscureText: true,
                    onChanged: (value){
                      password = value;
                    },
                    decoration: kTextFieldDecoration.copyWith(labelText: 'Password')
                  ),

                  SizedBox(height: 16,),

                  MyRaisedButton(
                    color: Colors.lightBlue,
                    title: "Register",
                    padding: 22,
                    onPressed: (){
                      progressBar(true);
                      setState(() async {
                        if (_formKey.currentState.validate()){
                          try {
                            final newUser = await _auth
                                .createUserWithEmailAndPassword(
                                email: email, password: password);
                            if (newUser != null){
                              Navigator.pushNamed(context, ChatScreen.id);
                              progressBar(false);
                            }

                          }catch(ex){print(ex);
                            progressBar(false);
                          }
                        }
                      });
                      //Navigator.pushNamed(context, LoginScreen.id);
                    },
                  ),


                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void progressBar(bool progress){
    setState(() {
      _progress = progress;
    });
  }
}