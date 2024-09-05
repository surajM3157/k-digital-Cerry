import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:piwotapp/constants/colors.dart';
import 'package:piwotapp/constants/images.dart';
import 'package:get/get.dart';
import 'package:piwotapp/pages/session_details_page.dart';
import 'package:piwotapp/screen_navigation.dart';
import 'package:piwotapp/widgets/app_themes.dart';

import '../../route/route_names.dart';


class Session extends StatefulWidget {
  const Session({super.key});

  @override
  State<Session> createState() => _SessionState();
}

class _SessionState extends State<Session> {
  
  
  List<SessionModel> sessions =[
    SessionModel(title: "AI and Machine Learning in Business", image: Images.sessionBanner1, date: "16 August 2024", time: "10:00 am to 12:00 am"),
    SessionModel(title: "Innovation in Action: Transforming Ideas to Reality", image: Images.sessionBanner2, date: "16 August 2024", time: "10:00 am to 12:00 am"),
    SessionModel(title: "Future Tech Trends - The Next Wave of Innovation", image: Images.sessionBanner3, date: "16 August 2024", time: "10:00 am to 12:00 am"),
  ];
  
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: sessions.length,
        itemBuilder: (context,index){
      return sessionItem(sessions[index]);
    });
  }


  Widget sessionItem(SessionModel session){
    return Stack(
      children: [
        Container(
          width: Get.width,
          height: 400,
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.only(bottom: 20,top: 200),
          decoration: BoxDecoration(
              color: AppColor.lightestGrey,
              borderRadius: BorderRadius.all(Radius.circular(20))
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 10,),
                Text(session.title,style: AppThemes.titleTextStyle().copyWith(
                    fontSize: 20,fontWeight: FontWeight.w500
                ),),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.date_range,size: 17,color: AppColor.primaryColor,),
                        SizedBox(width: 5,),
                        Text(session.date,style: AppThemes.labelTextStyle().copyWith(color: AppColor.black,fontWeight: FontWeight.w400),)
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.access_time_filled,size: 17,color: AppColor.primaryColor,),
                        SizedBox(width: 5,),
                        Text(session.time,style: AppThemes.labelTextStyle().copyWith(color: AppColor.black,fontWeight: FontWeight.w400),)
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    joinSessionButton(session)
                  ],
                )
              ],
            ),
          ),
        ),
        Container(
            width: Get.width,
            height: 200,
            margin: EdgeInsets.all(10),
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                child: Image.asset(session.image,fit: BoxFit.cover,))),
      ],
    );
  }

  Widget joinSessionButton(SessionModel sessionModel){
    return InkWell(
      onTap: (){
        Get.to(SessionDetailsPage(title: sessionModel.title,image: sessionModel.image,));
      },
      child: Container(
        height: 45,
        width: 150,
        decoration: BoxDecoration(
            color: AppColor.primaryColor,
            borderRadius: BorderRadius.all(Radius.circular(8))
        ),
        child: Center(child: Text("Join Session",style: AppThemes.titleTextStyle().copyWith(color: AppColor.white,fontSize: 17),)),
      ),
    );
  }
}

class SessionModel{
  String image;
  String title;
  String date;
  String time;
  SessionModel({required this.title,required this.image,required this.date,required this.time});
}