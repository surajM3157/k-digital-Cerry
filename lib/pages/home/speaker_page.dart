import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../constants/colors.dart';
import '../../constants/font_family.dart';
import '../../constants/images.dart';
import '../../widgets/gradient_text.dart';

class SpeakerPage extends StatefulWidget {
  const SpeakerPage({super.key});

  @override
  State<SpeakerPage> createState() => _SpeakerPageState();
}

class _SpeakerPageState extends State<SpeakerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: GradientText(text: "Paniit - 2024 SPEAKERS ", style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,fontFamily: appFontFamily), gradient: LinearGradient(
                colors: [AppColor.primaryColor, AppColor.red],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              )),
            ),
            SizedBox(height: 10,),
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  width: Get.width,
                  height: 325,
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    gradient: LinearGradient(
                      colors: [AppColor.primaryColor, AppColor.red],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    )
                  ),
                  child: Image.asset(Images.speaker4),
                ),
                Container(
                  height: 89,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  width: Get.width,
                  decoration: BoxDecoration(
                    color: AppColor.black.withOpacity(0.85),
                    borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Shri Narendra Modi",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: AppColor.white,fontFamily: appFontFamily),),
                        Text("Honourable Prime Minister of India Government of India",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,color: AppColor.white,fontFamily: appFontFamily),),
                      ],
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 20,),
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  width: Get.width,
                  height: 325,
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    gradient: LinearGradient(
                      colors: [AppColor.primaryColor, AppColor.red],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    )
                  ),
                  child: Image.asset(Images.speaker5),
                ),
                Container(
                  height: 89,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  width: Get.width,
                  decoration: BoxDecoration(
                    color: AppColor.black.withOpacity(0.85),
                    borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Shri Ashwini Vaishnaw",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: AppColor.white,fontFamily: appFontFamily),),
                        Text("Honourable Minister of Electronics Government of India",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,color: AppColor.white,fontFamily: appFontFamily),),
                      ],
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 20,),
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  width: Get.width,
                  height: 325,
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    gradient: LinearGradient(
                      colors: [AppColor.primaryColor, AppColor.red],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    )
                  ),
                  child: Image.asset(Images.speaker6),
                ),
                Container(
                  height: 89,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  width: Get.width,
                  decoration: BoxDecoration(
                    color: AppColor.black.withOpacity(0.85),
                    borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Shri Dinesh Kumar Khara",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: AppColor.white,fontFamily: appFontFamily),),
                        Text("Chairperson State Bank of India",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,color: AppColor.white,fontFamily: appFontFamily),),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
