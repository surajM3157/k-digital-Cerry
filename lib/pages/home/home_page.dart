import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:piwotapp/constants/colors.dart';
import 'package:piwotapp/constants/font_family.dart';
import 'package:piwotapp/constants/images.dart';
import 'package:get/get.dart';
import 'package:piwotapp/pages/home/about.dart';
import 'package:piwotapp/pages/home/agenda.dart';
import 'package:piwotapp/pages/home/delegates.dart';
import 'package:piwotapp/pages/home/session.dart';
import 'package:piwotapp/services/notification_service.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../repository/api_repo.dart';
import '../../responses/list_link_response.dart';
import '../../route/route_names.dart';
import '../../shared prefs/pref_manager.dart';
import '../../widgets/app_themes.dart';
import 'home.dart';

class HomePage extends StatefulWidget {

  int bottomNavIndex;
   HomePage({super.key,required this.bottomNavIndex});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin{

  GlobalKey<CurvedNavigationBarState> bottomNavigationKey = GlobalKey();
  int page = 0;
  int bottomNavbarIndex = 0;
  TextEditingController searchController = TextEditingController();
  TabController? _controller;
  TabController? _aboutController;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  double _calculateAppBarHeight() {
    double baseHeight = 40.0;  // Height of the logo or any other static element
    double tabBarHeight = 76.0;  // Height of the TabBar
    double additionalPadding = 20.0;  // Any additional padding
    return baseHeight + tabBarHeight + additionalPadding;
  }
  NotificationService? _fcmService;
  ListLinkData? _listLinkData;
  fetchListLink() async
  {
    // Future.delayed(Duration.zero, () {
    //   showLoader(context);
    // });

      var response = await ApiRepo().getListLinksResponse(true);

      if (response.data != null) {
        _listLinkData = response.data?[0];
      }

      setState(() {

      });


  }

  @override
  void initState() {
    _fcmService = NotificationService();
    FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
      if (message != null) {
        FirebaseFirestore.instance.collection("notifications").doc(Prefs.checkUserId).collection('notification').doc(message.messageId).set(
            {
              // "data": message.data,
              "title":message.notification?.title,
              "body":message.notification?.body,
            }, SetOptions(merge: true)
        ); // Store notification when app opens via a tap
      }
    });
    _controller =  TabController(length: 3, vsync: this);
    _aboutController =  TabController(length: 2, vsync: this);
    bottomNavbarIndex = widget.bottomNavIndex;
    fetchListLink();
    super.initState();
  }

  void _openDrawer() {
    _scaffoldKey.currentState?.openDrawer(); // Open the drawer
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async{
        if(bottomNavbarIndex != 0) {
          Get.offAllNamed(Routes.home);
        }
        return true;
      },
      child: Scaffold(
        key: _scaffoldKey, // Set the key to Scaffold
        backgroundColor: AppColor.white,
        drawer: drawerWidget(),
        appBar: AppBar(
          elevation: 0,
          // toolbarHeight: bottomNavbarIndex == 3?screenHeight*0.152:null,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: EdgeInsets.zero, // Removes the padding
              title: Padding(
                padding: const EdgeInsets.only(left: 10,bottom: 10),
                child: Align(
                  alignment: Alignment.bottomCenter,
                    child: GestureDetector(
                        onTap: (){
                          Get.offAllNamed(Routes.home);
                        },
                        child: SvgPicture.asset(Images.logo,height: 40,width: 147,))),
              ),
            ),
          automaticallyImplyLeading:
         // bottomNavbarIndex == 1||bottomNavbarIndex == 4?false:
          true,
          actions:
          //bottomNavbarIndex == 1||bottomNavbarIndex == 4?null:
          [
            InkWell(
                onTap: (){
                  Get.toNamed(Routes.profile);
                },
                child: SvgPicture.asset(Images.profileIcon,color: AppColor.white,)),
            InkWell(
              onTap: (){
                Get.toNamed(Routes.notification);
              },
                child: SvgPicture.asset(Images.notificationIcon,color: AppColor.white,)),
          ],
          backgroundColor:
          //bottomNavbarIndex == 1||bottomNavbarIndex == 4?AppColor.white:
          AppColor.primaryColor,
      ),
        body: bottomNavbarIndex == 0?const Home():bottomNavbarIndex == 1?Delegates(tabController: _controller!,):bottomNavbarIndex == 2?const Session():bottomNavbarIndex == 3?const Agenda():bottomNavbarIndex == 4?About(tabController: _aboutController!):const SizedBox(),
        bottomNavigationBar:bottomNavbar(),
      ),
    );
  }


  Widget drawerWidget(){
    return SafeArea(
      child: Drawer(
        backgroundColor: AppColor.FFF4F4F4,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const SizedBox(height: 30,),
            Row(
              children: [
                const SizedBox(width: 30,),
                InkWell(
                  onTap: (){
                    Get.back();
                  },
                    child: Icon(Icons.arrow_back_ios,color: AppColor.primaryColor,)),
                const SizedBox(width: 20,),
                SvgPicture.asset(Images.logoDark,height: 40,width: 147,)
              ],
            ),
            const SizedBox(height: 30,),
            // InkWell(
            //   onTap: (){
            //     Get.toNamed(Routes.agenda);
            //   },
            //   child: Padding(
            //     padding: const EdgeInsets.symmetric(horizontal: 20),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       children: [
            //         Row(
            //           children: [
            //             SvgPicture.asset(Images.piwotAgendaIcon,height: 21,width: 21,),
            //             const SizedBox(width: 15,),
            //             Text("Piwot 2024 Agenda",style: AppThemes.subtitle1TextStyle(),)
            //           ],
            //         ),
            //         Icon(Icons.arrow_forward_ios,color: AppColor.black,size: 16,)
            //       ],
            //     ),
            //   ),
            // ),
            // const SizedBox(height: 20,),
            InkWell(
              onTap: (){
                Get.toNamed(Routes.speaker);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(Images.speakerIcon,height: 21,width: 21,),
                        const SizedBox(width: 15,),
                        Text("Speaker",style: AppThemes.subtitle1TextStyle(),)
                      ],
                    ),
                    Icon(Icons.arrow_forward_ios,color: AppColor.black,size: 16,)
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20,),
            InkWell(
              onTap: (){
                Get.toNamed(Routes.sponsor);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(Images.sponsorIcon,height: 21,width: 21,),
                        const SizedBox(width: 15,),
                        Text("Sponsor",style: AppThemes.subtitle1TextStyle(),)
                      ],
                    ),
                    Icon(Icons.arrow_forward_ios,color: AppColor.black,size: 16,)
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20,),
            InkWell(
              onTap: (){
                Get.toNamed(Routes.liveEvents);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(Images.liveEventIcon,height: 21,width: 21,),
                        const SizedBox(width: 15,),
                        Text("Live Event",style: AppThemes.subtitle1TextStyle(),)
                      ],
                    ),
                    Icon(Icons.arrow_forward_ios,color: AppColor.black,size: 16,)
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20,),
            InkWell(
              onTap: (){
                //launchUrl(Uri.parse(_listLinkData?.privacyPolicyLink??""));

               Get.toNamed(Routes.privacyPolicy);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(Images.privacyPolicyIcon,height: 21,width: 21,),
                        const SizedBox(width: 15,),
                        Text("Privacy Policy",style: AppThemes.subtitle1TextStyle(),)
                      ],
                    ),
                    Icon(Icons.arrow_forward_ios,color: AppColor.black,size: 16,)
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20,),
            InkWell(
              onTap: (){
                //launchUrl(Uri.parse(_listLinkData?.termsAndConditionsLink??""));
                Get.toNamed(Routes.termsCondition);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(Images.termsConditionIcon,height: 21,width: 21,),
                        const SizedBox(width: 15,),
                        Text("Terms & Condition",style: AppThemes.subtitle1TextStyle(),)
                      ],
                    ),
                    Icon(Icons.arrow_forward_ios,color: AppColor.black,size: 16,)
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20,),
            InkWell(
              onTap: (){
                Get.toNamed(Routes.faq);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(Images.faqIcon,height: 21,width: 21,),
                        const SizedBox(width: 15,),
                        Text("FAQ",style: AppThemes.subtitle1TextStyle(),)
                      ],
                    ),
                    Icon(Icons.arrow_forward_ios,color: AppColor.black,size: 16,)
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20,),
            InkWell(
              onTap: (){
                Get.toNamed(Routes.survey,arguments: {
                  "session_id": "","type":"Global Survey"
                });              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(Images.surveyIcon,height: 21,width: 21,),
                        const SizedBox(width: 15,),
                        Text("Survey",style: AppThemes.subtitle1TextStyle(),)
                      ],
                    ),
                    Icon(Icons.arrow_forward_ios,color: AppColor.black,size: 16,)
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20,),
            InkWell(
              onTap: (){
                Get.toNamed(Routes.contactUs);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(Images.contactIcon,height: 21,width: 21,),
                        const SizedBox(width: 15,),
                        Text("Contact Us",style: AppThemes.subtitle1TextStyle(),)
                      ],
                    ),
                    Icon(Icons.arrow_forward_ios,color: AppColor.black,size: 16,)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      bottomNavbarIndex = index;
    });
  }

  Widget bottomNavbar(){
    return BottomAppBar(
      color: AppColor.primaryColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(Images.homeSelectedIcon, "Home", 0),
          _buildNavItem(Images.chatIcon, "Chat", 1),
          _buildNavItem(Images.sessionSelectedIcon, "Session", 2),
          _buildNavItem(Images.agendaIcon, "Agenda", 3),
          _buildNavItem(Images.aboutIcon, "About", 4),

        ],
      ),
    );
  }

  Widget _buildNavItem(String icon, String label, int index) {
    return InkWell(
      onTap: () => _onItemTapped(index),
      child:  bottomNavbarIndex==index?Container(
        padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: AppColor.FFEFEEFF
        ),
        child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(icon,color: AppColor.primaryColor,),
              const SizedBox(width: 4,),
              Text(label,style: TextStyle(fontSize: 12,fontWeight: FontWeight.w600,fontFamily: appFontFamily,color: AppColor.primaryColor),),

            ],)
      ):Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 10,),
          SvgPicture.asset(icon),
          const SizedBox(height: 10,),
          Text(label,style: TextStyle(fontSize: 12,fontWeight: FontWeight.w600,fontFamily: appFontFamily,color: AppColor.white),),
          const SizedBox(height: 10,),

        ],
      ),
    );
  }

}


