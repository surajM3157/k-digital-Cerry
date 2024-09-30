import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:piwotapp/pages/home/home_page.dart';
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
         bannerCarousel(),
          const SizedBox(height: 16,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: GradientText(text: "Countdown For PIWOT Event 2025",style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w600,fontFamily: appFontFamily), gradient: LinearGradient(
              colors: [AppColor.primaryColor, AppColor.red],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),),
          ),
          const SizedBox(height: 16,),
          countdownWidget(),
          const SizedBox(height: 16,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: GradientText(text: "Explore",style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w600,fontFamily: appFontFamily), gradient: LinearGradient(
              colors: [AppColor.primaryColor, AppColor.red],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),),
          ),
          const SizedBox(height: 16,),
          exploreWidget(),
          const SizedBox(height: 16,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GradientText(text: "About Event",style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w600,fontFamily: appFontFamily), gradient: LinearGradient(
                  colors: [AppColor.primaryColor, AppColor.red],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),),
                InkWell(
                  onTap: (){
                    Get.offAll(HomePage(bottomNavIndex: 4));
                    print("to home page");
                  },
                  child: GradientText(text: "View More",style: const TextStyle(fontSize: 12,fontWeight: FontWeight.w600,fontFamily: appFontFamily), gradient: LinearGradient(
                    colors: [AppColor.primaryColor, AppColor.red],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16,),
          aboutEvent(),
          const SizedBox(height: 16,),
          Container(
            width: Get.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColor.primaryColor,AppColor.red]
              ),
            ),
            child: Column(
              children: [
                SizedBox(height: 23,),
                Text("PANIIT 2025 Highlights",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700,fontFamily: appFontFamily,color: AppColor.white),),
                SizedBox(height: 26,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height:71,width: 99,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color:Colors.transparent,
                          border: Border.all(color: AppColor.white)
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("2 Day",style: TextStyle(fontFamily: appFontFamily,fontWeight: FontWeight.w600,fontSize: 12,color: AppColor.white),),
                            Text("Conference",style: TextStyle(fontFamily: appFontFamily,fontWeight: FontWeight.w600,fontSize: 12,color: AppColor.white),),
                          ],
                        ),
                      ),
                      Container(
                        height:71,width: 99,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color:Colors.transparent,
                          border: Border.all(color: AppColor.white)
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("250+",style: TextStyle(fontFamily: appFontFamily,fontWeight: FontWeight.w600,fontSize: 12,color: AppColor.white),),
                            Text("Startups",style: TextStyle(fontFamily: appFontFamily,fontWeight: FontWeight.w600,fontSize: 12,color: AppColor.white),),
                          ],
                        ),
                      ),
                      Container(
                        height:71,width: 99,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color:Colors.transparent,
                          border: Border.all(color: AppColor.white)
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("10,000+",style: TextStyle(fontFamily: appFontFamily,fontWeight: FontWeight.w600,fontSize: 12,color: AppColor.white),),
                            Text("Hackathon",style: TextStyle(fontFamily: appFontFamily,fontWeight: FontWeight.w600,fontSize: 12,color: AppColor.white),),
                            Text("Participants",style: TextStyle(fontFamily: appFontFamily,fontWeight: FontWeight.w600,fontSize: 12,color: AppColor.white),),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height:71,width: 99,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color:Colors.transparent,
                            border: Border.all(color: AppColor.white)
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("23 IITs",style: TextStyle(fontFamily: appFontFamily,fontWeight: FontWeight.w600,fontSize: 12,color: AppColor.white),),
                            Text("Representation",style: TextStyle(fontFamily: appFontFamily,fontWeight: FontWeight.w600,fontSize: 12,color: AppColor.white),),
                          ],
                        ),
                      ),
                      Container(
                        height:71,width: 99,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color:Colors.transparent,
                            border: Border.all(color: AppColor.white)
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("3000+",style: TextStyle(fontFamily: appFontFamily,fontWeight: FontWeight.w600,fontSize: 12,color: AppColor.white),),
                            Text("Attendees",style: TextStyle(fontFamily: appFontFamily,fontWeight: FontWeight.w600,fontSize: 12,color: AppColor.white),),
                          ],
                        ),
                      ),
                      Container(
                        height:71,width: 99,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color:Colors.transparent,
                            border: Border.all(color: AppColor.white)
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("100+",style: TextStyle(fontFamily: appFontFamily,fontWeight: FontWeight.w600,fontSize: 12,color: AppColor.white),),
                            Text("Investors",style: TextStyle(fontFamily: appFontFamily,fontWeight: FontWeight.w600,fontSize: 12,color: AppColor.white),),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height:71,width: 99,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color:Colors.transparent,
                            border: Border.all(color: AppColor.white)
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("200+",style: TextStyle(fontFamily: appFontFamily,fontWeight: FontWeight.w600,fontSize: 12,color: AppColor.white),),
                            Text("Speakers",style: TextStyle(fontFamily: appFontFamily,fontWeight: FontWeight.w600,fontSize: 12,color: AppColor.white),),
                          ],
                        ),
                      ),
                      Container(
                        height:71,width: 99,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color:Colors.transparent,
                            border: Border.all(color: AppColor.white)
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("26",style: TextStyle(fontFamily: appFontFamily,fontWeight: FontWeight.w600,fontSize: 12,color: AppColor.white),),
                            Text("Finalist Team",style: TextStyle(fontFamily: appFontFamily,fontWeight: FontWeight.w600,fontSize: 12,color: AppColor.white),),
                          ],
                        ),
                      ),
                      Container(
                        height:71,width: 99,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color:Colors.transparent,
                            border: Border.all(color: AppColor.white)
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Demo Day,",style: TextStyle(fontFamily: appFontFamily,fontWeight: FontWeight.w600,fontSize: 12,color: AppColor.white),),
                            Text("Exhibition",style: TextStyle(fontFamily: appFontFamily,fontWeight: FontWeight.w600,fontSize: 12,color: AppColor.white),),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20,)
              ],
            ),
          ),
          const SizedBox(height: 16,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GradientText(text: "Speaker",style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w600,fontFamily: appFontFamily), gradient: LinearGradient(
                  colors: [AppColor.primaryColor, AppColor.red],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),),
                GestureDetector(
                  onTap: (){
                    Get.toNamed(Routes.speaker);
                  },
                  child: GradientText(text: "View More",style: const TextStyle(fontSize: 12,fontWeight: FontWeight.w600,fontFamily: appFontFamily), gradient: LinearGradient(
                    colors: [AppColor.primaryColor, AppColor.red],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16,),
          speakerList(),
          const SizedBox(height: 16,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GradientText(text: "Sponsor",style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w600,fontFamily: appFontFamily), gradient: LinearGradient(
                  colors: [AppColor.primaryColor, AppColor.red],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),),
                GestureDetector(
                  onTap: (){
                    Get.toNamed(Routes.sponsor);
                  },
                  child: GradientText(text: "View More",style: const TextStyle(fontSize: 12,fontWeight: FontWeight.w600,fontFamily: appFontFamily), gradient: LinearGradient(
                    colors: [AppColor.primaryColor, AppColor.red],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16,),
          sponsorList(),
          const SizedBox(height: 16,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: GradientText(text: "Live Events",style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w600,fontFamily: appFontFamily), gradient: LinearGradient(
              colors: [AppColor.primaryColor, AppColor.red],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),),
          ),
          const SizedBox(height: 16,),
          liveEventList(),
          Container(
            width: Get.width,
            margin: const EdgeInsets.all(16),
            height: 210,
            decoration: BoxDecoration(
              border: Border.all(color: AppColor.FFC7C7C7),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              color: AppColor.FFCBC7FF.withOpacity(0.15)
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SvgPicture.asset(Images.feedback),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 10,),
                      Text("We value your",style: AppThemes.titleTextStyle().copyWith(fontWeight: FontWeight.w600),),
                      Text("Feedback!",style: AppThemes.titleTextStyle().copyWith(fontWeight: FontWeight.w600)),
                      const SizedBox(height: 8,),
                      Text("We'd love to hear about",style: AppThemes.subtitleTextStyle()),
                      Text("your recent experience",style: AppThemes.subtitleTextStyle()),
                      Text("with our services",style: AppThemes.subtitleTextStyle()),
                      const SizedBox(height: 16,),
                      surveyButton(),
                      const SizedBox(height: 10,)
                    ],
                  )
                ],
              ),
            ),
          ),
          Container(
            width: Get.width,
            margin: EdgeInsets.all(16),
            height: 208,
            padding: EdgeInsets.only(left: 16),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [AppColor.primaryColor,AppColor.red]),
              borderRadius: BorderRadius.circular(8)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  children: [
                    SizedBox(height: 18,),
                    SvgPicture.asset(Images.logo,height: 40,width: 116,),
                    SizedBox(height: 50,),
                    Text("PANIIT - 2025\nEvent",textAlign: TextAlign.center,style: TextStyle(
                      fontWeight: FontWeight.w700,fontSize: 22,color: AppColor.white,fontFamily: appFontFamily
                    ),)
                  ],
                ),
                Image.asset(Images.bannerIcon),
              ],
            ),
          ),
          const SizedBox(height: 4,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(Images.facebookIcon),
              const SizedBox(width: 20,),
              SvgPicture.asset(Images.instagramIcon),
              const SizedBox(width: 20,),
              SvgPicture.asset(Images.linkedinIcon),
              const SizedBox(width: 20,),
              SvgPicture.asset(Images.twitterIcon),
            ],
          ),
          const SizedBox(height: 20,),

          Container(
            width: Get.width,height: 52,
            margin: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              gradient: LinearGradient(colors: [AppColor.primaryColor,AppColor.red])
            ),
            child: Center(
              child: Text("Direction To Venue",style: TextStyle(fontFamily: appFontFamily,fontSize: 16,fontWeight: FontWeight.w600,color: AppColor.white),
              ),
            ),
          ),
          const SizedBox(height: 50,),
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
          const SizedBox(height: 10,),
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
                  const SizedBox(height: 10,),
                  Text("17 January 2025",style: AppThemes.subtitle1TextStyle().copyWith(color:AppColor.white),),
                  const SizedBox(height: 10,),
                  InkWell(
                    onTap: (){
                      Get.toNamed(Routes.eventDetails);
                    },
                    child: Container(
                      height: 32,
                      width: 117,
                      decoration: BoxDecoration(
                          color: AppColor.red,
                          borderRadius: const BorderRadius.all(Radius.circular(10))
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
  
  Widget countdownWidget(){
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.all(1),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(9),
              gradient: LinearGradient(colors: [AppColor.primaryColor,AppColor.red])
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9),
                color: AppColor.white
              ),
              child: Column(
                children: [
                  GradientText(text: '113',style: const TextStyle(fontFamily: appFontFamily,fontWeight: FontWeight.w600,fontSize: 20), gradient: LinearGradient(colors: [AppColor.primaryColor,AppColor.red]),),
                  const SizedBox(height: 5,),
                  GradientText(text:"DAYS",style: const TextStyle(fontFamily: appFontFamily,fontWeight: FontWeight.w600,fontSize: 10), gradient: LinearGradient(colors: [AppColor.primaryColor,AppColor.red]))
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(1),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(9),
              gradient: LinearGradient(colors: [AppColor.primaryColor,AppColor.red])
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9),
                color: AppColor.white
              ),
              child: Column(
                children: [
                  GradientText(text:'23',style: const TextStyle(fontFamily: appFontFamily,fontWeight: FontWeight.w600,fontSize: 20), gradient: LinearGradient(colors: [AppColor.primaryColor,AppColor.red])),
                  const SizedBox(height: 5,),
                  GradientText(text:"HOURS",style: const TextStyle(fontFamily: appFontFamily,fontWeight: FontWeight.w600,fontSize: 10), gradient: LinearGradient(colors: [AppColor.primaryColor,AppColor.red]))
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(1),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(9),
              gradient: LinearGradient(colors: [AppColor.primaryColor,AppColor.red])
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9),
                color: AppColor.white
              ),
              child: Column(
                children: [
                  GradientText(text:'60',style: const TextStyle(fontFamily: appFontFamily,fontWeight: FontWeight.w600,fontSize: 20), gradient: LinearGradient(colors: [AppColor.primaryColor,AppColor.red])),
                  const SizedBox(height: 5,),
                  GradientText(text:"MINUTES",style: TextStyle(fontFamily: appFontFamily,fontWeight: FontWeight.w600,fontSize: 10,color: AppColor.primaryColor), gradient: LinearGradient(colors: [AppColor.primaryColor,AppColor.red]))
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(1),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(9),
              gradient: LinearGradient(colors: [AppColor.primaryColor,AppColor.red])
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9),
                color: AppColor.white
              ),
              child: Column(
                children: [
                  GradientText(text:'60',style: const TextStyle(fontFamily: appFontFamily,fontWeight: FontWeight.w600,fontSize: 20), gradient: LinearGradient(colors: [AppColor.primaryColor,AppColor.red])),
                  const SizedBox(height: 5,),
                  GradientText(text:"SECONDS",style: const TextStyle(fontFamily: appFontFamily,fontWeight: FontWeight.w600,fontSize: 10), gradient: LinearGradient(colors: [AppColor.primaryColor,AppColor.red]))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget exploreWidget(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: (){
              Get.offAll(HomePage(bottomNavIndex: 1));
            },
            child: Container(
              padding: EdgeInsets.all(1),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9),
                  gradient: LinearGradient(colors: [AppColor.primaryColor,AppColor.red])
              ),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 30,vertical: 16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(9),
                    color: AppColor.white
                ),
                child: Column(
                  children: [
                    SvgPicture.asset(Images.sponsorIcon),
                    SizedBox(height: 10,),
                    GradientText(text:"Delegates",style: TextStyle(fontFamily: appFontFamily,fontWeight: FontWeight.w600,fontSize: 10), gradient: LinearGradient(colors: [AppColor.primaryColor,AppColor.red]))
                  ],
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: (){
              Get.offAll(HomePage(bottomNavIndex: 3));
            },
            child: Container(
              padding: EdgeInsets.all(1),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9),
                  gradient: LinearGradient(colors: [AppColor.primaryColor,AppColor.red])
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(9),
                    color: AppColor.white
                ),
                child: Column(
                  children: [
                    SvgPicture.asset(Images.piwotAgendaIcon),
                    const SizedBox(height: 10,),
                    GradientText(text:"Agenda",style: const TextStyle(fontFamily: appFontFamily,fontWeight: FontWeight.w600,fontSize: 10), gradient: LinearGradient(colors: [AppColor.primaryColor,AppColor.red]))
                  ],
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: (){},
            child: Container(
              padding: EdgeInsets.all(1),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9),
                  gradient: LinearGradient(colors: [AppColor.primaryColor,AppColor.red])
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(9),
                    color: AppColor.white
                ),
                child: Column(
                  children: [
                    SvgPicture.asset(Images.floorPlanIcon),
                    const SizedBox(height: 10,),
                    GradientText(text:"Floor Plan",style: const TextStyle(fontFamily: appFontFamily,fontWeight: FontWeight.w600,fontSize: 10), gradient: LinearGradient(colors: [AppColor.primaryColor,AppColor.red]))
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget aboutEvent(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        height: 160,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
            itemBuilder: (context,index){
          return Container(
            height: 139,width: 139,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(9),
              border: Border.all(color: AppColor.primaryColor)
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(index==0?Images.homeConferenceIcon:index==1?Images.homeSpeakerIcon:Images.homeAttendanceIcon,height: 50,width: 50,),
                SizedBox(height: 16,),
                Text(index==0?"2 Days\nConference":index==1?"200\nSpeaker":"300\nAttendence",style: TextStyle(fontSize: 14,fontFamily: appFontFamily,fontWeight: FontWeight.w600,color: AppColor.primaryColor),textAlign: TextAlign.center,)
              ],
            ),
          );
        }, separatorBuilder: (BuildContext context, int index) { return SizedBox(width: 10,); }, itemCount: 3,),
      ),
    );
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
          const SizedBox(height: 10,),
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
                  const SizedBox(height: 10,),
                  Text("17 January 2025",style: AppThemes.subtitle1TextStyle().copyWith(color:AppColor.white),),
                  const SizedBox(height: 10,),
                  InkWell(
                    onTap: (){
                      Get.toNamed(Routes.eventDetails);
                    },
                    child: Container(
                      height: 32,
                      width: 117,
                      decoration: BoxDecoration(
                          color: AppColor.red,
                          borderRadius: const BorderRadius.all(Radius.circular(10))
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
          const SizedBox(height: 10,),
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
                  const SizedBox(height: 10,),
                  Text("17 January 2025",style: AppThemes.subtitle1TextStyle().copyWith(color:AppColor.white),),
                  const SizedBox(height: 10,),
                  InkWell(
                    onTap: (){
                      Get.toNamed(Routes.eventDetails);
                    },
                    child: Container(
                      height: 32,
                      width: 117,
                      decoration: BoxDecoration(
                          color: AppColor.red,
                          borderRadius: const BorderRadius.all(Radius.circular(10))
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
        const SizedBox(height: 16),
        buildIndicator(),
      ],
    );
  }

  Widget liveEventList(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
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
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    child: ClipRRect(
                        borderRadius: const BorderRadius.all(Radius.circular(8)),
                        child: Image.asset(liveEventItems[index],height: 203,width: 204,fit: BoxFit.fill,)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(index==0?"Digital Product":index==1?"Innovation Nexus":"Tech Innovator",style: TextStyle(color: AppColor.white,fontSize: 14,fontWeight: FontWeight.w600,fontFamily: appFontFamily),),
                        SizedBox(height: 8,),
                        Container(
                          height: 26,
                          width: 98,
                          decoration: BoxDecoration(
                            color: AppColor.red,
                            borderRadius: const BorderRadius.all(Radius.circular(8))
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Event Details",style: TextStyle(fontFamily: appFontFamily,fontWeight: FontWeight.w400,fontSize: 10,color: AppColor.white),),
                              const SizedBox(width: 2,),
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
          return const SizedBox(
            width: 16,
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
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: CarouselSlider(
        options: CarouselOptions(height: 160,
          aspectRatio: 16/9,
          viewportFraction: 0.34,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 3),
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
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
                  const SizedBox(height: 7,),
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
      padding: const EdgeInsets.symmetric(horizontal: 16),
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
                  borderRadius: const BorderRadius.all(Radius.circular(15))
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                      child: Image.asset(index ==0?Images.homeSpeaker1:index ==1?Images.homeSpeaker2:Images.homeSpeaker3,height: 80,width: 80,fit: BoxFit.fill,)),
                  const SizedBox(height: 5,),
                  Text(index==0?"Dr. Bharat\nBalasubramanian":index==1?"Dr. R.A. Mashelkar":"Dr. Sudhir Jain",style: TextStyle(fontFamily: appFontFamily,color: AppColor.white,fontSize: 16,fontWeight: FontWeight.w500),textAlign: TextAlign.center,),
                  const SizedBox(height: 16,),
                  Text(index==0?"Executive Director":index == 1?"Former Director General":"Vice Chancellor",style: TextStyle(fontFamily: appFontFamily,color: AppColor.white,fontSize: 12,fontWeight: FontWeight.w500),),
                ],
              ),
            );
          }, separatorBuilder: (BuildContext context, int index) { return const SizedBox(width: 16,); },),
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
            borderRadius: const BorderRadius.all(Radius.circular(8))
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
            color: AppColor.red,
            borderRadius: const BorderRadius.all(Radius.circular(8))
        ),
        child: Center(child: Text("Let's Go",style: AppThemes.titleTextStyle().copyWith(color: AppColor.white,fontSize: 17),)),
      ),
    );
  }

  Widget buildBulletPoint(Widget text,) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("• ", style: TextStyle(fontSize: 20)),
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