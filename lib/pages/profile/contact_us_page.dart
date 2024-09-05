import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:piwotapp/widgets/app_button.dart';
import '../../constants/colors.dart';
import '../../constants/font_family.dart';
import '../../widgets/app_themes.dart';

class ContactUsPage extends StatefulWidget {
  const ContactUsPage({super.key});

  @override
  State<ContactUsPage> createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {

  TextEditingController messageController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColor.white,
        title: Center(child: Padding(
          padding: const EdgeInsets.only(right: 60),
          child: Text("Contact Us",style: AppThemes.appBarTitleStyle(),),
        )),
        leading: InkWell(
            onTap: (){
              Get.back();
            },
            child: Icon(Icons.arrow_back_ios,size: 20,color: AppColor.primaryColor,)),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text("Get in Touch",style: AppThemes.titleTextStyle().copyWith(fontSize: 20),),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text("We’d love to hear from you! Share your questions , and we’ll get back to you as soon as possible.",style:  TextStyle(fontSize: 14,fontWeight: FontWeight.w400,fontFamily: appFontFamilyBody,color: AppColor.mediumGrey),),
            ),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                controller: nameController,
                cursorColor: AppColor.primaryColor,
                decoration: InputDecoration(
                  hintText: "Enter your name",
                  labelText: "Name",
                  labelStyle: TextStyle(color: Colors.black,fontFamily: appFontFamilyBody,fontWeight:FontWeight.w400,fontSize: 14),
                  hintStyle: TextStyle(color: Colors.black,fontFamily: appFontFamilyBody,fontWeight:FontWeight.w400,fontSize: 14),
                  contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color:AppColor.primaryColor,width: 2)),
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color:AppColor.primaryColor,width: 2)),
                  errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.red, width: 2.0)),
                  focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.red, width: 2.0)),
                ),
              ),
            ),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                controller: emailController,
                cursorColor: AppColor.primaryColor,
                decoration: InputDecoration(
                  hintText: "Enter your email",
                  labelText: "Email",
                  prefixIcon: Icon(Icons.email_outlined,color: AppColor.primaryColor,),
                  labelStyle: TextStyle(color: Colors.black,fontFamily: appFontFamilyBody,fontWeight:FontWeight.w400,fontSize: 14),
                  hintStyle: TextStyle(color: Colors.black,fontFamily: appFontFamilyBody,fontWeight:FontWeight.w400,fontSize: 14),
                  contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color:AppColor.primaryColor,width: 2)),
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color:AppColor.primaryColor,width: 2)),
                  errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.red, width: 2.0)),
                  focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.red, width: 2.0)),
                ),
              ),
            ),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                controller: phoneNumberController,
                cursorColor: AppColor.primaryColor,
                decoration: InputDecoration(
                  hintText: "Enter your phone number",
                  labelText: "Phone Number",
                  prefixIcon: Icon(Icons.call,color: AppColor.primaryColor,),
                  labelStyle: TextStyle(color: Colors.black,fontFamily: appFontFamilyBody,fontWeight:FontWeight.w400,fontSize: 14),
                  hintStyle: TextStyle(color: Colors.black,fontFamily: appFontFamilyBody,fontWeight:FontWeight.w400,fontSize: 14),
                  contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color:AppColor.primaryColor,width: 2)),
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color:AppColor.primaryColor,width: 2)),
                  errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.red, width: 2.0)),
                  focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.red, width: 2.0)),
                ),
              ),
            ),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text("Message",style: AppThemes.titleTextStyle().copyWith(fontSize: 20),),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                controller: messageController,
                maxLines: 5,
                cursorColor: AppColor.primaryColor,
                decoration: InputDecoration(
                  alignLabelWithHint: true,
                  hintText: "Enter your message",
                  labelText: "Write your message",
                  labelStyle: TextStyle(color: Colors.black,fontFamily: appFontFamilyBody,fontWeight:FontWeight.w400,fontSize: 14),
                  hintStyle: TextStyle(color: Colors.black,fontFamily: appFontFamilyBody,fontWeight:FontWeight.w400,fontSize: 14),
                  contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color:AppColor.primaryColor,width: 2)),
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color:AppColor.primaryColor,width: 2)),
                  errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.red, width: 2.0)),
                  focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.red, width: 2.0)),
                ),
              ),
            ),
            SizedBox(height: 30,),
            AppButton(title: "Send Message", onTap: (){})
          ],
        ),
      ),
    );
  }
}
