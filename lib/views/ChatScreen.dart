import 'package:flutter/material.dart';
import 'package:project/helper/constants.dart';
import 'package:project/helper/helperfunctions.dart';
import 'package:project/services/auth.dart';
import 'package:project/services/database.dart';
import 'package:project/views/ConversationScreen.dart';
import 'package:project/views/search.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();

  Stream chatRoomsStream;

  Widget chatRoomList() {
    return StreamBuilder(
        stream: chatRoomsStream,
        builder: (context,snapshot) {
          return snapshot.hasData ? ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context,index) {
             return ChatRoomTile(snapshot.data.docs[index].data()["chatRoomID"]
             .toString().replaceAll("_", "").replaceAll(Constants.myName, ""),
             snapshot.data.docs[index].data()["chatRoomID"]);
          }) : Container();
    },
    );
  }

  getUserInfo() async {
    Constants.myName = await HelperFunctions.getUserNameSharedPreference();
    databaseMethods.getChatRooms(Constants.myName).then((value) {
      setState(() {
        chatRoomsStream = value;
      });
    });
    setState(() {
    });
  }

  @override
  void initState() {
   getUserInfo();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        toolbarHeight: 55.0,
        backgroundColor: Colors.indigo[300],
       centerTitle: false,
        title: Text("Inner Bloom",
        style: TextStyle(
          fontSize: 22.0),),


      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        backgroundColor: Colors.indigo[300],
        onPressed: (){
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => SearchScreen()));
        },
      ),
      body: chatRoomList(),
    );
  }
}

class ChatRoomTile extends StatelessWidget {
  final String userName;
  final String chatRoomID;
  ChatRoomTile(this.userName,this.chatRoomID);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => ConversationScreen(chatRoomID)));
      },
      child: Container(
        color: Colors.indigo[400],
        padding: EdgeInsets.symmetric(horizontal: 24,vertical: 16),

        child: Row(
          children: [
            Container(
              alignment: Alignment.center,
              height: 45.0,
              width: 40.0,
              decoration: BoxDecoration(
                color: Colors.indigo[200],
                borderRadius: BorderRadius.circular(40)
              ),
                child : Text("${userName.substring(0,1).toUpperCase()}")),
            SizedBox(
              width: 8),
            Text(userName,
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.white

            ),)
          ],
        ),
      ),
    );
  }
}
