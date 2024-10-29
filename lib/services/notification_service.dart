import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:piwotapp/constants/colors.dart';

class NotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  Future<void> initialize() async {
    // Request permission for iOS devices
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    // Get the device token
    String? token = await _firebaseMessaging.getToken();
    print("FCM Token: $token");




    // Handle messages when the app is in the background
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Message clicked!');
      _firestore.collection("notifications").doc(message.messageId).set(
          {
            // "data": message.data,
            "title":message.notification?.title,
            "body":message.notification?.body,
          }, SetOptions(merge: true)
      );
    });
  }

  void  _showNotification(BuildContext context, String? title, String? body) {
    // You can show a dialog, a snackbar, or any other UI element to notify the user
    Get.snackbar(
      title??"",body??"",
      backgroundColor: AppColor.white
    );
  }

  void setupForegroundMessageHandler(BuildContext context) {
    // Listen to foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Received a message while in the foreground!');
      print('Message data: ${message.data}');

      // Check if the message contains a notification payload
      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
        _firestore.collection("notifications").doc(message.messageId).set(
            {
              // "data": message.data,
              "title":message.notification?.title,
              "body":message.notification?.body,
            }, SetOptions(merge: true)
        );
        // Display an in-app notification using a custom method
        _showNotification(context, message.notification!.title, message.notification!.body);
      }
    });
  }

  Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    print('Handling a background message: ${message.messageId}');
    _firestore.collection("notifications").doc(message.messageId).set(
        {
          // "data": message.data,
          "title":message.notification?.title,
          "body":message.notification?.body,
        }, SetOptions(merge: true)
    );
  }

  void setupBackgroundHandler() {
    FirebaseMessaging.onBackgroundMessage((RemoteMessage message) async {
      print('Handling a background message: ${message.messageId}');

      _firestore.collection("notifications").doc(message.messageId).set(
          {
            // "data": message.data,
            "title":message.notification?.title,
            "body":message.notification?.body,
          }, SetOptions(merge: true)
      );
    });
  }
}
