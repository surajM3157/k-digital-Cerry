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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
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
                const SizedBox(width: 20,),
                Container(
                  width: Get.width/1.5,
                  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                  decoration: BoxDecoration(
                    color: AppColor.white,
                      borderRadius: BorderRadius.circular(15)
                  ),
                  child: Text("Your Event will start in 1 hour",style: TextStyle(
                    fontFamily: appFontFamily,fontWeight: FontWeight.w400,
                    fontSize: 14,color: AppColor.black
                  ),),
                )
              ],
            ),
          ),
          const SizedBox(height: 10,),
          Container(height: 1,width: Get.width,color: AppColor.black.withOpacity(0.12),),
          const SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
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
                const SizedBox(width: 20,),
                Container(
                  width: Get.width/1.5,
                  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                  decoration: BoxDecoration(
                    color: AppColor.white,
                      borderRadius: BorderRadius.circular(15)
                  ),
                  child: Text("Your Password has been changed successfully",style: TextStyle(
                      fontFamily: appFontFamily,fontWeight: FontWeight.w400,
                      fontSize: 14,color: AppColor.black
                  )),
                )
              ],
            ),
          ),
          const SizedBox(height: 10,),
          Container(height: 1,width: Get.width,color: AppColor.black.withOpacity(0.12),),
          const SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
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
                const SizedBox(width: 20,),
                Container(
                  width: Get.width/1.5,
                  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                  decoration: BoxDecoration(
                    color: AppColor.white,
                      borderRadius: BorderRadius.circular(15)
                  ),
                  child: Text("You have one friend request",style: TextStyle(
                      fontFamily: appFontFamily,fontWeight: FontWeight.w400,
                      fontSize: 14,color: AppColor.black
                  )),
                )
              ],
            ),
          ),
          const SizedBox(height: 10,),
          Container(height: 1,width: Get.width,color: AppColor.black.withOpacity(0.12),),
          const SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
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
                const SizedBox(width: 20,),
                Container(
                  width: Get.width/1.5,
                  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                  decoration: BoxDecoration(
                    color: AppColor.white,
                      borderRadius: BorderRadius.circular(15)
                  ),
                  child: Text("You have one friend request",style: TextStyle(
                      fontFamily: appFontFamily,fontWeight: FontWeight.w400,
                      fontSize: 14,color: AppColor.black
                  )),
                )
              ],
            ),
          ),
          const SizedBox(height: 10,),
          Container(height: 1,width: Get.width,color: AppColor.black.withOpacity(0.12),),
          const SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
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
                const SizedBox(width: 20,),
                Container(
                  width: Get.width/1.5,
                  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                  decoration: BoxDecoration(
                      color: AppColor.white,
                      borderRadius: BorderRadius.circular(15)
                  ),
                  child: Text("Your Password has been changed successfully",style: TextStyle(
                      fontFamily: appFontFamily,fontWeight: FontWeight.w400,
                      fontSize: 14,color: AppColor.black
                  )),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10,),
          Container(height: 1,width: Get.width,color: AppColor.black.withOpacity(0.12),),
          const SizedBox(height: 10,),
        ],
      ),
    );
  }
}