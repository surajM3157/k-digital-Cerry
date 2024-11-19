import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../constants/colors.dart';
import '../../constants/font_family.dart';
import '../../constants/images.dart';
import '../../route/route_names.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_themes.dart';
import '../../widgets/gradient_text.dart';

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
          child: Stack(
            children: [
              Stack(
                alignment: Alignment.topLeft,
                children: [
                  Container(
                      width: Get.width,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      height: 252,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: AppColor.gradientColors,
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                      ),
                      child: SvgPicture.asset(Images.logo)),
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
              Container(
                margin: const EdgeInsets.only(top: 230),
                decoration: BoxDecoration(
                  color: AppColor.white,
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30),
                  )
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.only(left: 40),
                      child: GradientText(text:"Forgot Password",gradient: LinearGradient(
                        colors: AppColor.gradientColors,
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),style: AppThemes.titleTextStyle().copyWith(fontWeight: FontWeight.w600,fontSize: 24),),
                    ),
                    const SizedBox(height: 5,),
                    Padding(
                      padding: const EdgeInsets.only(left: 40),
                      child: Text("You will receive a code via email.",style: AppThemes.subtitleTextStyle(),),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 40),
                      child: Text("Enter the email below to reset your password.",style: AppThemes.subtitleTextStyle(),),
                    ),
                    const SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.only(left: 40),
                      child: Text("Email",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: AppColor.primaryColor,fontFamily: appFontFamily),),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        controller: _emailController,
                        cursorColor: AppColor.primaryColor,
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.lock_outline,color: AppColor.primaryColor,),
                          hintText: "Enter Email Address",
                          hintStyle: const TextStyle(color: Colors.black,fontFamily: appFontFamily,fontWeight:FontWeight.w400,fontSize: 14),
                          filled: true,
                          fillColor: AppColor.white,
                          contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color:AppColor.greyTextField, width: 2.0)),
                          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color:AppColor.greyTextField, width: 2.0)),
                          errorBorder: const UnderlineInputBorder( borderSide: BorderSide(color: Colors.red, width: 2.0)),
                          focusedErrorBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.red, width: 2.0)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30,),
                    AppButton(title: "Send Reset Link", onTap: () {
                      Get.toNamed(Routes.otp);
                    },)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
