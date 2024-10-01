import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:piwotapp/constants/colors.dart';

import '../../constants/images.dart';
import '../../route/route_names.dart';



class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  static const platform = MethodChannel('com.example.flutter_activity_launcher');

  @override
  initState() {
    Timer(const Duration(seconds: 3),
            ()=>_loadScreen()
    );
  }


  _loadScreen() async
  {
    // await Prefs.load();
    // Prefs.loadData();
    //
    // if (Prefs.check_log_in == true) {

      //replaceRoute(context, DashBoard(currentIndex: 0));
          Get.offAllNamed(Routes.home);
    // }
    // else {
    //
    //      Get.offAllNamed(Routes.login);
    // }
  }






  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height,width: Get.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColor.primaryColor,AppColor.red]
        )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.center,
            child: SvgPicture.asset(Images.logo),
          )
        ],
      ),
    );
  }
}
