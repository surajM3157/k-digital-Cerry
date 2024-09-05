
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:piwotapp/widgets/app_button.dart';
import 'package:piwotapp/widgets/app_textfield.dart';
import 'package:piwotapp/widgets/app_themes.dart';
import '../../constants/colors.dart';
import '../../constants/font_family.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {

  String rating = "Awesome";
  TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColor.white,
        title: Center(child: Padding(
          padding: const EdgeInsets.only(right: 60),
          child: Text("Feedback",style: AppThemes.appBarTitleStyle(),),
        )),
        leading: InkWell(
            onTap: (){
              Get.back();
            },
            child: Icon(Icons.arrow_back_ios,size: 20,color: AppColor.primaryColor,)),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text("Share Your Feedback",style: AppThemes.titleTextStyle().copyWith(fontSize: 20),),
          ),
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text("We would love to hear your feedback! Let us know how we’re doing or if you have any suggestions.",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,fontFamily: appFontFamilyBody,color: AppColor.mediumGrey),),
          ),
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text("How was your Experience",style: AppThemes.titleTextStyle().copyWith(fontSize: 20),),
          ),
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ratingsRow(),
          ),
          SizedBox(height: 30,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextFormField(
              controller: messageController,
              maxLines: 5,
              cursorColor: AppColor.primaryColor,
              decoration: InputDecoration(
                alignLabelWithHint: true,
                hintText: "Enter your feedback",
                labelText: "Feedback",
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
          AppButton(title: "Submit", onTap: (){})
        ],
      ),
    );
  }

  Widget ratingsRow(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: (){
            rating = "Terrible";
            setState(() {
            });
          },
          child: Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
                color: AppColor.secondaryColor,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color:rating == "Terrible"? AppColor.primaryColor:AppColor.secondaryColor,width: 2)
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("😢",style: TextStyle(fontSize: 30)),
                SizedBox(height: 5,),
                Text("Terrible",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400,fontFamily: appFontFamilyBody,color: AppColor.black),)
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: (){
            rating = "Bad";
            setState(() {
            });
          },
          child: Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
                color: AppColor.secondaryColor,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: rating == "Bad"?AppColor.primaryColor:AppColor.secondaryColor,width: 2)
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("🙁",style: TextStyle(fontSize: 30)),
                SizedBox(height: 5,),
                Text("Bad",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400,fontFamily: appFontFamilyBody,color: AppColor.black),)
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: (){
            rating = "Good";
            setState(() {
            });
          },
          child: Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
                color: AppColor.secondaryColor,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color:rating == "Good" ?AppColor.primaryColor:AppColor.secondaryColor,width: 2)
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("🙂",style: TextStyle(fontSize: 30)),
                SizedBox(height: 5,),
                Text("Good",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400,fontFamily: appFontFamilyBody,color: AppColor.black),)
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: (){
            rating = "Awesome";
            setState(() {
            });
          },
          child: Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
                color:AppColor.secondaryColor,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color:rating == "Awesome"? AppColor.primaryColor:AppColor.secondaryColor,width: 2)
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("😊",style: TextStyle(fontSize: 30)),
                SizedBox(height: 5,),
                Text("Awesome",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400,fontFamily: appFontFamilyBody,color: AppColor.black),)
              ],
            ),
          ),
        ),
        //Text("😥☹️🙂😊",style: TextStyle(fontSize: 30),),
      ],
    );
  }
}
