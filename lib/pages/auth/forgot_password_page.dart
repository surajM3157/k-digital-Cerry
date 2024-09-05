import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../constants/colors.dart';
import '../../constants/images.dart';
import '../../route/route_names.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_textfield.dart';
import '../../widgets/app_themes.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {

  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.topLeft,
                children: [
                  Container(
                      width: Get.width,
                      color: AppColor.secondaryColor,
                      child: SvgPicture.asset(Images.forgotPassIllustration)),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: InkWell(
                      onTap: (){
                        Get.back();
                      },
                        child: Icon(Icons.arrow_back_ios,color: AppColor.white,)),
                  )
                ],
              ),
              const SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text("Forgot Password",style: AppThemes.titleTextStyle(),),
              ),
              const SizedBox(height: 5,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text("You will receive a code via email.",style: AppThemes.subtitleTextStyle(),),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text("Enter the email below to reset your password.",style: AppThemes.subtitleTextStyle(),),
              ),
              const SizedBox(height: 20,),
              AppTextField(hintText: "Type Your Email Address", controller: _emailController,prefixIcon: Icon(Icons.email_outlined,color: Colors.black,),),
              const SizedBox(height: 20,),
              AppButton(title: "Send Reset Link", onTap: () {
                Get.toNamed(Routes.otp);
              },)
            ],
          ),
        ),
      ),
    );
  }
}
