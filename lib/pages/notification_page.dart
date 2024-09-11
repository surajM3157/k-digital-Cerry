import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../constants/colors.dart';
import '../constants/font_family.dart';
import '../constants/images.dart';
import '../widgets/app_themes.dart';
import '../widgets/gradient_text.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
        child: ListView(
          children: [
            Center(
              child: GradientText(text:"Notification",style: TextStyle(fontWeight: FontWeight.w600,fontFamily: appFontFamily,fontSize: 20), gradient: LinearGradient(
                colors: [AppColor.primaryColor, AppColor.red],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              ),
            ),
            SizedBox(height: 20,),
            Row(
              children: [
                Container(
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
                ),
                SizedBox(width: 20,),
                Container(
                  width: Get.width/1.5,
                  padding: EdgeInsets.all(1),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AppColor.primaryColor, AppColor.red],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(16)
                  ),
                  child: Container(
                    width: Get.width/1.5,
                    padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                    decoration: BoxDecoration(
                      color: AppColor.white,
                        borderRadius: BorderRadius.circular(15)
                    ),
                    child: Text("Your Event will start in 1 hour",style: TextStyle(
                      fontFamily: appFontFamilyHeadings,fontWeight: FontWeight.w400,
                      fontSize: 14,color: AppColor.black
                    ),),
                  ),
                )
              ],
            ),
            SizedBox(height: 20,),
            Row(
              children: [
                Container(
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
                    child: SvgPicture.asset(Images.successNotificationIcon),
                  ),
                ),
                SizedBox(width: 20,),
                Container(
                  width: Get.width/1.5,
                  padding: EdgeInsets.all(1),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AppColor.primaryColor, AppColor.red],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(16)
                  ),
                  child: Container(
                    width: Get.width/1.5,
                    padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                    decoration: BoxDecoration(
                      color: AppColor.white,
                        borderRadius: BorderRadius.circular(15)
                    ),
                    child: Text("Your Password has been changed sucessfully",style: TextStyle(
                        fontFamily: appFontFamilyHeadings,fontWeight: FontWeight.w400,
                        fontSize: 14,color: AppColor.black
                    )),
                  ),
                )
              ],
            ),
            SizedBox(height: 20,),
            Row(
              children: [
                Container(
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
                    child: SvgPicture.asset(Images.requestNotificationIcon),
                  ),
                ),
                SizedBox(width: 20,),
                Container(
                  width: Get.width/1.5,
                  padding: EdgeInsets.all(1),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AppColor.primaryColor, AppColor.red],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(16)
                  ),
                  child: Container(
                    width: Get.width/1.5,
                    padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                    decoration: BoxDecoration(
                      color: AppColor.white,
                        borderRadius: BorderRadius.circular(15)
                    ),
                    child: Text("You have one friend request",style: TextStyle(
                        fontFamily: appFontFamilyHeadings,fontWeight: FontWeight.w400,
                        fontSize: 14,color: AppColor.black
                    )),
                  ),
                )
              ],
            ),
            SizedBox(height: 20,),
            Row(
              children: [
                Container(
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
                    child: SvgPicture.asset(Images.requestNotificationIcon),
                  ),
                ),
                SizedBox(width: 20,),
                Container(
                  width: Get.width/1.5,
                  padding: EdgeInsets.all(1),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AppColor.primaryColor, AppColor.red],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(16)
                  ),
                  child: Container(
                    width: Get.width/1.5,
                    padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                    decoration: BoxDecoration(
                      color: AppColor.white,
                        borderRadius: BorderRadius.circular(15)
                    ),
                    child: Text("You have one friend request",style: TextStyle(
                        fontFamily: appFontFamilyHeadings,fontWeight: FontWeight.w400,
                        fontSize: 14,color: AppColor.black
                    )),
                  ),
                )
              ],
            ),
            SizedBox(height: 20,),
            Row(
              children: [
                Container(
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
                    child: SvgPicture.asset(Images.successNotificationIcon),
                  ),
                ),
                SizedBox(width: 20,),
                Container(
                  width: Get.width/1.5,
                  padding: EdgeInsets.all(1),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AppColor.primaryColor, AppColor.red],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(16)
                  ),
                  child: Container(
                    width: Get.width/1.5,
                    padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                    decoration: BoxDecoration(
                        color: AppColor.white,
                        borderRadius: BorderRadius.circular(15)
                    ),
                    child: Text("Your Password has been changed sucessfully",style: TextStyle(
                        fontFamily: appFontFamilyHeadings,fontWeight: FontWeight.w400,
                        fontSize: 14,color: AppColor.black
                    )),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}