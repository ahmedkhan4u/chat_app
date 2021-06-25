import 'dart:collection';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatefulWidget {
  static String id = 'chat_screen';

  @override
  State<StatefulWidget> createState() {
    return _ChatScreenState();
  }
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;
  String loggedInUser, message;
  final _firebaseFirestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final currentUser = await _auth.currentUser;
      if (currentUser != null) {
        loggedInUser = currentUser.email;
        print("Email : " + loggedInUser);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                _auth.signOut();
                Navigator.pop(context);
              })
        ],
        centerTitle: true,
        title: Text('Chats'),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[

            StreamBuilder<QuerySnapshot>(
              stream: _firebaseFirestore.collection('messages').snapshots(),
                builder: (context,snapshot){
                if (!snapshot.hasData){
                  return CircularProgressIndicator(
                    backgroundColor: Colors.blue,
                  );
                }

                final messageWidgets = <Widget>[];
                final messages = snapshot.data.documents;

                for (var message in messages){
                  final messageText = message.data();

                   final messageWidget = Text(messageText['message']);
                   //MaterialBubble(text: messageText['message'],
                   //email: messageText['sender'],);
                  messageWidgets.add(messageWidget);
                }
                return ListView(
                  children: messageWidgets,
                );

                },
            ),

            Container(
              padding: EdgeInsets.fromLTRB(16, 8, 0, 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,

                children: [
                  Expanded(child: TextField(

                    decoration: InputDecoration(
                      hintText: 'Type your message',

                    ),
                    onChanged: (value) {
                      message = value;
                    },
                  )),
                  FlatButton(
                      onPressed: () async{
                        print(message);

                        var map = {
                          'message' : message,
                          'sender' : loggedInUser
                        };

                        try{
                          await _firebaseFirestore.collection('messages')
                              .add(map);
                        }catch(ex){
                          print(ex);
                        }

                      },
                      child: Icon(
                        Icons.send,
                        color: Colors.blue,
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
  void getMessages()async{

    try{
      await for (var snapshot in _firebaseFirestore.collection('messages').snapshots())
      for (var data in snapshot.documents){
        print(data.data());
      }

    }catch(e){
      print(e);
    }
  }
}

class MaterialBubble extends StatelessWidget{

  MaterialBubble({this.text, this.email});

  final String text, email;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return
      Column(
        children: [
          Text(email),
        ],
    );
  }
}
