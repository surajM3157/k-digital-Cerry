import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:piwotapp/pages/home/sponsor_page.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../constants/colors.dart';
import '../../constants/font_family.dart';
import '../../constants/images.dart';
import '../../route/route_names.dart';
import '../../widgets/app_themes.dart';
import '../../widgets/gradient_text.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {



  final List<SponsorModel> sponsorItems = [
    SponsorModel("Innovate Cap", Images.sponsor1),
    SponsorModel("GlobalTech Solutions", Images.sponsor2),
    SponsorModel("FutureVision Inc.", Images.sponsor3),
  ];

  final PageController _pageController = PageController();

  final List<String> liveEventItems = <String>[
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
          SizedBox(height: 20,),
         bannerCarousel(),
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: GradientText(text: "Sponsor",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,fontFamily: appFontFamily), gradient: LinearGradient(
              colors: [AppColor.primaryColor, AppColor.red],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),),
          ),
          SizedBox(height: 10,),
          sponsorList(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: GradientText(text: "Speaker",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,fontFamily: appFontFamily), gradient: LinearGradient(
              colors: [AppColor.primaryColor, AppColor.red],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),),
          ),
          SizedBox(height: 10,),
          speakerList(),
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: GradientText(text: "About PAN IIT Alumni India",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,fontFamily: appFontFamily), gradient: LinearGradient(
              colors: [AppColor.primaryColor, AppColor.red],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: buildBulletPoint(Text("PAN IIT Alumni India is a distinguished network that unites the graduates of all Indian Institutes of Technology (IITs) across the globe.", style: AppThemes.subtitleTextStyle())),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: buildBulletPoint(Text(" Our mission is to foster a strong, collaborative community that drives innovation, leadership, and social impact.", style: AppThemes.subtitleTextStyle())),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: buildBulletPoint(Text("With a legacy of excellence in education and a commitment to shaping the future, PAN IIT Alumni India connects over a million IITians, creating opportunities for knowledge sharing, professional growth, and meaningful contributions to society.", style: AppThemes.subtitleTextStyle())),
          ),
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: GradientText(text: "Live Events",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,fontFamily: appFontFamily), gradient: LinearGradient(
              colors: [AppColor.primaryColor, AppColor.red],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),),
          ),
          SizedBox(height: 10,),
          liveEventList(),
          Container(
            width: Get.width,
            margin: EdgeInsets.all(10),
            height: 210,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: AppColor.FF3A2E88.withOpacity(0.15)
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
                      Text("We value your",style: AppThemes.titleTextStyle().copyWith(fontWeight: FontWeight.w600),),
                      Text("Feedback!",style: AppThemes.titleTextStyle().copyWith(fontWeight: FontWeight.w600)),
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
        ],
      ),
    );
  }

  Widget banner(){
    return Container(
      width: Get.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColor.primaryColor, AppColor.red],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child:Column(
        children: [
          SizedBox(height: 10,),
          SvgPicture.asset(Images.logo,height: 44,width: 126,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(Images.speakerHome,height: 200,width: 130,fit: BoxFit.fitHeight,),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("NETWORKING",style: TextStyle(fontSize: 30,fontWeight: FontWeight.w400,color: AppColor.white,fontFamily: appFontFamily),),
                  Text("DINNER",style: TextStyle(fontSize: 30,fontWeight: FontWeight.w400,color: AppColor.white,fontFamily: appFontFamily),),
                  Container(
                    width: 183,
                    height: 2,
                    color: AppColor.red,
                  ),
                  SizedBox(height: 10,),
                  Text("17 January 2025",style: AppThemes.subtitle1TextStyle().copyWith(color:AppColor.white),),
                  SizedBox(height: 10,),
                  InkWell(
                    onTap: (){
                      Get.toNamed(Routes.eventDetails);
                    },
                    child: Container(
                      height: 32,
                      width: 117,
                      decoration: BoxDecoration(
                          color: AppColor.red,
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      child: Center(child: Text("View Details",style: TextStyle(fontFamily: appFontFamily,fontWeight: FontWeight.w600,fontSize: 14,color: AppColor.white),)),
                    ),
                  )
                ],
              )
            ],
          ),
        ],
      )
      ,);
  }

  // Indicator widget
  Widget buildIndicator() => SmoothPageIndicator(
    controller: _pageController,
    count: items.length,
    effect: WormEffect(
      dotWidth: 10,
      dotHeight: 10,
      activeDotColor: AppColor.primaryColor,
      dotColor: AppColor.primaryColor,
      paintStyle: PaintingStyle.stroke
    ),
  );

  int activeIndex =0;

  List<Widget> items = [
    Container(
      width: Get.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColor.primaryColor, AppColor.red],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child:Column(
        children: [
          SizedBox(height: 10,),
          SvgPicture.asset(Images.logo,height: 44,width: 126,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(Images.speakerHome,height: 200,width: 135,fit: BoxFit.fitHeight,),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("NETWORKING",style: TextStyle(fontSize: 34,fontWeight: FontWeight.w400,color: AppColor.white,fontFamily: appFontFamily),),
                  Text("DINNER",style: TextStyle(fontSize: 34,fontWeight: FontWeight.w400,color: AppColor.white,fontFamily: appFontFamily),),
                  Container(
                    width: 183,
                    height: 2,
                    color: AppColor.red,
                  ),
                  SizedBox(height: 10,),
                  Text("17 January 2025",style: AppThemes.subtitle1TextStyle().copyWith(color:AppColor.white),),
                  SizedBox(height: 10,),
                  InkWell(
                    onTap: (){
                      Get.toNamed(Routes.eventDetails);
                    },
                    child: Container(
                      height: 32,
                      width: 117,
                      decoration: BoxDecoration(
                          color: AppColor.red,
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      child: Center(child: Text("View Details",style: TextStyle(fontFamily: appFontFamily,fontWeight: FontWeight.w600,fontSize: 14,color: AppColor.white),)),
                    ),
                  )
                ],
              )
            ],
          ),
        ],
      )
      ,),
    Container(
      width: Get.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColor.primaryColor, AppColor.red],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child:Column(
        children: [
          SizedBox(height: 10,),
          SvgPicture.asset(Images.logo,height: 44,width: 126,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(Images.speakerHome,height: 200,width: 135,fit: BoxFit.fitHeight,),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("NETWORKING",style: TextStyle(fontSize: 34,fontWeight: FontWeight.w400,color: AppColor.white,fontFamily: appFontFamily),),
                  Text("DINNER",style: TextStyle(fontSize: 34,fontWeight: FontWeight.w400,color: AppColor.white,fontFamily: appFontFamily),),
                  Container(
                    width: 183,
                    height: 2,
                    color: AppColor.red,
                  ),
                  SizedBox(height: 10,),
                  Text("17 January 2025",style: AppThemes.subtitle1TextStyle().copyWith(color:AppColor.white),),
                  SizedBox(height: 10,),
                  InkWell(
                    onTap: (){
                      Get.toNamed(Routes.eventDetails);
                    },
                    child: Container(
                      height: 32,
                      width: 117,
                      decoration: BoxDecoration(
                          color: AppColor.red,
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      child: Center(child: Text("View Details",style: TextStyle(fontFamily: appFontFamily,fontWeight: FontWeight.w600,fontSize: 14,color: AppColor.white),)),
                    ),
                  )
                ],
              )
            ],
          ),
        ],
      )
      ,)
  ];

  Widget bannerCarousel(){
    return  Column(
      children: [
        SizedBox(
          height: 254,
          child: PageView.builder(
            controller: _pageController,
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
              itemBuilder: (context, index){
            return GestureDetector(
              onTap: (){
                activeIndex = index;
                setState(() {

                });
              },
                child: items[index]);
          }),
        ),
        SizedBox(height: 16),
        buildIndicator(),
      ],
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
                alignment: Alignment.bottomLeft,
                children: [
                  Container(
                    height: 205,width: 203,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        child: Image.asset(liveEventItems[index],height: 203,width: 204,fit: BoxFit.fill,)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(index==0?"Digital Product":index==1?"Innovation Nexus":"Tech Innovator",style: TextStyle(color: AppColor.white,fontSize: 20,fontWeight: FontWeight.w600,fontFamily: appFontFamily),),
                        Container(
                          height: 26,
                          width: 98,
                          decoration: BoxDecoration(
                            color: AppColor.red,
                            borderRadius: BorderRadius.all(Radius.circular(8))
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Event Details",style: TextStyle(fontFamily: appFontFamily,fontWeight: FontWeight.w400,fontSize: 10,color: AppColor.white),),
                              SizedBox(width: 2,),
                              SvgPicture.asset(Images.crossArrowIcon)
                            ],
                          ),
                        )
                      ],
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


  // Widget sponsorList(){
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 10),
  //     child: SizedBox(
  //       height: 160,
  //       child: ListView.separated(
  //         padding: EdgeInsets.zero,
  //         itemCount: sponsorItems.length,
  //         scrollDirection: Axis.horizontal,
  //         itemBuilder: (context,index){
  //           return Column(
  //             children: [
  //               Image.asset(sponsorItems[index],height: 100,width: 100,),
  //               SizedBox(height: 7,),
  //               SizedBox(
  //                   width:80,
  //                   child: Text(sponsorNames[index],textAlign: TextAlign.center,
  //                     style: TextStyle(fontWeight: FontWeight.w400,fontSize: 12,fontFamily: appFontFamily,color: AppColor.primaryColor),
  //                   ))
  //             ],
  //           );
  //         }, separatorBuilder: (BuildContext context, int index) { return SizedBox(width: 10,); },),
  //     ),
  //   );
  // }
  Widget sponsorList(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: CarouselSlider(
        options: CarouselOptions(height: 160,
          aspectRatio: 16/9,
          viewportFraction: 0.34,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 3),
          autoPlayAnimationDuration: Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: true,
          enlargeFactor: 0.03,
          scrollDirection: Axis.horizontal,),
        items: sponsorItems.map((item) {
          return Builder(
            builder: (BuildContext context) {
              return Column(
                children: [
                  Image.asset(item.image,height: 100,width: 100,),
                  SizedBox(height: 7,),
                  SizedBox(
                      width:80,
                      child: Text(item.title,textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.w400,fontSize: 12,fontFamily: appFontFamily,color: AppColor.primaryColor),
                      ))
                ],
              );
            },
          );
        }).toList(),
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
                  gradient: LinearGradient(
                colors: [AppColor.primaryColor, AppColor.red],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
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
                  Text(index==0?"Sophia thompson":index==1?"David Kim":"Dr. Rob Carter",style: TextStyle(fontFamily: appFontFamily,color: AppColor.white,fontSize: 16,fontWeight: FontWeight.w500),),SizedBox(height: 5,),
                  Text(index==1?"VP of Engineering":"CEO",style: TextStyle(fontFamily: appFontFamily,color: AppColor.white,fontSize: 12,fontWeight: FontWeight.w500),),
                  Text(index==1?"Elevate Industries":"InnovateCorp",style: TextStyle(fontFamily: appFontFamily,color: AppColor.white,fontSize: 12,fontWeight: FontWeight.w500),),
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
            gradient: LinearGradient(
              colors: [AppColor.primaryColor, AppColor.red],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.all(Radius.circular(8))
        ),
        child: Center(child: Text("Take the Survey",style: AppThemes.titleTextStyle().copyWith(color: AppColor.white,fontSize: 17),)),
      ),
    );
  }

  Widget buildBulletPoint(Widget text,) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("• ", style: TextStyle(fontSize: 20)),
        Expanded(child: text),
      ],
    );
  }
}

class SponsorModel{
  SponsorModel(this.title,this.image);

  String image;
  String title;
}