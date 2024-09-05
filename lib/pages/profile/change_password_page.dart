import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants/colors.dart';
import '../../constants/font_family.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_textfield.dart';
import '../../widgets/app_themes.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {

  TextEditingController _currentPasswordController = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  bool isCurrent = true;
  bool isNew = true;
  bool isConfirm = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColor.white,
        title: Center(child: Padding(
          padding: const EdgeInsets.only(right: 60),
          child: Text("Change Password",style:  AppThemes.appBarTitleStyle(),),
        )),
        leading: InkWell(
            onTap: (){
              Get.back();
            },
            child: Icon(Icons.arrow_back_ios,size: 20,color: AppColor.primaryColor,)),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50,),
            AppTextField(
              obscureText: isCurrent,
              hintText: "Type Current Password", controller: _currentPasswordController,prefixIcon: Icon(Icons.lock_outline,color: Colors.black,),suffixIcon: GestureDetector(
              onTap: (){
                isCurrent = !isCurrent;
                setState(() {

                });
              },
                child: Icon(isCurrent?Icons.remove_red_eye:Icons.remove_red_eye_outlined,color: Colors.black,)),labelText: "Current Password",),
            const SizedBox(height: 40,),

            AppTextField(
              obscureText: isNew,
              hintText: "Type New Password", controller: _newPasswordController,prefixIcon: Icon(Icons.lock_outline,color: Colors.black,),suffixIcon: GestureDetector(
              onTap: (){
                isNew = !isNew;
                setState(() {

                });
              },
                child: Icon(isNew?Icons.remove_red_eye:Icons.remove_red_eye_outlined,color: Colors.black,)),labelText: "New Password",),
            const SizedBox(height: 20,),
            AppTextField(
              obscureText: isConfirm,
              hintText: "Re-enter New Password", controller: _confirmPasswordController,prefixIcon: Icon(Icons.lock_outline,color: Colors.black,),suffixIcon: GestureDetector(
              onTap: (){
                isConfirm = !isConfirm;
                setState(() {
                });
              },
                child: Icon(isConfirm?Icons.remove_red_eye:Icons.remove_red_eye_outlined,color: Colors.black,)),labelText: "Confirm Password",),
            const SizedBox(height: 30,),
            AppButton(title: "Update Password", onTap: () {  },)
          ],
        ),
      ),
    );
  }
}
