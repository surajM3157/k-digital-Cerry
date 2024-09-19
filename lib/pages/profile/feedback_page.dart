import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:piwotapp/widgets/app_button.dart';
import 'package:piwotapp/widgets/app_themes.dart';
import '../../constants/colors.dart';
import '../../constants/font_family.dart';
import '../../constants/images.dart';
import '../../widgets/gradient_text.dart';

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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GradientText(text: "Share Your Feedback",style: AppThemes.titleTextStyle().copyWith(fontSize: 20,fontWeight: FontWeight.w600), gradient: LinearGradient(
                colors: [AppColor.primaryColor, AppColor.red],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              ),
            ),
            const SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text("We would love to hear your feedback! Let us know how we’re doing or if you have any suggestions.",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,fontFamily: appFontFamily,color: AppColor.mediumGrey),),
            ),
            const SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GradientText(text:"How was your Experience",style: AppThemes.titleTextStyle().copyWith(fontSize: 20,fontWeight: FontWeight.w600),gradient: LinearGradient(
                colors: [AppColor.primaryColor, AppColor.red],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),),
            ),
            const SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ratingsRow(),
            ),
            const SizedBox(height: 30,),
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
                  labelStyle: const TextStyle(color: Colors.black,fontFamily: appFontFamily,fontWeight:FontWeight.w400,fontSize: 14),
                  hintStyle: const TextStyle(color: Colors.black,fontFamily: appFontFamily,fontWeight:FontWeight.w400,fontSize: 14),
                  contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  focusedBorder:  OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: AppColor.black.withOpacity(0.12))
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: AppColor.black.withOpacity(0.12))
                  ),
                  errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: const BorderSide(color: Colors.red, width: 2.0)),
                  focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: const BorderSide(color: Colors.red, width: 2.0)),
                ),
              ),
            ),
            const SizedBox(height: 30,),
            AppButton(title: "Submit", onTap: (){})
          ],
        ),
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
                const Text("😢",style: TextStyle(fontSize: 30)),
                const SizedBox(height: 5,),
                Text("Terrible",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400,fontFamily: appFontFamily,color: AppColor.black),)
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
                const Text("🙁",style: TextStyle(fontSize: 30)),
                const SizedBox(height: 5,),
                Text("Bad",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400,fontFamily: appFontFamily,color: AppColor.black),)
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
                const Text("🙂",style: TextStyle(fontSize: 30)),
                const SizedBox(height: 5,),
                Text("Good",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400,fontFamily: appFontFamily,color: AppColor.black),)
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
                const Text("😊",style: TextStyle(fontSize: 30)),
                const SizedBox(height: 5,),
                Text("Awesome",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400,fontFamily: appFontFamily,color: AppColor.black),)
              ],
            ),
          ),
        ),
        //Text("😥☹️🙂😊",style: TextStyle(fontSize: 30),),
      ],
    );
  }
}
