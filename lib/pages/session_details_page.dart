import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../constants/colors.dart';
import '../constants/images.dart';
import '../widgets/app_themes.dart';
import '../widgets/gradient_text.dart';

class SessionDetailsPage extends StatefulWidget {
   SessionDetailsPage({super.key,this.title,this.image});
  String? title;
  String? image;

  @override
  State<SessionDetailsPage> createState() => _SessionDetailsPageState();
}

class _SessionDetailsPageState extends State<SessionDetailsPage> {


  @override
  void initState() {
    // Get.arguments['sessionModel'] =
    super.initState();
  }

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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              SizedBox(
                  width: Get.width,
                  height: 390,

                  child: Image.asset(widget.image??"",fit: BoxFit.cover,)),
              Container(
                margin: const EdgeInsets.only(top: 350),
                decoration: BoxDecoration(
                  color: AppColor.white,
                  borderRadius: const BorderRadius.only(topRight: Radius.circular(25),topLeft: Radius.circular(25))
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20,),
                          Text(widget.title??"",style: AppThemes.titleTextStyle().copyWith(
                              fontWeight: FontWeight.w600,fontSize: 24
                          ),),
                          const SizedBox(height: 20,),
                          Text("Bridging Innovation and Collaboration Worldwide. Connecting Minds, Shaping the Future.",style:AppThemes.subtitleTextStyle().copyWith(fontSize: 16)),
                          const SizedBox(height: 20,),
                          Row(
                            children: [
                              Icon(Icons.date_range,size: 17,color: AppColor.primaryColor,),
                              const SizedBox(width: 5,),
                              GradientText(text:"Date & Time",style: AppThemes.labelTextStyle().copyWith(color: AppColor.primaryColor,fontWeight: FontWeight.w600),gradient:LinearGradient(
                                colors: [AppColor.primaryColor, AppColor.red],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              )),
                            ],
                          ),
                          const SizedBox(height: 10,),
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Text("22 September 2024 , Tuesday",style: AppThemes.subtitleTextStyle(),),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Text("10:00 am to 12:00 am",style: AppThemes.subtitleTextStyle(),),
                          ),

                        ],
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Container(width: Get.width,
                      height: 1,color: AppColor.primaryColor,
                    ),
                    const SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.location_on_outlined,size: 17,color: AppColor.primaryColor,),
                              const SizedBox(width: 5,),
                              GradientText(text:"Location",style: AppThemes.labelTextStyle().copyWith(color: AppColor.primaryColor,fontWeight: FontWeight.w600),gradient:LinearGradient(
                                colors: [AppColor.primaryColor, AppColor.red],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              )),
                            ],
                          ),
                          const SizedBox(height: 10,),
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Text("Indian Institute of Technology Delhi, Hauz Khas, Delhi 110016.",style: AppThemes.subtitleTextStyle(),),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Container(width: Get.width,
                      height: 1,color: AppColor.primaryColor,
                    ),
                    const SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.currency_rupee,size: 17,color: AppColor.primaryColor,),
                              const SizedBox(width: 5,),
                              GradientText(text:"Ticket Price",style: AppThemes.labelTextStyle().copyWith(color: AppColor.primaryColor,fontWeight: FontWeight.w600),gradient:LinearGradient(
                                colors: [AppColor.primaryColor, AppColor.red],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              )),
                            ],
                          ),
                          const SizedBox(height: 10,),
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Text("3000/- per ticket",style: AppThemes.subtitleTextStyle(),),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Container(width: Get.width,
                      height: 1,color: AppColor.primaryColor,
                    ),
                    const SizedBox(height: 20,),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
