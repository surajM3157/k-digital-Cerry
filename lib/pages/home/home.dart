import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../constants/colors.dart';
import '../../constants/font_family.dart';
import '../../constants/images.dart';
import '../../route/route_names.dart';
import '../../widgets/app_themes.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {



  final List<String> sponsorItems = <String>[
    Images.sponsor1,
    Images.sponsor2,
    Images.sponsor3,
    Images.sponsor1,
    Images.sponsor2,
    Images.sponsor3,
  ];

  final List<String> liveEventItems = <String>[
    Images.liveEvent1,
    Images.liveEvent2,
    Images.liveEvent3,
    Images.liveEvent1,
    Images.liveEvent2,
    Images.liveEvent3,
  ];



  final List<String> sponsorNames = <String>[
    "Innovate Cap",
    "GlobalTech Solutions",
    "FutureVision Inc.",
    "Innovate Cap",
    "GlobalTech Solutions",
    "FutureVision Inc.",
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              width: Get.width,
              height: 250,
              child: Image.asset(Images.homeBanner,fit: BoxFit.cover,)),
          Container(
            height: 140,
            padding: EdgeInsets.all(10),
            width: Get.width,
            color: AppColor.secondaryColor.withOpacity(0.2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Global Connect Conference Session",style: AppThemes.titleTextStyle().copyWith(fontWeight: FontWeight.w500),),
                SizedBox(height: 7,),
                viewDetailsButton()
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text("Sponsor",style: AppThemes.titleTextStyle(),),
          ),
          SizedBox(height: 10,),
          sponsorList(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text("Speaker",style: AppThemes.titleTextStyle(),),
          ),
          SizedBox(height: 10,),
          speakerList(),
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text("About PAN IIT Alumni India",style: AppThemes.titleTextStyle(),),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text("PAN IIT Alumni India is a distinguished network that unites the graduates of all Indian Institutes of Technology (IITs) across the globe. Our mission is to foster a strong, collaborative community that drives innovation, leadership, and social impact. With a legacy of excellence in education and a commitment to shaping the future, PAN IIT Alumni India connects over a million IITians, creating opportunities for knowledge sharing, professional growth, and meaningful contributions to society.",style: AppThemes.subtitleTextStyle(),),
          ),
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text("Live Events",style: AppThemes.titleTextStyle(),),
          ),
          SizedBox(height: 10,),
          liveEventList(),
          SizedBox(height: 20,),
          Container(
            width: Get.width,
            height: 210,
            decoration: BoxDecoration(
              color: AppColor.secondaryColor
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SvgPicture.asset(Images.feedback),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("We value your",style: AppThemes.titleTextStyle().copyWith(fontWeight: FontWeight.w500),),
                      Text("Feedback!",style: AppThemes.titleTextStyle().copyWith(fontWeight: FontWeight.w500)),
                      Text("We'd love to hear about",style: AppThemes.subtitleTextStyle()),
                      Text("your recent experience",style: AppThemes.subtitleTextStyle()),
                      Text("with our services",style: AppThemes.subtitleTextStyle()),
                      SizedBox(height: 10,),
                      surveyButton()
                    ],
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 50,),
        ],
      ),
    );
  }

  Widget liveEventList(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SizedBox(
        height: 160,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
            itemBuilder: (context,index){
          return InkWell(
              onTap: (){
                Get.toNamed(Routes.liveSession);
              },
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    height: 190,width: 207,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        child: Image.asset(liveEventItems[index],height: 220,width: 220,fit: BoxFit.fill,)),
                  ),
                  Container(
                    height: 45,
                    width:207,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30)
                      ),
                      color: AppColor.primaryColor
                    ),
                    child: Center(
                      child: Text("Tech Innovator",style: TextStyle(fontSize: 16,fontFamily: appFontFamilyHeadings,
                        fontWeight: FontWeight.w500,color: AppColor.white
                      ),),
                    ),
                  )
                ],
              ));
        }, separatorBuilder: (BuildContext context, int index){
          return SizedBox(
            width: 10,
          );
        }, itemCount: liveEventItems.length),
      ),
    );
  }


  Widget sponsorList(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SizedBox(
        height: 160,
        child: ListView.separated(
          padding: EdgeInsets.zero,
          itemCount: sponsorItems.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context,index){
            return Column(
              children: [
                Image.asset(sponsorItems[index],height: 100,width: 100,),
                SizedBox(height: 7,),
                SizedBox(
                    width:80,
                    child: Text(sponsorNames[index],textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.w400,fontSize: 12,fontFamily: appFontFamilyBody,color: AppColor.primaryColor),
                    ))
              ],
            );
          }, separatorBuilder: (BuildContext context, int index) { return SizedBox(width: 10,); },),
      ),
    );
  }

  Widget speakerList(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SizedBox(
        height: 200,
        child: ListView.separated(
          padding: EdgeInsets.zero,
          itemCount: 3,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context,index){
            return Container(
              height: 150,
              width: 173,
              decoration: BoxDecoration(
                  color: AppColor.secondaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(15))
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                      child: Image.asset(index ==0?Images.speaker1:index ==1?Images.speaker2:Images.speaker3,height: 80,width: 80,fit: BoxFit.fill,)),
                  SizedBox(height: 5,),
                  Text(index==0?"Sophia thompson":index==1?"David Kim":"Dr. Rob Carter",style: TextStyle(fontFamily: appFontFamilyHeadings,color: AppColor.primaryColor,fontSize: 16,fontWeight: FontWeight.w500),),SizedBox(height: 5,),
                  Text(index==1?"VP of Engineering":"CEO",style: TextStyle(fontFamily: appFontFamilyBody,color: AppColor.black,fontSize: 12,fontWeight: FontWeight.w500),),
                  Text(index==1?"Elevate Industries":"InnovateCorp",style: TextStyle(fontFamily: appFontFamilyBody,color: AppColor.black,fontSize: 12,fontWeight: FontWeight.w500),),
                ],
              ),
            );
          }, separatorBuilder: (BuildContext context, int index) { return SizedBox(width: 10,); },),
      ),
    );
  }

  Widget viewDetailsButton(){
    return InkWell(
      onTap: (){
        Get.toNamed(Routes.eventDetails);
      },
      child: Container(
        height: 45,
        width: 127,
        decoration: BoxDecoration(
            color: AppColor.primaryColor,
            borderRadius: BorderRadius.all(Radius.circular(8))
        ),
        child: Center(child: Text("View Details",style: AppThemes.titleTextStyle().copyWith(color: AppColor.white,fontSize: 17),)),
      ),
    );
  }

  Widget surveyButton(){
    return InkWell(
      onTap: (){
        Get.toNamed(Routes.survey);
      },
      child: Container(
        height: 45,
        width: 150,
        decoration: BoxDecoration(
            color: AppColor.primaryColor,
            borderRadius: BorderRadius.all(Radius.circular(8))
        ),
        child: Center(child: Text("Take the Survey",style: AppThemes.titleTextStyle().copyWith(color: AppColor.white,fontSize: 17),)),
      ),
    );
  }
}
