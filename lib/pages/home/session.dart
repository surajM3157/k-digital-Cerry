import 'package:flutter/material.dart';
import 'package:piwotapp/constants/colors.dart';
import 'package:piwotapp/constants/images.dart';
import 'package:get/get.dart';
import 'package:piwotapp/pages/session_details_page.dart';
import 'package:piwotapp/widgets/app_themes.dart';
import '../../constants/font_family.dart';
import '../../widgets/custom_tabbar_indicator.dart';


class Session extends StatefulWidget {
  const Session({super.key});

  @override
  State<Session> createState() => _SessionState();
}

class _SessionState extends State<Session> with SingleTickerProviderStateMixin{

  late TabController _tabController;
  List<SessionModel> sessions =[
    SessionModel(title: "Artificial Intelligence and Machine Learning in Business", image: Images.sessionBanner1, date: "16 August 2024", time: "10:00 am to 12:00 am"),
    SessionModel(title: "Innovation in Action: Transforming Ideas to Reality", image: Images.sessionBanner2, date: "16 August 2024", time: "10:00 am to 12:00 am"),
    SessionModel(title: "Future Tech Trends - The Next Wave of Innovation", image: Images.sessionBanner3, date: "16 August 2024", time: "10:00 am to 12:00 am"),
  ];

  List<String> items = [];

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [

            Container(
              height: 35,width: 99,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  gradient: LinearGradient(colors: [AppColor.primaryColor,AppColor.red],
                      begin: Alignment.centerLeft,end: Alignment.centerRight
                  )
              ),
              child: Center(
                child: Text("17 Jan",style: TextStyle(
                    fontFamily: appFontFamily,fontSize: 14,fontWeight: FontWeight.w600,color: AppColor.white
                ),),
              ),
            ),
            Container(
              height: 35,width: 99,
              padding: const EdgeInsets.all(1),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(9)),
                  gradient: LinearGradient(colors: [AppColor.primaryColor,AppColor.red],
                      begin: Alignment.centerLeft,end: Alignment.centerRight
                  )
              ),
              child: Container(
                height: 35,width: 99,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    color: AppColor.white
                ),
                child: Center(
                  child: Text("18 Jan",style: TextStyle(
                      fontFamily: appFontFamily,fontSize: 14,fontWeight: FontWeight.w600,color: AppColor.FF161616
                  ),),
                ),
              ),
            ),
            Container(
              height: 35,width: 99,
              padding: const EdgeInsets.all(1),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(9)),
                  gradient: LinearGradient(colors: [AppColor.primaryColor,AppColor.red],
                      begin: Alignment.centerLeft,end: Alignment.centerRight
                  )
              ),
              child: Container(
                height: 35,width: 99,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    color: AppColor.white
                ),
                child: Center(
                  child: Text("19 Jan",style: TextStyle(
                      fontFamily: appFontFamily,fontSize: 14,fontWeight: FontWeight.w600,color: AppColor.FF161616
                  ),),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20,),

        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 16),
        //   child: DropdownButtonFormField<String>(
        //     iconEnabledColor: AppColor.primaryColor,
        //     iconDisabledColor: AppColor.primaryColor,
        //     items: items.map<DropdownMenuItem<String>>((String value) {
        //       return DropdownMenuItem<String>(
        //         value: value,
        //         child: Text(value),
        //       );
        //     }).toList(),
        //     onChanged: (value) {},
        //     iconSize: 30,
        //     decoration: InputDecoration(
        //       hintText: "Topics",
        //       labelText: "Topics",
        //       fillColor: AppColor.FFD9D6FD.withOpacity(0.28),
        //       filled: true,
        //       labelStyle:  TextStyle(color: AppColor.primaryColor,fontFamily: appFontFamily,fontWeight:FontWeight.w400,fontSize: 16),
        //       hintStyle:  TextStyle(color: AppColor.primaryColor,fontFamily: appFontFamily,fontWeight:FontWeight.w400,fontSize: 16),
        //       contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        //       focusedBorder:  OutlineInputBorder(
        //           borderRadius: BorderRadius.circular(10.0),
        //           borderSide: BorderSide(color: AppColor.black.withOpacity(0.12))
        //       ),
        //       enabledBorder:  OutlineInputBorder(
        //           borderRadius: BorderRadius.circular(10.0),
        //           borderSide: BorderSide(color: AppColor.black.withOpacity(0.12))
        //       ),
        //       errorBorder: OutlineInputBorder(
        //         borderRadius: BorderRadius.circular(10.0),
        //         borderSide: const BorderSide(color: Colors.red, width: 2.0),
        //       ),
        //       focusedErrorBorder: OutlineInputBorder(
        //         borderRadius: BorderRadius.circular(10.0),
        //         borderSide: const BorderSide(color: Colors.red, width: 2.0),
        //       ),
        //     ),
        //   ),
        // ),
        TabBar(
          isScrollable: true,
          controller: _tabController,
          indicatorSize: TabBarIndicatorSize.label,
          labelPadding: const EdgeInsets.symmetric(horizontal: 25),
          indicatorColor: AppColor.primaryColor,

          indicator:CustomUnderlineTabIndicator(
            borderSide: BorderSide(width: 3.0, color: AppColor.primaryColor),
            insets:const EdgeInsets.symmetric(vertical: -8),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12.0),
              topRight: Radius.circular(12.0),
            ),
          ),
          tabs: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text("Conference",style: AppThemes.labelTextStyle().copyWith(color: AppColor.primaryColor),),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text("Hackathon",style: AppThemes.labelTextStyle().copyWith(color: AppColor.primaryColor)),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text("Startups",style: AppThemes.labelTextStyle().copyWith(color: AppColor.primaryColor)),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text("Firesides",style: AppThemes.labelTextStyle().copyWith(color: AppColor.primaryColor)),
            ),
          ],
        ),
        Container(height: 1,width: Get.width,color: AppColor.grey,),
        const SizedBox(height: 20,),
        Expanded(
          child: TabBarView(
            controller: _tabController,
              children: [
            ListView.builder(
                itemCount: sessions.length,
                itemBuilder: (context,index){
                  return sessionItem(sessions[index]);
                }),
            ListView.builder(
                itemCount: sessions.length,
                itemBuilder: (context,index){
                  return sessionItem(sessions[index]);
                }),
            ListView.builder(
                itemCount: sessions.length,
                itemBuilder: (context,index){
                  return sessionItem(sessions[index]);
                }),
            ListView.builder(
                itemCount: sessions.length,
                itemBuilder: (context,index){
                  return sessionItem(sessions[index]);
                }),
          ]),
        )
      ],
    );
  }


  Widget sessionItem(SessionModel session){
    return Stack(
      children: [
        Container(
          width: Get.width,
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.only(bottom: 20,top: 200),
          decoration: BoxDecoration(
              color: AppColor.lightestGrey,
              border: Border.all(color: AppColor.black.withOpacity(0.13)),
              borderRadius: const BorderRadius.all(Radius.circular(20))
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 10,),
                Text(session.title,style: AppThemes.titleTextStyle().copyWith(
                    fontSize: 20,fontWeight: FontWeight.w600
                ),),
                const SizedBox(height: 20,),
                Row(
                  children: [
                    Icon(Icons.date_range,size: 17,color: AppColor.primaryColor,),
                    const SizedBox(width: 5,),
                    Text(session.date,style: AppThemes.labelTextStyle().copyWith(color: AppColor.black,fontWeight: FontWeight.w400),)
                  ],
                ),
                const SizedBox(height: 20,),
                Row(
                  children: [
                    Icon(Icons.access_time_filled,size: 17,color: AppColor.primaryColor,),
                    const SizedBox(width: 5,),
                    Text(session.time,style: AppThemes.labelTextStyle().copyWith(color: AppColor.black,fontWeight: FontWeight.w400),)
                  ],
                ),
                const SizedBox(height: 20,),
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
            margin: const EdgeInsets.all(10),
            child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
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
        width: Get.width - 42,
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColor.primaryColor, AppColor.red],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(8))
        ),
        child: Center(child: Text("View Details",style: AppThemes.titleTextStyle().copyWith(color: AppColor.white,fontSize: 17),)),
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