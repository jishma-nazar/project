import 'package:flutter/material.dart';
import 'package:project/services/auth.dart';
import 'package:project/views/ChatScreen.dart';

import 'package:project/views/VideoCall.dart';
import 'package:project/views/VoiceCall.dart';
import 'package:project/views/LoginPage.dart';

class TempPage extends StatelessWidget {
  AuthMethods authMethods = new AuthMethods();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60.0,
        backgroundColor: Colors.indigo[300],
        automaticallyImplyLeading: true,
        title: Text("Inner Bloom",
        style: TextStyle(
          fontSize: 22.0,
          color: Colors.white
        ),),
        centerTitle: false,
        actions: [
          GestureDetector(

            onTap: (){
              authMethods.signOut();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(Icons.exit_to_app),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Button(text: "Chat",icon: Icons.chat,
              onPressed: (){
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => ChatScreen()));
              },),
            Button(text: "Voice Call",icon: Icons.call,
            onPressed: (){
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => VoiceCall()));
              }
            ),
            Button(text: "Video Call",icon: Icons.video_call,
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => VideoCall()));
            }),


          ],
        ),
      ),
    );
  }
}

class Button extends StatelessWidget {
  final String text;
  final IconData icon;
  Function onPressed;
  Button({this.text,this.icon,this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 20.0),
      child: MaterialButton(
        onPressed: onPressed,
        height: 100,
        color: Colors.deepPurple[200],
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(70.0)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 30.0
            ),),
            SizedBox(width: 10.0),
            Icon(icon,color: Colors.white,
            size: 30,)
          ],
        ),
      ),
    );
  }
}
