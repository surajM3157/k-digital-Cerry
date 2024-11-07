import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:piwotapp/constants/colors.dart';

import '../shared prefs/pref_manager.dart';

class NotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  bool _isForegroundHandlerSetup = false;


  Future<void> subscribeToTopic(String topic) async {
    await _firebaseMessaging.subscribeToTopic(topic);
    print("Subscribed to $topic topic");
  }

  Future<void> unsubscribeFromTopic(String topic) async {
    await _firebaseMessaging.unsubscribeFromTopic(topic);
    print("Unsubscribed from $topic topic");
  }

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
      _firestore.collection("notifications").doc(Prefs.checkUserId).collection('notification').doc(message.messageId).set(
          {
            // "data": message.data,
            "title":message.notification?.title,
            "body":message.notification?.body,
          }, SetOptions(merge: true)
      );

    });
  }

  void  _showNotification( String? title, String? body) {
    // You can show a dialog, a snackbar, or any other UI element to notify the user
    Get.snackbar(
      title??"",body??"",
      backgroundColor: AppColor.white
    );
  }


  void setupForegroundMessageHandler() {
    if (_isForegroundHandlerSetup) return;
    _isForegroundHandlerSetup = true;

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Received a message while in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');

        final messageId = message.messageId;

        // Avoid duplicate notification entries in Firestore by checking for existing messageId
        _firestore.collection("notifications")
            .doc(Prefs.checkUserId)
            .collection('notification')
            .doc(messageId)
            .get()
            .then((doc) {
          if (!doc.exists) {
            _firestore.collection("notifications")
                .doc(Prefs.checkUserId)
                .collection('notification')
                .doc(messageId)
                .set(
              {
                "title": message.notification?.title,
                "body": message.notification?.body,
              },
              SetOptions(merge: true),
            );

            // Display an in-app notification if it’s the first time
            _showNotification(message.notification!.title, message.notification!.body);
          }
        });
      }
    });
  }


  Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    print('Handling a background message: ${message.messageId}');
    _firestore.collection("notifications").doc(Prefs.checkUserId).collection('notification').doc(message.messageId).set(
        {
          // "data": message.data,
          "title":message.notification?.title,
          "body":message.notification?.body,
        }, SetOptions(merge: true)
    );

  }

  void setupBackgroundHandler() {
    // Handle messages when the app is in the background
    // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    //   print('Message clicked!');
    //   _firestore.collection("notifications").doc(Prefs.checkUserId).collection('notification').doc(message.messageId).set(
    //       {
    //         // "data": message.data,
    //         "title":message.notification?.title,
    //         "body":message.notification?.body,
    //       }, SetOptions(merge: true)
    //   );
    //
    // });

    FirebaseMessaging.onBackgroundMessage((RemoteMessage message) async {
      print('Handling a background message: ${message.messageId}');

      _firestore.collection("notifications").doc(Prefs.checkUserId).collection('notification').doc(message.messageId).set(
          {
            // "data": message.data,
            "title":message.notification?.title,
            "body":message.notification?.body,
          }, SetOptions(merge: true)
      );

    });
  }
}
