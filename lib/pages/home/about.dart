import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:piwotapp/constants/colors.dart';
import 'package:piwotapp/constants/font_family.dart';
import 'package:piwotapp/widgets/app_themes.dart';
import 'package:piwotapp/widgets/gradient_text.dart';
import '../../constants/images.dart';

class About extends StatefulWidget {
   About({super.key,required this.tabController});

  TabController tabController;

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
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
              AppThemes.buildBulletPoint(Text("Innovation drives prosperity, societal progress, and breakthroughs. Welcome to ‘PIWOT – World of Technology,’ led by PanIIT Alumni India and powered by global IIT alumni brilliance. Here, participants forge ideas, products, and services for global impact.",style: TextStyle(fontFamily: appFontFamily,fontWeight: FontWeight.w400,fontSize: 14,color: AppColor.FF161616),)),
              AppThemes.buildBulletPoint(Text("In an era of relentless evolution, we stand as torchbearers, fostering the invaluable art of innovation—a vital skill for businesses, governments, and individuals.",style: TextStyle(fontFamily: appFontFamily,fontWeight: FontWeight.w400,fontSize: 14,color: AppColor.FF161616))),
              AppThemes.buildBulletPoint(Text("At PIWOT, we unite global leaders to advance tech innovation, promote sustainability, champion social progress, and foster cultural and ethical excellence.",style: TextStyle(fontFamily: appFontFamily,fontWeight: FontWeight.w400,fontSize: 14,color: AppColor.FF161616))),
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
              Center(child: GradientText(text: "About PANIIT", style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w600,fontFamily: appFontFamily), gradient: LinearGradient(colors: [AppColor.primaryColor,AppColor.red]))),
              const SizedBox(height: 11,),
              SizedBox(
                height: 175,width: Get.width,

                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                      child: Image.asset(Images.aboutBanner,fit: BoxFit.fill,)),),
              const SizedBox(height: 16,),
              AppThemes.buildBulletPoint(Text('PanIIT is a body of alumni, formed to give back to society and the nation; it is a global community of over 400,000 alumni from all the IITs. It aims to empower the IIT alumni community to drive positive change and transformation in society through innovation.',style: TextStyle(fontSize: 14,fontFamily: appFontFamily,fontWeight: FontWeight.w400,color: AppColor.FF161616),)),
              AppThemes.buildBulletPoint(Text('Social impact initiatives by PanIIT paint a large canvas and have become strong movements. Each alumni body has an impact area and a role to play and complements others. Meet them at PIWOT 2025, and join our efforts to contribute to society.',style: TextStyle(fontSize: 14,fontFamily: appFontFamily,fontWeight: FontWeight.w400,color: AppColor.FF161616),)),
              const SizedBox(height: 32,),
              Center(child: GradientText(text: "Office Bearers", style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w600,fontFamily: appFontFamily), gradient: LinearGradient(colors: [AppColor.primaryColor,AppColor.red]))),
              const SizedBox(height: 15,),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 2,children: [
                aboutCard(title: "Debashish\nBhattacharyya",image: Images.officeBearer1,subtitle: "Chairman"),
                aboutCard(title: "Anurag Goel", image:Images.officeBearer2,subtitle:"Vice Chairman" ),
                aboutCard(title: "Dr. Geetanjali\nKaushik",image: Images.officeBearer3,subtitle:"Treasurer" ),
                aboutCard(title: "Ashok Kumar",image: Images.officeBearer4,subtitle: "General Secretary"),
              ],),
              const SizedBox(height: 30,),
              Center(child: GradientText(text: "Summit Organising Team", style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w600,fontFamily: appFontFamily), gradient: LinearGradient(colors: [AppColor.primaryColor,AppColor.red]))),
              const SizedBox(height: 15,),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 2,children: [
                aboutCard(title: "Dr SHARAD SARAF",image: Images.organiser1,subtitle: "Summit Chair"),
                aboutCard(title: "Debashish\nBhattacharyya", image:Images.organiser2,subtitle:"Summit Chair" ),
                aboutCard(title: "Raj Nair",image: Images.organiser3,subtitle:"Summit Co – Chair" ),
                aboutCard(title: "Narinder Madan",image: Images.organiser4,subtitle: "Convenor, Hospitality"),

                aboutCard(title: "Advait Kurlekar",image: Images.organiser5,subtitle: "Convenor, Program"),
                aboutCard(title: "Pradeep Bhargava", image:Images.organiser6,subtitle:"Convenor, Startups &\nHackathon" ),
                aboutCard(title: "Sunil Khanna",image: Images.organiser7,subtitle:"Convenor, Sponsorship" ),
                aboutCard(title: "Gagan Singla",image: Images.organiser8,subtitle: "Convenor, Marketing"),
              ],),
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

  Widget aboutCard({required String title, required String image, required String subtitle}){
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
                  child: Image.asset(image,fit:BoxFit.fill,))),
          const SizedBox(height: 5,),
          Text(title,style: AppThemes.aboutCardTitleTextStyle(),textAlign: TextAlign.center,),
          const SizedBox(height: 5,),
          Text(subtitle,style: AppThemes.aboutCardSubtitleTextStyle(),textAlign: TextAlign.center,),
        ],
      ),
    );
  }

}
