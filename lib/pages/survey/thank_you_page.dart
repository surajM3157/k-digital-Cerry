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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 175,width: 178,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColor.primaryColor, AppColor.red],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(200))
              ),
                child: SvgPicture.asset(Images.successNotificationIcon)),
            const SizedBox(height: 20,),
            GradientText(text:"Thank You !",style: const TextStyle(fontSize: 27,fontWeight: FontWeight.w600,fontFamily: appFontFamily), gradient: LinearGradient(
              colors: [AppColor.primaryColor, AppColor.red],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),),
            const SizedBox(height: 20,),
            Text("We Appreciate your feedback",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,fontFamily: appFontFamily,color: AppColor.black),),
            const SizedBox(height: 10,),
            Text("Your Feedback helps us improve ",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w400,fontFamily: appFontFamily,color: AppColor.black),),
            Text("and serve you better.",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w400,fontFamily: appFontFamily,color: AppColor.black),),
            const SizedBox(height: 20,),
            AppButton(title: "Back to Home", onTap: (){
              Get.offAllNamed(Routes.home);
            })
          ],
        ),
      ),
    );
  }
}
