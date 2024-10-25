import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:piwotapp/constants/api_urls.dart';
import 'package:piwotapp/constants/colors.dart';
import 'package:piwotapp/constants/font_family.dart';
import 'package:piwotapp/responses/about_us_response.dart';
import 'package:piwotapp/widgets/app_themes.dart';
import 'package:piwotapp/widgets/gradient_text.dart';
import '../../constants/images.dart';
import '../../repository/api_repo.dart';

class About extends StatefulWidget {
   About({super.key,required this.tabController});

  TabController tabController;

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {

  AboutUsData? aboutUsData;

  fetchAboutUs() async
  {
    Future.delayed(Duration.zero, () {
      showLoader(context);
    });

    try{
      var response = await ApiRepo().getAboutUsResponse();

      if( response.data != null)
      {
        aboutUsData = response.data![0];
      }

      setState(() {

      });

    }
    catch(e){}


    setState(() {});
  }

  @override
  void initState() {
    fetchAboutUs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TabBarView(
        controller: widget.tabController,
        children: [
          ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              const SizedBox(height: 26,),
              GradientText(text: "About Event", style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w600,fontFamily: appFontFamily), gradient: LinearGradient(colors: [AppColor.primaryColor,AppColor.red])),
              const SizedBox(height: 12,),
              Text(aboutUsData?.aboutEvent??"",style: TextStyle(fontFamily: appFontFamily,fontWeight: FontWeight.w400,fontSize: 14,color: AppColor.FF161616)),
              const SizedBox(height: 26,),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 2,children: [
                  cardWidget(title: "2 Day\nConference",image: Images.conferenceIcon),
                  cardWidget(title: "200+\nSpeakers", image:Images.aboutSpeakersIcon),
                  cardWidget(title: "3000+\nAttendees",image: Images.attendeesIcon),
                  cardWidget(title: "Firesides",image: Images.firesidesIcon),
                  cardWidget(title: "Startup\nConclave",image: Images.startupConclaveIcon),
                  cardWidget(title: "250+ Startups",image: Images.startupIcon),
                  cardWidget(title: "100+ Investors",image: Images.investorsIcon),
                  cardWidget(title: "10,000+\nParticipants\nHackathon",image: Images.hackathonIcon),
                  cardWidget(title: "Exhibitions",image: Images.exhibitorsIcon),
                  cardWidget(title: "IIT\nRepresentatives",image: Images.representativeIcon),
              ],),
              const SizedBox(height: 20,)
            ],
          ),
          ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              const SizedBox(height: 26,),
              Center(child: GradientText(text:"About PANIIT" , style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w600,fontFamily: appFontFamily), gradient: LinearGradient(colors: [AppColor.primaryColor,AppColor.red]))),
              const SizedBox(height: 11,),
              SizedBox(
                height: 175,width: Get.width,

                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                      child: aboutUsData?.logo != null?Image.network(ApiUrls.imageUrl+(aboutUsData?.logo??""),fit: BoxFit.fill,):Image.asset(Images.aboutBanner,fit: BoxFit.fill,)),),
              const SizedBox(height: 16,),
              Text(aboutUsData?.aboutPanIit??"",style: TextStyle(fontFamily: appFontFamily,fontWeight: FontWeight.w400,fontSize: 14,color: AppColor.FF161616)),
              Center(child: GradientText(text: "Office Bearers", style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w600,fontFamily: appFontFamily), gradient: LinearGradient(colors: [AppColor.primaryColor,AppColor.red]))),
              const SizedBox(height: 15,),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Number of items per row
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
              ),
                itemBuilder: (context,index){
                  return  aboutCard(title: aboutUsData?.officialBearers?[index].bearerName??"",image: aboutUsData?.officialBearers?[index].bearerImage!=null? Image.network(ApiUrls.imageUrl + (aboutUsData?.officialBearers?[index].bearerImage??""),fit: BoxFit.fill,):Image.asset(Images.defaultProfile,fit: BoxFit.fill,),subtitle: aboutUsData?.officialBearers?[index].designation??"");

                },itemCount: aboutUsData?.officialBearers?.length,
                ),
              const SizedBox(height: 30,),
              Center(child: GradientText(text: "Summit Organising Team", style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w600,fontFamily: appFontFamily), gradient: LinearGradient(colors: [AppColor.primaryColor,AppColor.red]))),
              const SizedBox(height: 15,),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Number of items per row
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                ),
                itemBuilder: (context,index){
                  return  aboutCard(title: aboutUsData?.organisingTeam?[index].organiserName??"",image: aboutUsData?.organisingTeam?[index].organiserImage!=null? Image.network(ApiUrls.imageUrl + (aboutUsData?.organisingTeam?[index].organiserImage??""),fit: BoxFit.fill,):Image.asset(Images.defaultProfile,fit: BoxFit.fill,),subtitle: aboutUsData?.organisingTeam?[index].designation??"");

                },itemCount: aboutUsData?.organisingTeam?.length,
              ),
              const SizedBox(height: 40,)
            ],
          ),
        ]);
  }

  Widget cardWidget({required String title, required String image}){
    return  Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(colors: [AppColor.primaryColor,AppColor.red]),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(image,height: 70,width: 75,),
          const SizedBox(height: 15,),
          Text(title,style: AppThemes.aboutCardTitleTextStyle(),textAlign: TextAlign.center,),
        ],
      ),
    );
  }

  Widget aboutCard({required String title, required Image image, required String subtitle}){
    return  Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(colors: [AppColor.primaryColor,AppColor.red]),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 81,width: 81,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                  child: image)),
          const SizedBox(height: 5,),
          Text(title,style: AppThemes.aboutCardTitleTextStyle(),textAlign: TextAlign.center,),
          const SizedBox(height: 5,),
          Text(subtitle,style: AppThemes.aboutCardSubtitleTextStyle(),textAlign: TextAlign.center,),
        ],
      ),
    );
  }

}
