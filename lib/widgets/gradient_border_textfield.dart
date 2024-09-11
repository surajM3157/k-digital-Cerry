import 'package:flutter/material.dart';

import '../constants/colors.dart';

class GradientBorderTextField extends StatelessWidget {

  GradientBorderTextField({required this.labelText, required this.hintText, required this.controller,this.readOnly,this.onTap});

  String hintText;
  String labelText;
  TextEditingController controller;
  bool? readOnly;
  Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        gradient: LinearGradient(
          colors: [AppColor.primaryColor, AppColor.red], // Your gradient colors
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: AppColor.white, // Background color for the inner container
        ),
        padding: EdgeInsets.all(2), // Adjust this for the border thickness
        child: TextFormField(
          onTap: onTap,
          controller: controller,
          readOnly: readOnly??false,
          cursorColor: AppColor.primaryColor, // Customize as per your theme
          decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: hintText,
            label: Text(
              labelText,
              style: TextStyle(
                color: AppColor.primaryColor, // Customize label color
                fontWeight: FontWeight.w400,
              ),
            ),
            hintStyle: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
            contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide.none, // Border is handled by the container
            ),
          ),
        ),
      ),
    );
  }
}
