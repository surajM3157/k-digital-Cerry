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
import '../pages/home/delegates.dart';
import '../route/route_names.dart';
import '../shared prefs/pref_manager.dart';

class NotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  bool _isForegroundHandlerSetup = false;

  late final int tabIndex;

  Future<void> requestNotificationPermission() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    print("Notification Permission: ${settings.authorizationStatus}");
  }

  Future<void> subscribeToTopic(String topic) async {
    await _firebaseMessaging.subscribeToTopic(topic);
    print("Subscribed to $topic topic");
  }

  Future<void> unsubscribeFromTopic(String topic) async {
    await _firebaseMessaging.unsubscribeFromTopic(topic);
    print("Unsubscribed from $topic topic");
  }

  Future<void> initialize() async {
    await requestNotificationPermission();
    String? token = await _firebaseMessaging.getToken();
    print("FCM Token: $token");

    if (token != null) {
      Prefs.setString('fmc_token', token);
      print("FCM Token saved to SharedPreferences.");
    }

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Message clicked!');
      print("Background Message: ${message.data}");
      _handleNotification(message);
    });

    setupForegroundMessageHandler();
    setupBackgroundHandler();
  }

  void setupForegroundMessageHandler() {
    if (_isForegroundHandlerSetup) return;
    _isForegroundHandlerSetup = true;

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Received a message while in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message contained a notification: ${message.notification}');

        final messageId = message.messageId;

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

  void _showNotification(String? title, String? body) {
    Get.snackbar(
      title ?? "New Notification",
      body ?? "You have a new message!",
      backgroundColor: AppColor.white,
      snackPosition: SnackPosition.TOP,
    );
  }

  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    print('Handling a background message: ${message.messageId}');
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

  void setupBackgroundHandler() {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  Future<void> _handleNotification(RemoteMessage message) async {
    print("Handling notification opened from background!");
    await _firestore
        .collection("notifications")
        .doc(Prefs.checkUserId)
        .collection('notification')
        .doc(message.messageId)
        .set({
      "title": message.notification?.title,
      "body": message.notification?.body,
      "timestamp": FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
    print("Notification Data: ${message.data}");
    if (message.data.containsKey('type')) {
      String type = message.data['type'] ?? '';

      print("Notification Type: $type");
      if (type == 'friend_request') {
        navigatorKey.currentState?.push(MaterialPageRoute(
          builder: (_) {
            // TabController tabController =
            //     TabController(length: 3, initialIndex: 2, vsync: this);
            return Delegates(
              tabIndex: 2,
              tabController: null,
            );
          },
        ));

        // Get.toNamed(
        //   Routes.notification,
        // );
      }
    }
  }

  // Future<void> _handleNotification(RemoteMessage message) async {
  //   print("Handling notification opened from background!");
  //
  //   // Save notification in Firestore for tracking
  //   await _firestore
  //       .collection("notifications")
  //       .doc(Prefs.checkUserId)
  //       .collection('notification')
  //       .doc(message.messageId)
  //       .set({
  //     "title": message.notification?.title,
  //     "body": message.notification?.body,
  //     "timestamp": FieldValue.serverTimestamp(), // Add timestamp for tracking
  //   }, SetOptions(merge: true));
  //
  //   // Navigate to a specific screen or take action based on notification data
  //   if (message.data.containsKey('type')) {
  //     String type = message.data['type'] ?? '';
  //     print("Notification Type: $type");
  //     // Determine route based on the 'type' field in the notification data
  //     switch (type) {
  //       case 'Survey':
  //         Get.toNamed(
  //           Routes.survey,
  //           // arguments: {
  //           //   "session_id": message.data['session_id'] ?? '',
  //           //   "type": type,
  //           // },
  //         );
  //         break;
  //
  //       case 'friend_request':
  //         Get.toNamed(
  //           Routes.chat,
  //           // arguments: {
  //           //   "chat_id": message.data['chat_id'] ?? '',
  //           // },
  //         );
  //         break;
  //
  //       default:
  //         print("Unknown notification type: $type");
  //         Get.snackbar(
  //           "Notification",
  //           "No specific action for this notification type.",
  //           snackPosition: SnackPosition.BOTTOM,
  //         );
  //     }
  //   } else {
  //     print("Notification does not contain a 'type' field.");
  //   }
  // }

  // Future<void> _handleNotification(RemoteMessage message) async {
  //   print("Handling notification opened from background!");
  //
  //   // Save notification in Firestore for tracking
  //   _firestore
  //       .collection("notifications")
  //       .doc(Prefs.checkUserId)
  //       .collection('notification')
  //       .doc(message.messageId)
  //       .set({
  //     "title": message.notification?.title,
  //     "body": message.notification?.body,
  //   }, SetOptions(merge: true));
  //
  //   // Get.toNamed(Routes.survey,
  //   //     arguments: {"session_id": "", "type": "Global Survey"});
  //
  //   // Optionally, navigate to a specific screen or take action based on notification data
  //   // For example, navigate to a specific screen based on notification data
  //   if (message.data.containsKey('type')) {
  //     String route = message.data['type'] ?? '/chat';
  //     navigatorKey.currentState?.pushNamed(route);
  //   }
  // }
}
