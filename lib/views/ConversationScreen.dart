import 'package:flutter/material.dart';
import 'package:project/helper/constants.dart';
import 'package:project/services/database.dart';

class ConversationScreen extends StatefulWidget {

  final String chatRoomID;
  ConversationScreen(this.chatRoomID);

  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {

  DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController messageController = new TextEditingController();

  Stream ChatMessagesStream;

  Widget ChatMessageList() {
    return StreamBuilder(
      stream: ChatMessagesStream,
        builder: (context,snapshot) {
        return snapshot.hasData ? ListView.builder(
          itemCount: snapshot.data.docs.length,
            itemBuilder: (context, index) {
            return MessageTile(snapshot.data.docs[index].data()["message"],
                snapshot.data.docs[index].data()["sendBy"] == Constants.myName);
        }): Container();
    },
    );
  }

  sendMessage() {
    if(messageController.text.isNotEmpty) {
      Map<String, dynamic > messageMap = {
        "message" : messageController.text,
        "sendBy" : Constants.myName,
        "time" : DateTime.now().millisecondsSinceEpoch
      };
      databaseMethods.addConversationMessages(widget.chatRoomID,messageMap);
      messageController.text = " ";
    }
  }

  @override
  void initState() {
    databaseMethods.getConversationMessages(widget.chatRoomID).then((value){
      setState(() {
        ChatMessagesStream = value;
      });
    });
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
      body: Stack(
        children: [
          ChatMessageList(),
          Container(
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    //alignment: Alignment.bottomCenter,
                    color: Colors.indigo[100].withOpacity(0.80),
                    padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                    child: Row(
                      children: [
                        Expanded(
                            child: TextField(
                              controller: messageController,
                              decoration: InputDecoration(
                                  hintText: "Type your message..",
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
                              Icons.send,
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
                            sendMessage();
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MessageTile extends StatelessWidget {
  final String message;
  final bool isSendByMe;

  MessageTile(this.message,this.isSendByMe);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: isSendByMe ? 0: 24,right : isSendByMe ? 24:0),
      margin: EdgeInsets.symmetric(vertical: 8),
      width: MediaQuery.of(context).size.width,
      alignment: isSendByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24,vertical: 16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isSendByMe ?
            [ Colors.deepPurple[300], Colors.indigo[200]]
            :[ Colors.indigo[100], Colors.deepPurple[100]]
          ),
          borderRadius: isSendByMe ? BorderRadius.only(
            topLeft: Radius.circular(23),
            topRight: Radius.circular(23),
            bottomLeft: Radius.circular(23)
          ) :
          BorderRadius.only(
          topLeft: Radius.circular(23),
          topRight: Radius.circular(23),
          bottomRight: Radius.circular(23)
          )
      ),
        child: Text(message,
        style: TextStyle(
          fontSize: 17.0
        ),),
      ),
    );
  }
}

