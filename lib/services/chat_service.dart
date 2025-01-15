// import 'dart:typed_data';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import '../responses/message.dart';
// import '../shared prefs/pref_manager.dart';
// import 'package:encrypt/encrypt.dart' as encrypt;
// import 'package:crypto/crypto.dart';
// import 'dart:convert';
//
// class ChatService {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//   // Generate a fixed-length key for AES from any length input key
//   encrypt.Key generateKey(String inputKey, int length) {
//     final keyHash = sha256.convert(utf8.encode(inputKey)).bytes;
//     return encrypt.Key(Uint8List.fromList(keyHash.sublist(0, length)));
//   }
//
//   // Encrypt the message text and store both IV and message
//   String encryptMessage(String text, String inputKey) {
//     final key = generateKey(inputKey, 32); // AES-256 key length
//     final iv = encrypt.IV.fromSecureRandom(16); // Random IV for each encryption
//     final encrypter = encrypt.Encrypter(encrypt.AES(key));
//     final encrypted = encrypter.encrypt(text, iv: iv);
//     // Combine IV and encrypted text into a single string
//     return iv.base64 + ":" + encrypted.base64; // Store this in Firestore
//   }
//
//   // Decrypt the message text using the stored IV
//   String decryptMessage(String encryptedText, String inputKey) {
//     final key = generateKey(inputKey, 32); // AES-256 key length
//     // Split IV and encrypted text
//     final parts = encryptedText.split(":");
//     if (parts.length != 2) throw Exception("Invalid encrypted format");
//
//     final iv = encrypt.IV.fromBase64(parts[0]); // Extract IV
//     final encryptedData = parts[1]; // Extract encrypted message
//
//     final encrypter = encrypt.Encrypter(encrypt.AES(key));
//     return encrypter.decrypt64(encryptedData, iv: iv); // Decrypt with IV
//   }
//
//   Future<void> sendMessage(
//       String receiverId, String message, String receiverName) {
//     // get current user info
//
//     final currentUserId = Prefs.checkUserId;
//     final currentUserName = Prefs.checkUsername;
//     final timestamp = Timestamp.now();
//     // create new message
//
//     Message newMessage = Message(
//         senderId: currentUserId,
//         senderName: currentUserName,
//         receiverId: receiverId,
//         message: encryptMessage(message, 'my_secure_passphrase'),
//         timestamp: timestamp,
//         receiverName: receiverName,
//         isRead: false);
//
//     // construct chat room id from current user id & receicer id
//
//     List<String> ids = [currentUserId, receiverId];
//     ids.sort(); // sort the ids (this ensure that chat room ids is always same for two people
//     String chatRoomId =
//         ids.join("_"); // combine ids with _ to use as a chatroomid
//
//     // add new message to database
//     return _firestore
//         .collection("chat_rooms")
//         .doc(chatRoomId)
//         .collection("messages")
//         .add(newMessage.toMap());
//   }
//
//   //Get Message
//
//   Stream<QuerySnapshot> getMessages(String userId, String otherUserId) {
//     // construct chatroom id from user ids (sorted to ensure it matches the id used when sending message)
//     List<String> ids = [userId, otherUserId];
//     ids.sort();
//     String chatRoomId = ids.join('_');
//
//     return _firestore
//         .collection("chat_rooms")
//         .doc(chatRoomId)
//         .collection('messages')
//         .orderBy("timestamp", descending: false)
//         .snapshots();
//   }
// }
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import '../responses/message.dart';
import '../shared prefs/pref_manager.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:crypto/crypto.dart';
import 'dart:convert';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Generate a fixed-length key for AES from any length input key
  encrypt.Key generateKey(String inputKey, int length) {
    final keyHash = sha256.convert(utf8.encode(inputKey)).bytes;
    return encrypt.Key(Uint8List.fromList(keyHash.sublist(0, length)));
  }

  // Encrypt the message text and store both IV and message
  String encryptMessage(String text, String inputKey) {
    final key = generateKey(inputKey, 32); // AES-256 key length
    final iv = encrypt.IV.fromSecureRandom(16); // Random IV for each encryption
    final encrypter = encrypt.Encrypter(encrypt.AES(key));
    final encrypted = encrypter.encrypt(text, iv: iv);
    // Combine IV and encrypted text into a single string
    return "${iv.base64}:${encrypted.base64}"; // Store this in Firestore
  }

  // Decrypt the message text using the stored IV
  String decryptMessage(String encryptedText, String inputKey) {
    final key = generateKey(inputKey, 32); // AES-256 key length
    // Split IV and encrypted text
    final parts = encryptedText.split(":");
    if (parts.length != 2) throw Exception("Invalid encrypted format");

    final iv = encrypt.IV.fromBase64(parts[0]); // Extract IV
    final encryptedData = parts[1]; // Extract encrypted message

    final encrypter = encrypt.Encrypter(encrypt.AES(key));
    return encrypter.decrypt64(encryptedData, iv: iv); // Decrypt with IV
  }

  Future<void> sendMessage(
      String receiverId, String message, String receiverName) {
    // get current user info

    final currentUserId = Prefs.checkUserId;
    final currentUserName = Prefs.checkUsername;
    final timestamp = Timestamp.now();
    // create new message

    Message newMessage = Message(
        senderId: currentUserId,
        senderName: currentUserName,
        receiverId: receiverId,
        message: encryptMessage(message, 'my_secure_passphrase'),
        timestamp: timestamp,
        receiverName: receiverName,
        isRead: false);

    // construct chat room id from current user id & receicer id

    List<String> ids = [currentUserId, receiverId];
    ids.sort(); // sort the ids (this ensure that chat room ids is always same for two people
    String chatRoomId =
        ids.join("_"); // combine ids with _ to use as a chatroomid

    // add new message to database
    return _firestore
        .collection("chat_rooms")
        .doc(chatRoomId)
        .collection("messages")
        .add(newMessage.toMap());
  }

  //Get Message

  Stream<QuerySnapshot> getMessages(String userId, String otherUserId) {
    // construct chatroom id from user ids (sorted to ensure it matches the id used when sending message)
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join('_');

    return _firestore
        .collection("chat_rooms")
        .doc(chatRoomId)
        .collection('messages')
        .orderBy("timestamp", descending: false)
        .snapshots(); 
  }
}
