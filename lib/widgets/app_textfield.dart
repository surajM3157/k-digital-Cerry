import 'package:flutter/material.dart';
import 'package:piwotapp/constants/font_family.dart';
import '../constants/colors.dart';

class AppTextField extends StatelessWidget {
   AppTextField({super.key,required this.hintText,required this.controller,this.prefixIcon,this.suffixIcon,this.labelText,this.readOnly,this.onTap,this.obscureText});

  String hintText;
  String? labelText;
  TextEditingController controller;
  Widget? prefixIcon;
  Widget? suffixIcon;
  bool? readOnly;
  Function()? onTap;
  bool? obscureText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        readOnly: readOnly??false,

        controller: controller,
        obscureText: obscureText??false,
        onTap: onTap,
        cursorColor: AppColor.primaryColor,
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          hintText: hintText,
          labelText: labelText,
          labelStyle: TextStyle(color: AppColor.primaryColor,fontFamily: appFontFamily,fontWeight:FontWeight.w400,fontSize: 14),
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
    );
  }
}
