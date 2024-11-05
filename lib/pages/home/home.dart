import 'dart:async';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:piwotapp/constants/api_urls.dart';
import 'package:piwotapp/pages/home/home_page.dart';
import 'package:piwotapp/responses/banner_response.dart';
import 'package:piwotapp/responses/list_link_response.dart';
import 'package:piwotapp/responses/live_session_response.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../constants/colors.dart';
import '../../constants/font_family.dart';
import '../../constants/images.dart';
import '../../repository/api_repo.dart';
import '../../responses/speaker_response.dart';
import '../../responses/sponsor_response.dart';
import '../../route/route_names.dart';
import '../../widgets/app_themes.dart';
import '../../widgets/gradient_text.dart';
import '../../widgets/youtube_thumbnail.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {




  final PageController _pageController = PageController();



  Timer? _timer;
  Duration _timeRemaining = const Duration();
  final DateTime _endTime = DateTime(2025, 01, 16, 32, 59, 59); // Your end time

  BannerResponse? bannerResponse;
  List<BannerData> bannerList = [];

  SpeakerResponse? speakerResponse;
  List<SpeakerData> speakers = [];

  SponsorResponse? sponsorResponse;
  List<SponsorData> sponsors = [];

  LiveSessionResponse? liveSessionResponse;
  List<LiveSessionData> liveSessions = [];

  ListLinkData? _listLinkData;
  bool isConnected = true;


  void _launchMap() async {
    final Uri url = Uri.parse("https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent("Jio World Convention Centre, Jio World Centre, G Block, Bandra Kurla Complex, Bandra East, Mumbai, Maharashtra 400098")}");

   // final Uri url = Uri.parse("https://www.google.com/maps/search/?api=1&query=$latitude,$longitude");

    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }


  @override
  void initState() {
    super.initState();
    _startTimer();
    fetchBannerList();
    fetchSpeakerList();
    fetchSponsorList();
    fetchLiveSessionList();
    fetchListLink();
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        isConnected = false;
      } else {
        // Handle case when internet connection is available
        isConnected = true;
        fetchBannerList();
        fetchSpeakerList();
        fetchSponsorList();
        fetchLiveSessionList();
        fetchListLink();
      }
    });

  }

  fetchBannerList() async
  {
    bannerList.clear();
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      isConnected = false;
      setState(() {

      });
    }else{
      isConnected = true;
      Future.delayed(Duration.zero, () {
      showLoader(context);
    });
      var response = await ApiRepo().getBannerResponse();

      if( response.data != null)
      {
        bannerList.clear();
        bannerResponse = response;
        for(BannerData banner in bannerResponse!.data!){
          bannerList.add(banner);

        }
        print("bannerlist ${bannerList.length}");

      setState(() {

      });

    }
    }

  }

  fetchSpeakerList() async
  {
    // Future.delayed(Duration.zero, () {
    //   showLoader(context);
    // });

    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      isConnected = false;
      setState(() {

      });
    }else {
      isConnected = true;
      var response = await ApiRepo().getSpeakerResponse("", true);

      if (response.data != null) {
        speakerResponse = response;
        speakers.clear();
        for (SpeakerData speaker in speakerResponse!.data!) {
          speakers.add(speaker);
        }
        print("speakerlist ${speakers.length}");
      }

      setState(() {

      });
    }
  }

  fetchSponsorList() async
  {
    // Future.delayed(Duration.zero, () {
    //   showLoader(context);
    // });

    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      isConnected = false;
      setState(() {

      });
    }else {
      isConnected = true;
      var response = await ApiRepo().getSponsorResponse(true);

      if (response.data != null) {
        sponsorResponse = response;
        sponsors.clear();
        for (SponsorData sponsor in sponsorResponse!.data!) {
          sponsors.add(sponsor);
        }
        print("sponsorlist ${sponsors.length}");
      }

      setState(() {

      });
    }
  }

  fetchLiveSessionList() async
  {
    // Future.delayed(Duration.zero, () {
    //   showLoader(context);
    // });

    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      isConnected = false;
      setState(() {

      });
    }else {
      isConnected = true;
      var response = await ApiRepo().getLiveSessionResponse(true);

      if (response.data != null) {
        liveSessionResponse = response;
        liveSessions.clear();
        for (LiveSessionData live in liveSessionResponse!.data!) {
          liveSessions.add(live);
        }
        print("liveSessions ${liveSessions.length}");
      }

      setState(() {

      });
    }
  }

  fetchListLink() async
  {
    // Future.delayed(Duration.zero, () {
    //   showLoader(context);
    // });

    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      isConnected = false;

      setState(() {

      });
      EasyLoading.showToast("No Internet",
          dismissOnTap: true,
          duration: const Duration(seconds: 1),
          toastPosition: EasyLoadingToastPosition.center);
    }else {
      isConnected = true;
      var response = await ApiRepo().getListLinksResponse(true);

      if (response.data != null) {
        _listLinkData = response.data?[0];
      }

      setState(() {

      });
    }

  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      setState(() {
        _timeRemaining = _endTime.difference(DateTime.now());

        if (_timeRemaining.isNegative) {
          timer.cancel();
        }
      });
    });
  }

  List<int> _formatDuration(Duration duration) {
    int days = duration.inDays;
    int hours = duration.inHours.remainder(24);
    int minutes = duration.inMinutes.remainder(60);
    int seconds = duration.inSeconds.remainder(60);

    return [days, hours, minutes, seconds];
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return isConnected?RefreshIndicator(
      onRefresh: () async{
        fetchBannerList();
        fetchSpeakerList();
        fetchSponsorList();
        fetchLiveSessionList();
        fetchListLink();
      },
      color: AppColor.primaryColor,
      child: SingleChildScrollView(
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
                  const SizedBox(height: 23,),
                  Text("PANIIT 2025 Highlights",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700,fontFamily: appFontFamily,color: AppColor.white),),
                  const SizedBox(height: 26,),
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
                  const SizedBox(height: 16,),
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
                  const SizedBox(height: 16,),
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
                  const SizedBox(height: 20,)
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GradientText(text: "Live Events",style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w600,fontFamily: appFontFamily), gradient: LinearGradient(
                    colors: [AppColor.primaryColor, AppColor.red],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),),
                  InkWell(
                    onTap: (){
                      Get.toNamed(Routes.liveEvents);
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GradientText(text: "Venue",style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w600,fontFamily: appFontFamily), gradient: LinearGradient(
                colors: [AppColor.primaryColor, AppColor.red],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),),
            ),
            Container(
              width: Get.width,
              margin: const EdgeInsets.all(16),
              height: 208,
              padding: const EdgeInsets.only(left: 16),
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
                      const SizedBox(height: 18,),
                      SvgPicture.asset(Images.logo,height: 40,width: 116,),
                      const SizedBox(height: 50,),
                      Text("PANIIT - 2025\nEvent",textAlign: TextAlign.center,style: TextStyle(
                        fontWeight: FontWeight.w700,fontSize: 22,color: AppColor.white,fontFamily: appFontFamily
                      ),)
                    ],
                  ),
                  Expanded(
                    child: Image.asset(Images.bannerIcon),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: (){
                    launchUrl(Uri.parse(_listLinkData?.facebookLink??""));
                  },
                    child: SvgPicture.asset(Images.facebookIcon)),
                const SizedBox(width: 20,),
                InkWell(
                    onTap: (){
                      launchUrl(Uri.parse(_listLinkData?.instagramLink??""));
                    },
                    child: SvgPicture.asset(Images.instagramIcon)),
                const SizedBox(width: 20,),
                InkWell(
                    onTap: (){
                      launchUrl(Uri.parse(_listLinkData?.linkedinLink??""));
                    },
                    child: SvgPicture.asset(Images.linkedinIcon)),
                const SizedBox(width: 20,),
                InkWell(
                    onTap: (){
                      launchUrl(Uri.parse(_listLinkData?.twitterLink??""));
                    },
                    child: SvgPicture.asset(Images.twitterIcon)),
                const SizedBox(width: 20,),
                InkWell(
                    onTap: (){
                      launchUrl(Uri.parse(_listLinkData?.youtubeLink??""));
                    },
                    child: Image.asset(Images.youtubeIcon,height: 35,width: 30,color: AppColor.primaryColor,)),

              ],
            ),
            const SizedBox(height: 20,),

            GestureDetector(
              onTap: (){
                _launchMap();
              },
              child: Container(
                width: Get.width,height: 52,
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  gradient: LinearGradient(colors: [AppColor.primaryColor,AppColor.red])
                ),
                child: Center(
                  child: Text("Direction To Venue",style: TextStyle(fontFamily: appFontFamily,fontSize: 16,fontWeight: FontWeight.w600,color: AppColor.white),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 50,),
          ],
        ),
      ),
    ):const Center(child: Text("OOPS! NO INTERNET.",style: TextStyle(color: Colors.black87,fontWeight: FontWeight.w600,fontFamily: appFontFamily,fontSize: 20),));
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
                  GradientText(text: _formatDuration(_timeRemaining)[0].toString(),style: const TextStyle(fontFamily: appFontFamily,fontWeight: FontWeight.w600,fontSize: 20), gradient: LinearGradient(colors: [AppColor.primaryColor,AppColor.red]),),
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
                  GradientText(text:_formatDuration(_timeRemaining)[1].toString(),style: const TextStyle(fontFamily: appFontFamily,fontWeight: FontWeight.w600,fontSize: 20), gradient: LinearGradient(colors: [AppColor.primaryColor,AppColor.red])),
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
                  GradientText(text:_formatDuration(_timeRemaining)[2].toString(),style: const TextStyle(fontFamily: appFontFamily,fontWeight: FontWeight.w600,fontSize: 20), gradient: LinearGradient(colors: [AppColor.primaryColor,AppColor.red])),
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
                  GradientText(text:_formatDuration(_timeRemaining)[3].toString(),style: const TextStyle(fontFamily: appFontFamily,fontWeight: FontWeight.w600,fontSize: 20), gradient: LinearGradient(colors: [AppColor.primaryColor,AppColor.red])),
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
              padding: const EdgeInsets.all(1),
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
                    SvgPicture.asset(Images.sponsorIcon),
                    const SizedBox(height: 10,),
                    GradientText(text:"Delegates",style: const TextStyle(fontFamily: appFontFamily,fontWeight: FontWeight.w600,fontSize: 10), gradient: LinearGradient(colors: [AppColor.primaryColor,AppColor.red]))
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
              padding: const EdgeInsets.all(1),
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
            onTap: (){
              Get.toNamed(Routes.floorPlan);
            },
            child: Container(
              padding: const EdgeInsets.all(1),
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
                const SizedBox(height: 16,),
                Text(index==0?"2 Days\nConference":index==1?"200+\nSpeakers":"3000+\nAttendees",style: TextStyle(fontSize: 14,fontFamily: appFontFamily,fontWeight: FontWeight.w600,color: AppColor.primaryColor),textAlign: TextAlign.center,)
              ],
            ),
          );
        }, separatorBuilder: (BuildContext context, int index) { return const SizedBox(width: 10,); }, itemCount: 3,),
      ),
    );
  }

  // Indicator widget
  Widget buildIndicator() => bannerList.isNotEmpty?SmoothPageIndicator(
    controller: _pageController,
    count: bannerList.length,
    effect: WormEffect(
      dotWidth: 10,
      dotHeight: 10,
      activeDotColor: AppColor.primaryColor,
      dotColor: AppColor.primaryColor,
      paintStyle: PaintingStyle.stroke
    ),
  ):SizedBox.shrink();

  int activeIndex =0;

  Widget bannerCarousel(){
    return  Column(
      children: [
        SizedBox(
          height: 254,
          child: PageView.builder(
            controller: _pageController,
            scrollDirection: Axis.horizontal,
            itemCount: bannerList.length,
              itemBuilder: (context, index){
            return GestureDetector(
              onTap: (){
                activeIndex = index;
                setState(() {

                });
              },
                child: Image.network(ApiUrls.imageUrl + (bannerList[index].bannerImage??""),fit: BoxFit.fill,));
          }),
        ),
        const SizedBox(height: 16),
        buildIndicator(),
      ],
    );
  }

  Widget liveEventList(){
    return liveSessions.isNotEmpty?Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        height: 160,
        child: ListView.separated(
          itemCount: (liveSessions.length < 3)?liveSessions.length:3,
          scrollDirection: Axis.horizontal,
            itemBuilder: (context,index){
          return liveSessions[index].link!.contains("=")?InkWell(
              onTap: (){
                Get.toNamed(Routes.liveSession,arguments: {
                  "data":liveSessions[index]
                });
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
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                        child: SizedBox(
                          height: 203,width: 204,
                          child: YouTubeThumbnail(
                            youtubeUrl: liveSessions[index].link??"", // Replace with your YouTube link
                          ),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(liveSessions[index].title??"",style: TextStyle(color: AppColor.primaryColor,fontSize: 14,fontWeight: FontWeight.w600,fontFamily: appFontFamily),),
                        const SizedBox(height: 8,),
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
              )):SizedBox.shrink();
        }, separatorBuilder: (BuildContext context, int index){
          return const SizedBox(
            width: 16,
          );
        },),
      ),
    ):SizedBox.shrink();
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
    return sponsors.isNotEmpty?Padding(
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
        items: sponsors.map((item) {
          return Builder(
            builder: (BuildContext context) {
              return Column(
                children: [
                  Image.network(ApiUrls.imageUrl+(item.sponsorImage??""),height: 100,width: 100,),
                  const SizedBox(height: 7,),
                  SizedBox(
                      width:80,
                      child: Text(item.sponsorName??"",textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.w400,fontSize: 12,fontFamily: appFontFamily,color: AppColor.primaryColor),
                      ))
                ],
              );
            },
          );
        }).toList(),
      ),
    ):SizedBox.shrink();
  }

  Widget speakerList(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        height: 200,
        child: speakers.isNotEmpty?ListView.separated(
          padding: EdgeInsets.zero,
          itemCount: (speakers.length < 3)?speakers.length:3,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context,index){
            return Container(
              height: 150,
              width: 173,
              padding: EdgeInsets.all(5),
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
                      child: Image.network(ApiUrls.imageUrl+(speakers[index].speakerImage??""),height: 80,width: 80,fit: BoxFit.fill,)),
                  const SizedBox(height: 5,),
                  Text(speakers[index].speakerName??"",style: TextStyle(fontFamily: appFontFamily,color: AppColor.white,fontSize: 16,fontWeight: FontWeight.w500),textAlign: TextAlign.center,),
                  const SizedBox(height: 16,),
                  Text(speakers[index].designation??"",style: TextStyle(fontFamily: appFontFamily,color: AppColor.white,fontSize: 12,fontWeight: FontWeight.w500),),
                ],
              ),
            );
          }, separatorBuilder: (BuildContext context, int index) { return const SizedBox(width: 16,); },):SizedBox.shrink(),
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