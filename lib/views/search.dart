import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project/helper/constants.dart';
import 'package:project/services/database.dart';
import 'package:project/views/ConversationScreen.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController searchTextEditingController =
  new TextEditingController();

  QuerySnapshot searchSnapshot;


  Widget searchList() {
    return searchSnapshot != null
        ? ListView.builder(
        itemCount: searchSnapshot.docs.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return searchTile(
            userName: searchSnapshot.docs[index].data()["name"],
            userEmail: searchSnapshot.docs[index].data()["email"],
          );
        })
        : Container();
  }

  initiateSearch() {
    databaseMethods
        .getUserByUsername(searchTextEditingController.text)
        .then((val) {
      setState(() {
        searchSnapshot = val;
      });
    });
  }



  createChatRoomAndStartConversation({String userName}) {
    if (userName != Constants.myName) {
      String chatRoomID = getChatRoomID(userName, Constants.myName);
      List<String> users = [userName, Constants.myName];
      Map<String, dynamic> chatRoomMap = {
        "users": users,
        "chatRoomID": chatRoomID
      };

      DatabaseMethods().createChatRoom(chatRoomID, chatRoomMap);
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ConversationScreen(chatRoomID)));
    } else {
      print("You cannot");
    }
  }

    Widget searchTile({String userName, String userEmail}) {
      return Container(
        color: Colors.indigo[200],
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userName,
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                ),
                Text(
                  userEmail,
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                )
              ],
            ),
            Spacer(),
            GestureDetector(
              onTap: () {
                createChatRoomAndStartConversation(
                    userName: userName
                );
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.deepPurple[400],
                    borderRadius: BorderRadius.circular(30)),
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(
                  "Message",
                  style: TextStyle(color: Colors.white, fontSize: 18.0),
                ),
              ),
            ),
          ],
        ),
      );
    }


    @override
    void initState() {
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
          title: Text(
            "Inner Bloom",
            style: TextStyle(fontSize: 22.0),
          ),
        ),
        body: Container(
          child: Column(
            children: [
              Container(
                color: Colors.indigo[100].withOpacity(0.80),
                padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                child: Row(
                  children: [
                    Expanded(
                        child: TextField(
                          controller: searchTextEditingController,
                          decoration: InputDecoration(
                              hintText: "Search...",
                              hintStyle: TextStyle(color: Colors.black),
                              border: InputBorder.none),
                        )),
                    SizedBox(
                      width: 60,
                    ),
                    GestureDetector(
                      child: Container(
                        height: 47.0,
                        width: 47.0,
                        padding: EdgeInsets.all(12.0),
                        child: Icon(
                          Icons.search,
                          size: 25.0,
                        ),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  Colors.indigo[200],
                                  Colors.deepPurple[100],
                                ]),
                            borderRadius: BorderRadius.circular(40)),
                      ),
                      onTap: () {
                        initiateSearch();
                      },
                    )
                  ],
                ),
              ),
              searchList(),
            ],
          ),
        ),
      );
    }
  }



getChatRoomID(String a, String b) {
  if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
    return "$b\_$a";
  } else {
    return "$a\_$b";
  }
}
