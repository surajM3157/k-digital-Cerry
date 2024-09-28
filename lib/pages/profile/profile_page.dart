import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:piwotapp/constants/colors.dart';
import 'package:piwotapp/constants/font_family.dart';
import 'package:piwotapp/route/route_names.dart';
import 'package:piwotapp/widgets/app_themes.dart';
import 'package:get/get.dart';
import '../../constants/images.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  bool isNotificationOn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
              Container(
                height: 250,width: Get.width,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColor.primaryColor, AppColor.red],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  borderRadius: const BorderRadius.only(bottomRight: Radius.circular(170),bottomLeft: Radius.circular(170))
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 50,),
                    Center(child: SvgPicture.asset(Images.logo, height: 40,width: 147)),

                  ],
                ),
              ),

                const SizedBox(height: 80,),
                Text("Victor Alvarez",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16,color: AppColor.primaryColor,fontFamily: appFontFamily),),
                const SizedBox(height: 4,),
                Text("victoralvatez@gmail.com",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 16,color: AppColor.black,fontFamily: appFontFamily),),
                const SizedBox(height: 16,),
                GestureDetector(
                  onTap: (){
                    Get.toNamed(Routes.editProfile);
                  },
                  child: Container(
                    height: 32,width: 107,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppColor.primaryColor
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(Images.editIcon,color: AppColor.white,height: 12,width: 12,),
                          const SizedBox(width: 5,),
                          Text("Edit Profile",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 12,color: AppColor.white,fontFamily: appFontFamily),),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16,),
                GestureDetector(
                  onTap: (){
                    Get.toNamed(Routes.ticket);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 18),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(Images.ticketIcon),
                            const SizedBox(width: 20,),
                            Text("QR Code Badge",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: AppColor.primaryColor,fontFamily: appFontFamily),)
                          ],
                        ),
                        Icon(Icons.arrow_forward_ios,size: 16,color: AppColor.primaryColor,)
                      ],
                    ),
                  ),
                ),
                Container(height: 1,width: Get.width,color: AppColor.black.withOpacity(0.12),),
                GestureDetector(
                  onTap: (){
                    Get.toNamed(Routes.contactUs);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 18),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(Images.contactIcon),
                            const SizedBox(width: 20,),
                            Text("Contact Us",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: AppColor.primaryColor,fontFamily: appFontFamily),)
                          ],
                        ),
                        Icon(Icons.arrow_forward_ios,size: 16,color: AppColor.primaryColor,)
                      ],
                    ),
                  ),
                ),
                Container(height: 1,width: Get.width,color: AppColor.black.withOpacity(0.12),),
                GestureDetector(
                  onTap: (){
                    Get.toNamed(Routes.feedback);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 18),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(Images.feedbackIcon),
                            const SizedBox(width: 20,),
                            Text("Feedback",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: AppColor.primaryColor,fontFamily: appFontFamily),)
                          ],
                        ),
                        Icon(Icons.arrow_forward_ios,size: 16,color: AppColor.primaryColor,)
                      ],
                    ),
                  ),
                ),
                Container(height: 1,width: Get.width,color: AppColor.black.withOpacity(0.12),),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(Images.profileNotificationIcon),
                          const SizedBox(width: 20,),
                          Text("Notification",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: AppColor.primaryColor,fontFamily: appFontFamily),)
                        ],
                      ),
                      Transform.scale(
                        scale: 0.7,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: isNotificationOn
                                ? AppColor.primaryColor
                                : AppColor.primaryColor,
                          ),
                          child: CupertinoSwitch(
                            value: isNotificationOn,
                            activeColor: AppColor.white,
                            trackColor: AppColor.white,
                            thumbColor: AppColor.primaryColor,
                            onChanged: (v) => setState(() {
                              isNotificationOn = v;
                            }),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(height: 1,width: Get.width,color: AppColor.black.withOpacity(0.12),),
                GestureDetector(
                  onTap: (){
                    Get.toNamed(Routes.feedback);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 18),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(Images.privacyPolicyIcon),
                            const SizedBox(width: 20,),
                            Text("Privacy Policy",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: AppColor.primaryColor,fontFamily: appFontFamily),)
                          ],
                        ),
                        Icon(Icons.arrow_forward_ios,size: 16,color: AppColor.primaryColor,)
                      ],
                    ),
                  ),
                ),
                Container(height: 1,width: Get.width,color: AppColor.black.withOpacity(0.12),),
                GestureDetector(
                  onTap: (){
                    Get.toNamed(Routes.feedback);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 18),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(Images.termsConditionIcon),
                            const SizedBox(width: 20,),
                            Text("Terms and Conditions",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: AppColor.primaryColor,fontFamily: appFontFamily),)
                          ],
                        ),
                        Icon(Icons.arrow_forward_ios,size: 16,color: AppColor.primaryColor,)
                      ],
                    ),
                  ),
                ),
                Container(height: 1,width: Get.width,color: AppColor.black.withOpacity(0.12),),
                GestureDetector(
                  onTap: (){
                    Get.toNamed(Routes.feedback);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 18),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(Images.faqIcon),
                            const SizedBox(width: 20,),
                            Text("Frequently Asked Questions",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: AppColor.primaryColor,fontFamily: appFontFamily),)
                          ],
                        ),
                        Icon(Icons.arrow_forward_ios,size: 16,color: AppColor.primaryColor,)
                      ],
                    ),
                  ),
                ),
                Container(height: 1,width: Get.width,color: AppColor.black.withOpacity(0.12),),
                GestureDetector(
                  onTap: (){
                    logoutAlert();
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 18),
                    child: Row(
                      children: [
                        SvgPicture.asset(Images.logoutIcon,color: AppColor.red,),
                        const SizedBox(width: 20,),
                        Text("Logout",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: AppColor.red,fontFamily: appFontFamily),)
                      ],
                    ),
                  ),
                ),
                Container(height: 1,width: Get.width,color: AppColor.black.withOpacity(0.12),),
                const SizedBox(height: 20,),
              ],
            ),
            Container(
              width: 200,height: 200,
              margin: const EdgeInsets.only(left: 90,top: 110),
              padding: EdgeInsets.all(50),
              decoration: BoxDecoration(
                  color: AppColor.white,
                  border: Border.all(color: AppColor.grey),
                  borderRadius: const BorderRadius.all(Radius.circular(100))
              ),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(200),
                  child: Image.asset(Images.profileDefault,height: 64,width: 64,fit: BoxFit.fill,)),
            ),
            GestureDetector(
              onTap: (){
                Get.back();
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 20,top: 60),
                child: Icon(Icons.arrow_back_ios,color: AppColor.white,),
              ),
            )
          ],
        ),
      ),
    );
  }

   logoutAlert(){

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.all(Radius.circular(32.0)),
        side: BorderSide(
          color: AppColor.lightGrey, // Border color
          width: 2.0,               // Border width
        ),
      ),
      title: Center(child: Text("Logout",style: AppThemes.titleTextStyle(),)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Are you sure you want to log out?",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,fontFamily: appFontFamily,color: AppColor.mediumGrey),),
          const SizedBox(height: 20,),
          InkWell(
            onTap: (){
              Get.offAllNamed(Routes.login);
            },
            child: Container(
              width: Get.width,
              height: 45,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  color: AppColor.red,
                  borderRadius: const BorderRadius.all(Radius.circular(8))
              ),
              child: Center(
                child: Text(
                  "Logout",style: TextStyle(color: AppColor.white,fontSize: 16,fontWeight: FontWeight.w500,fontFamily: appFontFamily),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10,),
          InkWell(
            onTap: (){
              Get.back();
            },
            child: Container(
              width: Get.width,
              height: 45,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  color: AppColor.white,
                  border: Border.all(color: AppColor.black,width: 1),
                  borderRadius: const BorderRadius.all(Radius.circular(8))
              ),
              child: Center(
                child: Text(
                  "Cancel",style: TextStyle(color: AppColor.black,fontSize: 16,fontWeight: FontWeight.w500,fontFamily: appFontFamily),
                ),
              ),
            ),
          ),
        ],
      ),
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Widget profileItems(String icon,String title,Function() onTap){
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: Get.width,
        height: 56,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColor.primaryColor, AppColor.red],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),

        ),
        child: Padding(
          padding: const EdgeInsets.all(2.0), // This is the border thickness
          child: Container(
            width: Get.width,
            height: 56,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white, // Inner container color
              borderRadius: BorderRadius.circular(10), // Match the outer radius
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(icon),
                    const SizedBox(width: 10,),
                    Text(title,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: AppColor.primaryColor,fontFamily: appFontFamily),)
                  ],
                ),
                Icon(Icons.arrow_forward_ios,size: 16,color: AppColor.primaryColor,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
