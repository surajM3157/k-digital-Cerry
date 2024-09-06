import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../constants/colors.dart';
import '../../constants/font_family.dart';
import '../../constants/images.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_textfield.dart';
import '../../widgets/app_themes.dart';
import '../../widgets/gradient_text.dart';


class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {

  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
               margin: EdgeInsets.only(top: 230),
               decoration: BoxDecoration(
                   color: AppColor.white,
                   borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30),
                   )
               ),
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   const SizedBox(height: 20,),
                   Padding(
                     padding: const EdgeInsets.only(left: 40),
                     child: GradientText(text:"Set your new password.",gradient: LinearGradient(
                       colors: [AppColor.primaryColor, AppColor.red],
                       begin: Alignment.topLeft,
                       end: Alignment.bottomRight,
                     ),style: AppThemes.titleTextStyle().copyWith(fontWeight: FontWeight.w600,fontSize: 24),),
                   ),
                   const SizedBox(height: 20,),
                   Padding(
                     padding: const EdgeInsets.only(left: 40),
                     child: Text("New Password",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: AppColor.primaryColor,fontFamily: appFontFamily),),
                   ),
                   Padding(
                     padding: const EdgeInsets.symmetric(horizontal: 20),
                     child: TextFormField(
                       obscureText: true,
                       controller: _passwordController,
                       cursorColor: AppColor.primaryColor,
                       decoration: InputDecoration(
                         suffixIcon: Icon(Icons.remove_red_eye_outlined,color: AppColor.primaryColor,),
                         hintText: "Type your new password",
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
                   const SizedBox(height: 20,),
                   Padding(
                     padding: const EdgeInsets.only(left: 40),
                     child: Text("New Password",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: AppColor.primaryColor,fontFamily: appFontFamily),),
                   ),
                   Padding(
                     padding: const EdgeInsets.symmetric(horizontal: 20),
                     child: TextFormField(
                       obscureText: true,
                       controller: _passwordController,
                       cursorColor: AppColor.primaryColor,
                       decoration: InputDecoration(
                         suffixIcon: Icon(Icons.remove_red_eye_outlined,color: AppColor.primaryColor,),
                         hintText: "Confirm your new password",
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
                   const SizedBox(height: 30,),
                   AppButton(title: "Update Password", onTap: () {  },)
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
