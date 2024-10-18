import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../responses/message.dart';
import '../shared prefs/pref_manager.dart';

class ChatService{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> sendMessage(String receiverId, String message,String receiverName){
    // get current user info

    final currentUserId = Prefs.checkMobileNo;
    final currentUserName = Prefs.checkUsername;
    final timestamp = Timestamp.now();
    // create new message

    Message newMessage = Message(senderId: currentUserId, senderName: currentUserName, receiverId: receiverId, message: message, timestamp: timestamp, receiverName: receiverName);

    // construct chat room id from current user id & receicer id

    List<String> ids = [currentUserId,receiverId];
    ids.sort(); // sort the ids (this ensure that chat room ids is always same for two people
    String chatRoomId = ids.join("_"); // combine ids with _ to use as a chatroomid

    // add new message to database
    return _firestore.collection("chat_rooms").doc(chatRoomId).collection("messages").add(newMessage.toMap());


  }

  //Get Message

  Stream<QuerySnapshot> getMessages(String userId, String otherUserId){
    // construct chatroom id from user ids (sorted to ensure it matches the id used when sending message)
    List<String> ids = [userId,otherUserId];
    ids.sort();
    String chatRoomId = ids.join('_');

    return _firestore.collection("chat_rooms").doc(chatRoomId).collection('messages').orderBy("timestamp",descending: false).snapshots();
  }
}