import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:piwotapp/constants/colors.dart';
import 'package:get/get.dart';
import 'package:piwotapp/widgets/app_themes.dart';
import '../../constants/images.dart';
import '../../widgets/gradient_text.dart';

class Booking extends StatefulWidget {
  const Booking({super.key});

  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height/1.5,
      width: Get.width,
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [AppColor.primaryColor,AppColor.red]),
          borderRadius: const BorderRadius.all(Radius.circular(12))
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: Get.height,
            width: 288,
            decoration: BoxDecoration(
                color: AppColor.white,
                borderRadius: const BorderRadius.all(Radius.circular(12))
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                    borderRadius:const BorderRadius.only(topRight: Radius.circular(12),topLeft: Radius.circular(12)),
                    child: Image.asset(Images.eventDetailsBanner)),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [ const SizedBox(
                        height: 20,
                      ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: GradientText(text:"Event Name",style: AppThemes.subtitleTextStyle().copyWith(fontWeight: FontWeight.w600),gradient:LinearGradient(
                            colors: [AppColor.primaryColor, AppColor.red],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),),
                        ),
                        const SizedBox(height: 5,),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text("NETWORKING DINNER",style: AppThemes.subtitleTextStyle().copyWith(color: AppColor.FF161616),),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: GradientText(text:"Time",style: AppThemes.subtitleTextStyle().copyWith(fontWeight: FontWeight.w600),gradient:LinearGradient(
                            colors: [AppColor.primaryColor, AppColor.red],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),),
                        ),
                        const SizedBox(height: 5,),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text("10:00 AM",style: AppThemes.subtitleTextStyle().copyWith(color: AppColor.FF161616),),
                        ),
                        const SizedBox(height: 20,),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: GradientText(text:"Date",style: AppThemes.subtitleTextStyle().copyWith(fontWeight: FontWeight.w600),gradient:LinearGradient(
                            colors: [AppColor.primaryColor, AppColor.red],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),),
                        ),
                        const SizedBox(height: 5,),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text("20 August 2024 ",style: AppThemes.subtitleTextStyle().copyWith(color: AppColor.FF161616),),
                        ),],
                    ),
                    Image.asset(Images.qrCode,height: 106,width: 106,)
                  ],
                ),
              ],
            ),
          ),
          Positioned(
              left: -7,
              bottom: 50,
              child: Container(
                height: 40,
                width: 40,
                decoration:  BoxDecoration(
                    color: AppColor.primaryColor,
                    shape: BoxShape.circle
                ),
              )),
          Positioned(
              right: -7,
              bottom: 50,
              child: Container(
                height: 40,
                width: 40,
                decoration:  BoxDecoration(
                    color: AppColor.red,
                    shape: BoxShape.circle
                ),
              )),
        ],
      ),
    );
  }
}

