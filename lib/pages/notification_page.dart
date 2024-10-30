import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../constants/colors.dart';
import '../constants/font_family.dart';
import '../constants/images.dart';
import '../widgets/gradient_text.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColor.primaryColor,
        title: Padding(
          padding: const EdgeInsets.only(right: 60),
          child: Center(child: SvgPicture.asset(Images.logo, height: 40,width: 147)),
        ),
        leading: InkWell(
            onTap: (){
              Get.back();
            },
            child: Icon(Icons.arrow_back_ios,size: 20,color: AppColor.white,)),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: GradientText(text:"Notification",style: const TextStyle(fontWeight: FontWeight.w600,fontFamily: appFontFamily,fontSize: 20), gradient: LinearGradient(
              colors: [AppColor.primaryColor, AppColor.red],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            ),
          ),
          const SizedBox(height: 20,),
          StreamBuilder<QuerySnapshot>(
            stream: _firestore.collection("notifications").snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }
              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return Center(child: Text('No notifications found.'));
              }

              final notifications = snapshot.data!.docs.reversed.toList();

              return ListView.separated(
                shrinkWrap: true,physics: NeverScrollableScrollPhysics(),
                itemCount: notifications.length,
                itemBuilder: (context, index) {
                  final notification = notifications[index].data() as Map<String, dynamic>;
                  return notification['title'] != null?ListTile(
                    title: Text(notification['title'] ?? 'No Title'),
                    subtitle: Text(notification['body'] ?? 'No Body'),
                    leading: notification['title'].toLowerCase().contains('event')? Container(
                      height: 58,
                      width: 58,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [AppColor.primaryColor, AppColor.red],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.circular(50)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: SvgPicture.asset(Images.eventNotificationIcon),
                      ),
                    ): Container(
                      height: 58,
                      width: 58,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [AppColor.primaryColor, AppColor.red],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.circular(50)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: SvgPicture.asset(Images.notificationIcon,color: AppColor.white,),
                      ),
                    ),
                  ):SizedBox.shrink();
                }, separatorBuilder: (BuildContext context, int index) {
                  return   Container(
                    height: 1,width: Get.width,color: AppColor.black.withOpacity(0.12),);
              },
              );
            },
          ),

        ],
      ),
    );
  }
}