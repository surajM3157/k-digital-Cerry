import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../constants/colors.dart';
import '../../constants/images.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_textfield.dart';
import '../../widgets/app_themes.dart';


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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.topLeft,
                children: [
                  Container(
                      width: Get.width,
                      color: AppColor.secondaryColor,
                      child: SvgPicture.asset(Images.resetPassIllustration)),
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
                child: Text("Set your new password.",style: AppThemes.titleTextStyle(),),
              ),
              const SizedBox(height: 20,),
              AppTextField(hintText: "Type Your New Password", controller: _passwordController,prefixIcon: Icon(Icons.lock_outline,color: Colors.black,),suffixIcon: Icon(Icons.remove_red_eye_outlined,color: Colors.black,),),
              const SizedBox(height: 20,),
              AppTextField(hintText: "Confirm Your New Password", controller: _passwordController,prefixIcon: Icon(Icons.lock_outline,color: Colors.black,),suffixIcon: Icon(Icons.remove_red_eye_outlined,color: Colors.black,),),
              const SizedBox(height: 20,),
              AppButton(title: "Update Password", onTap: () {  },)
            ],
          ),
        ),
      ),
    );
  }
}
