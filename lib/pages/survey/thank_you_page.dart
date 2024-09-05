import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:piwotapp/constants/colors.dart';
import 'package:piwotapp/constants/font_family.dart';
import 'package:piwotapp/widgets/app_button.dart';
import 'package:get/get.dart';
import '../../constants/images.dart';
import '../../route/route_names.dart';

class ThankYouPage extends StatefulWidget {
  const ThankYouPage({super.key});

  @override
  State<ThankYouPage> createState() => _ThankYouPageState();
}

class _ThankYouPageState extends State<ThankYouPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(child: SvgPicture.asset(Images.successIcon)),
            SizedBox(height: 20,),
            Text("Thank You !",style: TextStyle(fontSize: 27,fontWeight: FontWeight.w500,fontFamily: appFontFamilyHeadings,color: AppColor.primaryColor),),
            SizedBox(height: 20,),
            Text("We Appreciate your feedback",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,fontFamily: appFontFamilyHeadings,color: AppColor.black),),
            SizedBox(height: 10,),
            Text("Your Feedback helps us improve ",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w400,fontFamily: appFontFamilyBody,color: AppColor.black),),
            Text("and serve you better.",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w400,fontFamily: appFontFamilyBody,color: AppColor.black),),
            SizedBox(height: 20,),
            AppButton(title: "Back to Home", onTap: (){
              Get.offAllNamed(Routes.home);
            })
          ],
        ),
      ),
    );
  }
}
