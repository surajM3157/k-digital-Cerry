// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:get/get.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:piwotapp/constants/colors.dart';
//
// import '../shared prefs/pref_manager.dart';
//
// class NotificationService {
//   final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
//   bool _isForegroundHandlerSetup = false;
//
//
//   Future<void> subscribeToTopic(String topic) async {
//     await _firebaseMessaging.subscribeToTopic(topic);
//     print("Subscribed to $topic topic");
//   }
//
//   Future<void> unsubscribeFromTopic(String topic) async {
//     await _firebaseMessaging.unsubscribeFromTopic(topic);
//     print("Unsubscribed from $topic topic");
//   }
//
//   Future<void> initialize() async {
//     // Request permission for iOS devices
//     NotificationSettings settings = await _firebaseMessaging.requestPermission(
//       alert: true,
//       badge: true,
//       sound: true,
//     );
//
//     // Get the device token
//     String? token = await _firebaseMessaging.getToken();
//     print("FCM Token: $token");
//
//
//
//     // Handle messages when the app is in the background
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       print('Message clicked!');
//       _firestore.collection("notifications").doc(Prefs.checkUserId).collection('notification').doc(message.messageId).set(
//           {
//             // "data": message.data,
//             "title":message.notification?.title,
//             "body":message.notification?.body,
//           }, SetOptions(merge: true)
//       );
//
//     });
//   }
//
//   void  _showNotification( String? title, String? body) {
//     // You can show a dialog, a snackbar, or any other UI element to notify the user
//     Get.snackbar(
//       title??"",body??"",
//       backgroundColor: AppColor.white
//     );
//   }
//
//
//   void setupForegroundMessageHandler() {
//     if (_isForegroundHandlerSetup) return;
//     _isForegroundHandlerSetup = true;
//
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       print('Received a message while in the foreground!');
//       print('Message data: ${message.data}');
//
//       if (message.notification != null) {
//         print('Message also contained a notification: ${message.notification}');
//
//         final messageId = message.messageId;
//
//         // Avoid duplicate notification entries in Firestore by checking for existing messageId
//         _firestore.collection("notifications")
//             .doc(Prefs.checkUserId)
//             .collection('notification')
//             .doc(messageId)
//             .get()
//             .then((doc) {
//           if (!doc.exists) {
//             _firestore.collection("notifications")
//                 .doc(Prefs.checkUserId)
//                 .collection('notification')
//                 .doc(messageId)
//                 .set(
//               {
//                 "title": message.notification?.title,
//                 "body": message.notification?.body,
//               },
//               SetOptions(merge: true),
//             );
//
//             // Display an in-app notification if it’s the first time
//             _showNotification(message.notification!.title, message.notification!.body);
//           }
//         });
//       }
//     });
//   }
//
//
//   Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//     print('Handling a background message: ${message.messageId}');
//     _firestore.collection("notifications").doc(Prefs.checkUserId).collection('notification').doc(message.messageId).set(
//         {
//           // "data": message.data,
//           "title":message.notification?.title,
//           "body":message.notification?.body,
//         }, SetOptions(merge: true)
//     );
//
//   }
//
//   void setupBackgroundHandler() {
//     // Handle messages when the app is in the background
//     // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//     //   print('Message clicked!');
//     //   _firestore.collection("notifications").doc(Prefs.checkUserId).collection('notification').doc(message.messageId).set(
//     //       {
//     //         // "data": message.data,
//     //         "title":message.notification?.title,
//     //         "body":message.notification?.body,
//     //       }, SetOptions(merge: true)
//     //   );
//     //
//     // });
//
//     FirebaseMessaging.onBackgroundMessage((RemoteMessage message) async {
//       print('Handling a background message: ${message.messageId}');
//
//       _firestore.collection("notifications").doc(Prefs.checkUserId).collection('notification').doc(message.messageId).set(
//           {
//             // "data": message.data,
//             "title":message.notification?.title,
//             "body":message.notification?.body,
//           }, SetOptions(merge: true)
//       );
//
//     });
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:piwotapp/constants/colors.dart';
import '../shared prefs/pref_manager.dart';

class NotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  bool _isForegroundHandlerSetup = false;

  // Request permission for iOS devices
  Future<void> requestNotificationPermission() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    print("Notification Permission: ${settings.authorizationStatus}");
  }

  // Subscribe to a topic
  Future<void> subscribeToTopic(String topic) async {
    await _firebaseMessaging.subscribeToTopic(topic);
    print("Subscribed to $topic topic");
  }

  // Unsubscribe from a topic
  Future<void> unsubscribeFromTopic(String topic) async {
    await _firebaseMessaging.unsubscribeFromTopic(topic);
    print("Unsubscribed from $topic topic");
  }

  // Initialize Firebase Messaging and configure settings
  Future<void> initialize() async {
    // Request permission for iOS devices (Foreground)
    await requestNotificationPermission();

    // Get the device token
    String? token = await _firebaseMessaging.getToken();
    print("FCM Token: $token");

    if (token != null) {
      Prefs.setString('fmc_token', token);
      print("FCM Token saved to SharedPreferences.");
    }

    // Handle notifications when the app is in the background or terminated
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Message clicked!');
      _handleNotification(message);
    });

    // Handle notifications when the app is in the foreground
    setupForegroundMessageHandler();

    // Handle background messages
    setupBackgroundHandler();
  }

  // Handle notification when the app is in the foreground
  void setupForegroundMessageHandler() {
    if (_isForegroundHandlerSetup) return;
    _isForegroundHandlerSetup = true;

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Received a message while in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message contained a notification: ${message.notification}');

        final messageId = message.messageId;

        // Avoid duplicate notification entries in Firestore by checking for existing messageId
        _firestore
            .collection("notifications")
            .doc(Prefs.checkUserId)
            .collection('notification')
            .doc(messageId)
            .get()
            .then((doc) {
          if (!doc.exists) {
            _firestore
                .collection("notifications")
                .doc(Prefs.checkUserId)
                .collection('notification')
                .doc(messageId)
                .set({
              "title": message.notification?.title,
              "body": message.notification?.body,
            }, SetOptions(merge: true));

            // Show in-app notification using a Snackbar
            _showNotification(
                message.notification!.title, message.notification!.body);
          }
        });
      }
    });
  }

  // Show notification in-app (can be a Snackbar or AlertDialog)
  void _showNotification(String? title, String? body) {
    // Displaying a simple Snackbar
    Get.snackbar(
      title ?? "New Notification",
      body ?? "You have a new message!",
      backgroundColor: AppColor.white,
      snackPosition: SnackPosition.TOP,
    );
  }

  // Handle notification when the app is in the background or killed
  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    print('Handling a background message: ${message.messageId}');
    // Save notification data to Firestore
    _firestore
        .collection("notifications")
        .doc(Prefs.checkUserId)
        .collection('notification')
        .doc(message.messageId)
        .set({
      "title": message.notification?.title,
      "body": message.notification?.body,
    }, SetOptions(merge: true));
  }

  // Set up the background handler
  void setupBackgroundHandler() {
    // This is called when the app is terminated or in the background
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  // Handle notification when the app is opened from the notification
  Future<void> _handleNotification(RemoteMessage message) async {
    print("Handling notification opened from background!");

    // Save notification in Firestore for tracking
    _firestore
        .collection("notifications")
        .doc(Prefs.checkUserId)
        .collection('notification')
        .doc(message.messageId)
        .set({
      "title": message.notification?.title,
      "body": message.notification?.body,
    }, SetOptions(merge: true));

    // Optionally, navigate to a specific screen or take action based on notification data
    // For example, navigate to a specific screen based on notification data
    if (message.data.containsKey('route')) {
      String route = message.data['route'] ?? '/';
      navigatorKey.currentState?.pushNamed(route);
    }
  }
}
