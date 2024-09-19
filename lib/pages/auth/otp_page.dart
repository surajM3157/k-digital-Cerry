import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:get/get.dart';
import '../../constants/colors.dart';
import '../../constants/images.dart';
import '../../route/route_names.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_themes.dart';
import '../../widgets/gradient_text.dart';

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
        child: Stack(
          children: [
            Stack(
              alignment: Alignment.topLeft,
              children: [
                Container(
                    width: Get.width,
                    height: 300,
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
                  padding: const EdgeInsets.fromLTRB(10, 50, 0, 0),
                  child: InkWell(
                      onTap: (){
                        Get.back();
                      },
                      child: Icon(Icons.arrow_back_ios,color: AppColor.white,)),
                )
              ],
            ),
           Container(
             margin: EdgeInsets.only(top: 280),
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
                   padding: const EdgeInsets.symmetric(horizontal: 20),
                   child: GradientText(text:"Enter Verification Code",gradient: LinearGradient(
                     colors: [AppColor.primaryColor, AppColor.red],
                     begin: Alignment.topLeft,
                     end: Alignment.bottomRight,
                   ),style: AppThemes.titleTextStyle().copyWith(fontWeight: FontWeight.w600,fontSize: 24),),
                 ),
                 const SizedBox(height: 5,),
                 Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 20),
                   child: Text('"Enter the 4-digit code we just sent to your',style: AppThemes.subtitleTextStyle(),),
                 ),
                 Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 20),
                   child: Text('mobile number to continue."',style: AppThemes.subtitleTextStyle(),),
                 ),
                 SizedBox(height: 20,),
                 Padding(
                   padding: EdgeInsets.symmetric(horizontal: 20),
                   child: PinCodeTextField(
                     enableActiveFill: true,
                     appContext: context,
                     length: 4,
                     animationType: AnimationType.fade,
                     textStyle: TextStyle(color: AppColor.primaryColor),
                     pinTheme: PinTheme(
                         selectedColor: AppColor.primaryColor,
                         shape: PinCodeFieldShape.underline,
                         activeColor: AppColor.primaryColor,
                         inactiveColor: AppColor.primaryColor,
                         // borderRadius: BorderRadius.circular(5),
                         borderWidth: 2,
                         activeBorderWidth: 2,
                         inactiveBorderWidth: 2,
                         fieldHeight: 70,
                         fieldWidth: 66,
                         activeFillColor: AppColor.white,
                         inactiveFillColor: AppColor.white,
                         selectedFillColor: AppColor.white
                     ),
                     // focusNode: unitCodeCtrlFocusNode
                     autoFocus: true,
                     enablePinAutofill: true,
                     cursorColor: AppColor.primaryColor,
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
                   Get.offAllNamed(Routes.home);
                 },),
               ],
             ),
           )
          ],
        ),
      ),
    );
  }


  Widget otpField(){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Stack(
        children: [
          // Outer container with gradient border
          Container(
            height: 70, // Field height
            width: 66 * 4, // Field width * number of fields (4 in this case)
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF1B1464), Color(0xFFCF2E2E)], // Gradient colors
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          // PinCodeTextField
          Padding(
            padding: const EdgeInsets.all(2.0), // Padding to create space for the gradient
            child: PinCodeTextField(
              enableActiveFill: true,
              appContext: context,
              length: 4,
              animationType: AnimationType.fade,
              textStyle: TextStyle(color: AppColor.primaryColor),
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(5),
                fieldHeight: 70,
                fieldWidth: 66,
                activeFillColor: AppColor.white,
                inactiveFillColor: AppColor.white,
                selectedFillColor: AppColor.white,
                activeColor: Colors.transparent,
                inactiveColor: Colors.transparent,
                selectedColor: Colors.transparent,
              ),
              controller: _codeController,
              autoFocus: true,
              enablePinAutofill: true,
              cursorColor: AppColor.primaryColor,
              animationDuration: const Duration(milliseconds: 300),
              keyboardType: TextInputType.number,
              boxShadows: [
                BoxShadow(
                  offset: Offset(0, 1),
                  color: AppColor.secondaryColor,
                  blurRadius: 10,
                )
              ],
              onCompleted: (v) {
                otpCode = _codeController.text.toString();
              },
              beforeTextPaste: (text) {
                return true;
              },
              onChanged: (String value) {},
            ),
          ),
        ],
      ),
    );
  }
}
