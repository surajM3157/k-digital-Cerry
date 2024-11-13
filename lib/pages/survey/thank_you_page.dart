import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:piwotapp/constants/colors.dart';
import 'package:piwotapp/constants/font_family.dart';
import 'package:piwotapp/widgets/app_button.dart';
import 'package:get/get.dart';
import '../../constants/images.dart';
import '../../route/route_names.dart';
import '../../widgets/gradient_text.dart';

class ThankYouPage extends StatefulWidget {
  const ThankYouPage({super.key});

  @override
  State<ThankYouPage> createState() => _ThankYouPageState();
}

class _ThankYouPageState extends State<ThankYouPage> {

  bool surveyStatus = false;

  @override
  void initState() {
    surveyStatus = Get.arguments['surveyStatus'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                padding: const EdgeInsets.all(40),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColor.primaryColor, AppColor.red],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(200))
                ),
                  child: SvgPicture.asset(Images.successNotificationIcon,height: 72,width: 72,)),
            ),
            const SizedBox(height: 16,),
           Center(
              child: GradientText(text: surveyStatus?"Feedback Already Submitted":"Thank You !",style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w600,fontFamily: appFontFamily), gradient: LinearGradient(
                colors: [AppColor.primaryColor, AppColor.red],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),),
            ),
            const SizedBox(height: 24,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(surveyStatus?"Thank you for your interest!\nOur records show that you've already\nsubmitted feedback.We truly appreciate your input.":"We Appreciate your feedback.\nYour Feedback helps us improve and\nserve you better.",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,fontFamily: appFontFamily,color: AppColor.black),),
            ),
            const SizedBox(height: 32,),
            AppButton(title: "Back to Home", onTap: (){
              Get.offAllNamed(Routes.home);
            })
          ],
        ),
      ),
    );
  }
}
