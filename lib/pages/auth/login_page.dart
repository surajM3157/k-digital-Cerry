import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:piwotapp/constants/colors.dart';
import 'package:get/get.dart';
import 'package:piwotapp/widgets/app_textfield.dart';
import 'package:piwotapp/widgets/app_themes.dart';
import '../../constants/font_family.dart';
import '../../constants/images.dart';
import '../../route/route_names.dart';
import '../../widgets/app_button.dart';
import '../../widgets/gradient_text.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isObscure = true;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                width: Get.width,
                  height: 252,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColor.primaryColor, AppColor.red],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                  child: SvgPicture.asset(Images.logo)),
              Container(
                margin: EdgeInsets.only(top: 230),
                decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30))
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 30,),
                    Center(
                      child: GradientText(text:"Log in",gradient: LinearGradient(
                        colors: [AppColor.primaryColor, AppColor.red],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),style: AppThemes.titleTextStyle().copyWith(fontWeight: FontWeight.w600,fontSize: 24),),
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
                          hintStyle: TextStyle(color: Colors.black,fontFamily: appFontFamily,fontWeight:FontWeight.w400,fontSize: 14),
                          filled: true,
                          fillColor: AppColor.white,
                          contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color:AppColor.greyTextField, width: 2.0)),
                          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color:AppColor.greyTextField, width: 2.0)),
                          errorBorder: UnderlineInputBorder( borderSide: BorderSide(color: Colors.red, width: 2.0)),
                          focusedErrorBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.red, width: 2.0)),
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.only(left: 40),
                      child: Text("Password",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: AppColor.primaryColor,fontFamily: appFontFamily),),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        obscureText: true,
                        controller: _emailController,
                        cursorColor: AppColor.primaryColor,
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.remove_red_eye_outlined,color: AppColor.primaryColor,),
                          hintText: "********",
                          hintStyle: TextStyle(color: Colors.black,fontFamily: appFontFamily,fontWeight:FontWeight.w400,fontSize: 14),
                          filled: true,
                          fillColor: AppColor.white,
                          contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color:AppColor.greyTextField, width: 2.0)),
                          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color:AppColor.greyTextField, width: 2.0)),
                          errorBorder: UnderlineInputBorder( borderSide: BorderSide(color: Colors.red, width: 2.0)),
                          focusedErrorBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.red, width: 2.0)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: InkWell(
                              onTap: (){
                                Get.toNamed(Routes.forgotPassword);
                              },
                              child: Text("Forgot Password",style: TextStyle(fontFamily: appFontFamily,fontSize: 14,fontWeight: FontWeight.w600,color: AppColor.FF161616),)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30,),
                    AppButton(title: "Login", onTap: () {  },),

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
