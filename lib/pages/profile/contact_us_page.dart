import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:googleapis/admob/v1.dart';
import 'package:piwotapp/widgets/app_button.dart';
import '../../constants/colors.dart';
import '../../constants/font_family.dart';
import '../../constants/images.dart';
import '../../repository/api_repo.dart';
import '../../widgets/app_themes.dart';
import '../../widgets/gradient_text.dart';

class ContactUsPage extends StatefulWidget {
  const ContactUsPage({super.key});

  @override
  State<ContactUsPage> createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {

  TextEditingController messageController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isConnected = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColor.primaryColor,
        title: Padding(
          padding: const EdgeInsets.only(right: 60),
          child: Center(child: SvgPicture.asset(Images.logo, height: 40,width: 147)),
        ),
        leading: InkWell(
            onTap: (){
              Get.back();
            },
            child: Icon(Icons.arrow_back_ios,size: 20,color: AppColor.white,)),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20,),
              Center(
                child: GradientText(text: "Contact Us", style: const TextStyle(fontWeight: FontWeight.w600,fontSize: 20,fontFamily: appFontFamily), gradient:LinearGradient(
                  colors: AppColor.gradientColors,
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),),
              ),
              const SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: GradientText(text:"Get in Touch",style: AppThemes.titleTextStyle().copyWith(fontSize: 18,fontWeight: FontWeight.w600), gradient:  LinearGradient(
                  colors: AppColor.gradientColors,
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),),
              ),
              const SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text("We’d love to hear from you! Share your questions, and we’ll get back to you as soon as possible.",style:  TextStyle(fontSize: 14,fontWeight: FontWeight.w400,fontFamily: appFontFamily,color: AppColor.mediumGrey),),
              ),
              const SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  controller: nameController,
                  cursorColor: AppColor.primaryColor,
                  decoration: InputDecoration(
                    hintText: "Enter your name",
                    labelText: "Name",
                    labelStyle:  TextStyle(color:AppColor.primaryColor,fontFamily: appFontFamily,fontWeight:FontWeight.w400,fontSize: 14),
                    hintStyle: const TextStyle(color: Colors.black,fontFamily: appFontFamily,fontWeight:FontWeight.w400,fontSize: 14),
                    contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    focusedBorder:  OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(color: AppColor.black.withOpacity(0.12))
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(color: AppColor.black.withOpacity(0.12))
                    ),
                    errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: const BorderSide(color: Colors.red, width: 2.0)),
                    focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: const BorderSide(color: Colors.red, width: 2.0)),
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  inputFormatters: [ FilteringTextInputFormatter.allow(RegExp("[a-zA-Z\\s\\.]")), ],
                  validator: (value)
                  {
                    if (value.toString() == "")
                    {
                      return 'Enter valid name.';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  cursorColor: AppColor.primaryColor,
                  decoration: InputDecoration(
                    hintText: "Enter your email",
                    labelText: "Email",
                    prefixIcon: Icon(Icons.email_outlined,color: AppColor.primaryColor,),
                    labelStyle:  TextStyle(color: AppColor.primaryColor,fontFamily: appFontFamily,fontWeight:FontWeight.w400,fontSize: 14),
                    hintStyle: const TextStyle(color: Colors.black,fontFamily: appFontFamily,fontWeight:FontWeight.w400,fontSize: 14),
                    contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    focusedBorder:  OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(color: AppColor.black.withOpacity(0.12))
                    ),
                    enabledBorder:  OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(color: AppColor.black.withOpacity(0.12))
                    ),
                    errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: const BorderSide(color: Colors.red, width: 2.0)),
                    focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: const BorderSide(color: Colors.red, width: 2.0)),
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value)
                  {
                    if (value.toString() == ""||!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value.toString()))
                    {
                      return 'Enter a valid email.';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  controller: phoneNumberController,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(10),
                  ],
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value)
                  {
                    if (value.toString() == ""||value.toString().length!=10)
                    {
                      return 'Enter a valid phone number.';
                    }
                    return null;
                  },
                  cursorColor: AppColor.primaryColor,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: "Enter your phone number",
                    labelText: "Phone Number",
                    prefixIcon: Icon(Icons.call,color: AppColor.primaryColor,),
                    labelStyle:  TextStyle(color: AppColor.primaryColor,fontFamily: appFontFamily,fontWeight:FontWeight.w400,fontSize: 14),
                    hintStyle: const TextStyle(color: Colors.black,fontFamily: appFontFamily,fontWeight:FontWeight.w400,fontSize: 14),
                    contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    focusedBorder:  OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(color: AppColor.black.withOpacity(0.12))
                    ),
                    enabledBorder:  OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(color: AppColor.black.withOpacity(0.12))
                    ),
                    errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: const BorderSide(color: Colors.red, width: 2.0)),
                    focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: const BorderSide(color: Colors.red, width: 2.0)),
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text("Message",style: AppThemes.titleTextStyle().copyWith(fontSize: 20),),
              ),
              const SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  controller: messageController,
                  maxLines: 5,
                  cursorColor: AppColor.primaryColor,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value)
                  {
                    if (value.toString() == "")
                    {
                      return 'Enter valid message.';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    alignLabelWithHint: true,
                    hintText: "Enter your message",
                    labelText: "Write your message",
                    labelStyle:  TextStyle(color: AppColor.primaryColor,fontFamily: appFontFamily,fontWeight:FontWeight.w400,fontSize: 14),
                    hintStyle:  TextStyle(color: AppColor.black,fontFamily: appFontFamily,fontWeight:FontWeight.w400,fontSize: 14),
                    contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    focusedBorder:  OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(color: AppColor.black.withOpacity(0.12))
                    ),
                    enabledBorder:  OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(color: AppColor.black.withOpacity(0.12))
                    ),
                    errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: const BorderSide(color: Colors.red, width: 2.0)),
                    focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: const BorderSide(color: Colors.red, width: 2.0)),
                  ),
                ),
              ),
              const SizedBox(height: 30,),
              AppButton(title: "Send Message", onTap: (){
                if(_formKey.currentState!.validate()){
                  print("validate");
                  contactus();
                }
              }),
              const SizedBox(height: 20,)
            ],
          ),
        ),
      ),
    );
  }

  contactus()async{

    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      isConnected = false;
      EasyLoading.showToast("No Internet",
          dismissOnTap: true,
          duration: const Duration(seconds: 1),
          toastPosition: EasyLoadingToastPosition.center);
      setState(() {

      });
    }else {
      isConnected = true;
      Map<String, String> params = {
        "name":nameController.text.trim(),
        "email":emailController.text.trim(),
        "mobile_number":phoneNumberController.text.trim(),
        "message":messageController.text.trim()
      };



      Future.delayed(Duration.zero, () {
        showLoader(context);
      });

      await ApiRepo().contactus(params);
    }
  }

}
