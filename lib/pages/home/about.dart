import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:piwotapp/constants/api_urls.dart';
import 'package:piwotapp/constants/colors.dart';
import 'package:piwotapp/constants/font_family.dart';
import 'package:piwotapp/responses/about_us_response.dart';
import 'package:piwotapp/widgets/app_themes.dart';
import 'package:piwotapp/widgets/gradient_text.dart';
import '../../constants/images.dart';
import '../../repository/api_repo.dart';
import '../../widgets/custom_tabbar_indicator.dart';

class About extends StatefulWidget {
   About({super.key,required this.tabController});

  TabController tabController;

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> with SingleTickerProviderStateMixin{

  AboutUsData? aboutUsData;
  bool isConnected = true;
  TabController? _controller;

  fetchAboutUs() async
  {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      isConnected = false;
      setState(() {

      });
    }else{
    Future.delayed(Duration.zero, () {
      showLoader(context);
    });
     var response = await ApiRepo().getAboutUsResponse();

      if( response.data != null)
      {
        aboutUsData = response.data![0];
      }

      setState(() {

      });

    }

  }

  @override
  void initState() {
    _controller =  TabController(length: 2, vsync: this);
    fetchAboutUs();
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        isConnected = false;
      } else {
        // Handle case when internet connection is available
        isConnected = true;
        fetchAboutUs();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isConnected? Column(
      children: [
        const SizedBox(height: 10),
        TabBar(
          controller: _controller,
          indicatorSize: TabBarIndicatorSize.label,
          labelPadding: const EdgeInsets.symmetric(horizontal: 25),
          indicatorColor: AppColor.primaryColor,
          indicator: CustomUnderlineTabIndicator(
            borderSide: BorderSide(width: 3.0, color: AppColor.primaryColor),
            insets:const EdgeInsets.symmetric(vertical: -8),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12.0),
              topRight: Radius.circular(12.0),
            ),
          ),
          tabs: [
            Padding(
              padding: const EdgeInsets.only(bottom: 17),
              child: Text("About Event", style: AppThemes.labelTextStyle().copyWith(color: AppColor.primaryColor)),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 17),
              child: Text("About Us", style: AppThemes.labelTextStyle().copyWith(color: AppColor.primaryColor)),
            ),
          ],
        ),
        Container(
          height: 1,
          margin: EdgeInsets.only(top: 1),
          width: double.infinity,
          color: AppColor.lightGrey,
        ),
        Expanded(
          child: TabBarView(
            controller: _controller,
            children: [
              RefreshIndicator(
                onRefresh: () async {
                  fetchAboutUs();
                },
                color: AppColor.primaryColor,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 26),
                      GradientText(
                        text: "About Event",
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, fontFamily: appFontFamily),
                        gradient: LinearGradient(colors: [AppColor.primaryColor, AppColor.red]),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        aboutUsData?.aboutEvent ?? "",
                        style: TextStyle(fontFamily: appFontFamily, fontWeight: FontWeight.w400, fontSize: 14, color: AppColor.FF161616),
                      ),
                      const SizedBox(height: 26),
                      GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        crossAxisCount: 2,
                        children: [
                          cardWidget(title: "2 Days\nConference", image: Images.conferenceIcon),
                          cardWidget(title: "200+\nSpeakers", image: Images.aboutSpeakersIcon),
                          cardWidget(title: "3000+\nAttendees", image: Images.attendeesIcon),
                          cardWidget(title: "Firesides", image: Images.firesidesIcon),
                          cardWidget(title: "Startup Conclave", image: Images.startupConclaveIcon),
                          cardWidget(title: "250+ Startup", image: Images.startupIcon),
                          cardWidget(title: "100+ Investors", image: Images.investorsIcon),
                          cardWidget(title: "10,000+\nParticipants\nHackathon", image: Images.hackathonIcon),
                          cardWidget(title: "Exhibitions", image: Images.exhibitorsIcon),
                          cardWidget(title: "IIT\nRepresentatives", image: Images.representativeIcon),
                          // Add more cards as needed
                        ],
                      ),
                      const SizedBox(height: 30),
                      Center(
                        child: GradientText(
                          text: "Summit Organising Team",
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, fontFamily: appFontFamily),
                          gradient: LinearGradient(colors: [AppColor.primaryColor, AppColor.red]),
                        ),
                      ),
                      const SizedBox(height: 15),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10.0,
                          mainAxisSpacing: 10.0,
                        ),
                        itemBuilder: (context, index) {
                          return aboutCard(
                            title: aboutUsData?.organisingTeam?[index].organiserName ?? "",
                            image: aboutUsData?.organisingTeam?[index].organiserImage != null
                                ? Image.network(ApiUrls.imageUrl + (aboutUsData?.organisingTeam?[index].organiserImage ?? ""), fit: BoxFit.fill)
                                : Image.asset(Images.defaultProfile, fit: BoxFit.fill),
                            subtitle: aboutUsData?.organisingTeam?[index].designation ?? "",
                          );
                        },
                        itemCount: aboutUsData?.organisingTeam?.length ?? 0,
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
              RefreshIndicator(
                onRefresh: () async {
                  fetchAboutUs();
                },
                color: AppColor.primaryColor,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 26),
                      Center(
                        child: GradientText(
                          text: "About PANIIT",
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, fontFamily: appFontFamily),
                          gradient: LinearGradient(colors: [AppColor.primaryColor, AppColor.red]),
                        ),
                      ),
                      const SizedBox(height: 11),
                      SizedBox(
                        height: 175,
                        width: double.infinity,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: aboutUsData?.logo != null
                              ? Image.network(ApiUrls.imageUrl + (aboutUsData?.logo ?? ""), fit: BoxFit.fill)
                              : Image.asset(Images.aboutBanner, fit: BoxFit.fill),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        aboutUsData?.aboutPanIit ?? "",
                        style: TextStyle(fontFamily: appFontFamily, fontWeight: FontWeight.w400, fontSize: 14, color: AppColor.FF161616),
                      ),
                      const SizedBox(height: 30),
                      Center(
                        child: GradientText(
                          text: "Office Bearers",
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, fontFamily: appFontFamily),
                          gradient: LinearGradient(colors: [AppColor.primaryColor, AppColor.red]),
                        ),
                      ),
                      const SizedBox(height: 15),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10.0,
                          mainAxisSpacing: 10.0,
                        ),
                        itemBuilder: (context, index) {
                          return aboutCard(
                            title: aboutUsData?.officialBearers?[index].bearerName ?? "",
                            image: aboutUsData?.officialBearers?[index].bearerImage != null
                                ? Image.network(ApiUrls.imageUrl + (aboutUsData?.officialBearers?[index].bearerImage ?? ""), fit: BoxFit.fill)
                                : Image.asset(Images.defaultProfile, fit: BoxFit.fill),
                            subtitle: aboutUsData?.officialBearers?[index].designation ?? "",
                          );
                        },
                        itemCount: aboutUsData?.officialBearers?.length ?? 0,
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    )
        :const Center(child: Text("OOPS! NO INTERNET.",style: TextStyle(color: Colors.black87,fontWeight: FontWeight.w600,fontFamily: appFontFamily,fontSize: 20),));
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
