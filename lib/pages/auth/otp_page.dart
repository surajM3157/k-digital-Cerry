import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:get/get.dart';
import '../../constants/colors.dart';
import '../../constants/images.dart';
import '../../route/route_names.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_themes.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {

  final TextEditingController _codeController = TextEditingController();

  String otpCode = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.topLeft,
                children: [
                  Container(
                      width: Get.width,
                      color: AppColor.secondaryColor,
                      child: SvgPicture.asset(Images.otpIllustration)),
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
                child: Text("Enter Verification Code",style: AppThemes.titleTextStyle(),),
              ),
              const SizedBox(height: 5,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text("Please enter the 4 digit code we sent to your email",style: AppThemes.subtitleTextStyle(),),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text("at*****123@gmail.com to proceed",style: AppThemes.subtitleTextStyle(),),
              ),
              SizedBox(height: 20,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: PinCodeTextField(
                  enableActiveFill: true,
                  appContext: context,
                  length: 4,
                  animationType: AnimationType.fade,
                  textStyle: TextStyle(color: AppColor.white),
                  pinTheme: PinTheme(
                      selectedColor: AppColor.secondaryColor,
                      shape: PinCodeFieldShape.box,
                      activeColor: AppColor.secondaryColor,
                      inactiveColor: AppColor.secondaryColor,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 70,
                      fieldWidth: 66,
                      activeFillColor: AppColor.secondaryColor,
                      inactiveFillColor: AppColor.secondaryColor,
                      selectedFillColor: AppColor.secondaryColor
                  ),
                  // focusNode: unitCodeCtrlFocusNode
                  autoFocus: true,
                  enablePinAutofill: true,
                  cursorColor: AppColor.white,
                  animationDuration:
                  const Duration(milliseconds: 300),
                  // enableActiveFill: true,
                  controller: _codeController,
                  // focusNode: unitCodeCtrlFocusNode,
                  keyboardType: TextInputType.number,
                  boxShadows:  [
                    BoxShadow(
                      offset: Offset(0, 1),
                      color: AppColor.secondaryColor,
                      blurRadius: 10,
                    )
                  ],
                  onCompleted: (v)
                  {
                    otpCode = _codeController.text.toString();
                    setState((){});
                  },
                  // onTap: () {
                  //   print("Pressed");
                  // },
                  beforeTextPaste: (text) {
                    //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                    //but you can show anything you want here, like your pop up saying wrong paste format or etc
                    return true;
                  },
                  onChanged: (String value) {  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text("Resend Code",style: AppThemes.subtitleTextStyle(),),
              ),
              SizedBox(height: 20,),
              AppButton(title: "Verify", onTap: () {
                Get.toNamed(Routes.resetPassword);
              },),
            ],
          ),
        ),
      ),
    );
  }
}
