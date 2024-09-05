import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:piwotapp/constants/colors.dart';
import 'package:get/get.dart';
import 'package:piwotapp/widgets/app_textfield.dart';
import 'package:piwotapp/widgets/app_themes.dart';
import '../../constants/images.dart';
import '../../route/route_names.dart';
import '../../widgets/app_button.dart';

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: Get.width,
                color: AppColor.secondaryColor,
                  child: SvgPicture.asset(Images.loginIllustration)),
              const SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text("Login",style: AppThemes.titleTextStyle(),),
              ),
              const SizedBox(height: 5,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text("Please log in to continue.",style: AppThemes.subtitleTextStyle(),),
              ),
              const SizedBox(height: 20,),
              AppTextField(hintText: "Type Your Email Address", controller: _emailController,prefixIcon: Icon(Icons.email_outlined,color: Colors.black,),),
              const SizedBox(height: 20,),
              AppTextField(
                obscureText: isObscure,
                hintText: "Type Your Password", controller: _passwordController,prefixIcon: Icon(Icons.lock_outline,color: Colors.black,),suffixIcon: GestureDetector(
                  onTap: (){
                    isObscure = !isObscure;
                    setState(() {
                    });
                  },
                  child: Icon(isObscure?Icons.remove_red_eye:Icons.remove_red_eye_outlined,color: Colors.black,)),),
              const SizedBox(height: 20,),
              AppButton(title: "Login", onTap: () {  },),
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: InkWell(
                      onTap: (){
                        Get.toNamed(Routes.forgotPassword);
                      },
                        child: Text("Forgot Password",style: AppThemes.subtitleTextStyle(),)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
