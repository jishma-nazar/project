import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  getUserByUsername(String username) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .where("name", isEqualTo: username)
        .get();
  }

  getUserByUserEmail(String userEmail) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .where("email", isEqualTo: userEmail)
        .get();
  }

  uploadUserInfo(userMap) {
    FirebaseFirestore.instance.collection("users").add(userMap).catchError((e) {
      print(e.toString());
    });
  }

  createChatRoom(String chatRoomID, chatRoomMap) {
    FirebaseFirestore.instance
        .collection("ChatRoom")
        .doc(chatRoomID)
        .set(chatRoomMap)
        .catchError((e) {
      print(e.toString());
    });
  }

  addConversationMessages(String chatRoomID, messageMap) {
    FirebaseFirestore.instance.collection("ChatRoom")
        .doc(chatRoomID)
        .collection("chats")
        .add(messageMap).catchError((e){print(e.toString());});
  }

  getConversationMessages(String chatRoomID) async {
    return await FirebaseFirestore.instance.collection("ChatRoom")
        .doc(chatRoomID)
        .collection("chats")
        .orderBy("time",descending: false)
        .snapshots();
  }

  getChatRooms(String userName) async {
    return await FirebaseFirestore.instance.collection("ChatRoom")
        .where("users",arrayContains: userName)
        .snapshots();
  }



}
