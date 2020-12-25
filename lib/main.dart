import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:project/views/ConversationScreen.dart';
import 'package:project/views/LoginPage.dart';
import 'views/SlidePages.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());

}
class MyApp extends StatelessWidget {

  @override

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login/Sign Up',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        pageTransitionsTheme: PageTransitionsTheme(builders: {TargetPlatform.android: CupertinoPageTransitionsBuilder(),}),

      ),
      home: LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }

  getConversationMessages(String chatRoomID, messageMap) {
    FirebaseFirestore.instance.collection("ChatRoom")
        .doc(chatRoomID)
        .collection("chats")
        .add(messageMap).catchError((e){print(e.toString());});
  }
}



//return container in searchTile or maybe not return.