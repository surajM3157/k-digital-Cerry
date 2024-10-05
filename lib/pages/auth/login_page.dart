import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:piwotapp/constants/colors.dart';
import 'package:get/get.dart';
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

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {
  final TextEditingController _phoneNumberController = TextEditingController();
  bool isObscure = true;

  late AnimationController _animationController;
  late Animation<double> _logoAnimation;

  @override
  void initState() {
    super.initState();
    // Initialize the animation controller
    _animationController = AnimationController(
      duration:  Duration(milliseconds: 1000 ),
      vsync: this,
    );

    // Define the animation for the logo's Y-axis position
    _logoAnimation = Tween<double>(begin: 600, end: 100).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    // Start the animation
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              width: Get.width,
              height: 300,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColor.primaryColor, AppColor.red],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 280),
              decoration: BoxDecoration(
                color: AppColor.white,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(30),
                  topLeft: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  Center(
                    child: GradientText(
                      text: "Log in",
                      gradient: LinearGradient(
                        colors: [AppColor.primaryColor, AppColor.red],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      style: AppThemes.titleTextStyle()
                          .copyWith(fontWeight: FontWeight.w600, fontSize: 24),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      "Enter your phone number",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        fontFamily: appFontFamily,
                        color: AppColor.primaryColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      controller: _phoneNumberController,
                      cursorColor: AppColor.primaryColor,
                      maxLength: 10,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        counterText: '',
                        hintText: "+91 987065****",
                        prefixIcon: Icon(
                          Icons.call,
                          color: AppColor.FFA2A2A2,
                        ),
                        labelStyle: const TextStyle(
                          color: Colors.black,
                          fontFamily: appFontFamily,
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                        hintStyle: TextStyle(
                          color: AppColor.FFA2A2A2,
                          fontFamily: appFontFamily,
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                        contentPadding:
                        const EdgeInsets.fromLTRB(20, 10, 20, 10),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: AppColor.primaryColor),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: AppColor.primaryColor),
                        ),
                        errorBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 2.0),
                        ),
                        focusedErrorBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 2.0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  AppButton(
                    title: "Next",
                    onTap: () {
                      Get.toNamed(Routes.otp);
                    },
                  ),
                ],
              ),
            ),
            AnimatedBuilder(
              animation: _logoAnimation,
              builder: (context, child) {
                return Positioned(
                  top: _logoAnimation.value,
                  left: 40,
                  child: Center(child: SvgPicture.asset(Images.logo)),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

