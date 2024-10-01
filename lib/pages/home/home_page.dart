import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
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
import '../../route/route_names.dart';
import '../../widgets/app_themes.dart';
import '../../widgets/custom_tabbar_indicator.dart';
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


  @override
  void initState() {
    _controller =  TabController(length: 3, vsync: this);
    _aboutController =  TabController(length: 2, vsync: this);
    bottomNavbarIndex = widget.bottomNavIndex;
    super.initState();
  }

  void _openDrawer() {
    _scaffoldKey.currentState?.openDrawer(); // Open the drawer
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _scaffoldKey, // Set the key to Scaffold
      backgroundColor: AppColor.white,
      drawer: drawerWidget(),
      appBar: PreferredSize(
        preferredSize: bottomNavbarIndex == 1|| bottomNavbarIndex == 4? Size.fromHeight(screenHeight * 0.173):Size.fromHeight(screenHeight * 0.08),
        child: AppBar(
          // toolbarHeight: bottomNavbarIndex == 3?screenHeight*0.152:null,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: EdgeInsets.zero, // Removes the padding
              title: bottomNavbarIndex == 1?
              Column(
                children: [
                  Container(
                    color: AppColor.primaryColor,
                    padding: const EdgeInsets.only(top: 40,left: 10,right: 10,bottom: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                            onTap: _openDrawer,
                            child: Icon(Icons.menu,color: AppColor.white,)
                        ),
                        SizedBox(width: 20,),
                        GestureDetector(
                          onTap: (){
                            Get.offAllNamed(Routes.home);
                          },
                            child: SvgPicture.asset(Images.logo,height: 40,width: 147,)),
                        Row(
                          children: [
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
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 20,),
                  Container(
                    width: Get.width,
                    color: AppColor.white,
                    // padding: EdgeInsets.only(left: 10,right: 10),
                    child: TabBar(
                        controller: _controller,
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
                        // UnderlineTabIndicator(
                        //   insets: EdgeInsets.symmetric(vertical: -8),
                        //   borderSide: BorderSide(color: AppColor.primaryColor, width: 4.0),
                        //
                        // ),
                        tabs: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 17),
                            child: Text("Delegates",style: AppThemes.labelTextStyle().copyWith(color: AppColor.primaryColor)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 17),
                            child: Text("Chat",style: AppThemes.labelTextStyle().copyWith(color: AppColor.primaryColor),),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 17),
                            child: Text("Request",style: AppThemes.labelTextStyle().copyWith(color: AppColor.primaryColor)),
                          ),
                        ]),
                  )
                ],
              ):bottomNavbarIndex == 4?
              Column(
                children: [
                  Container(
                    color: AppColor.primaryColor,
                    padding: const EdgeInsets.only(top: 40,left: 10,right: 10,bottom: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                            onTap: _openDrawer,
                            child: Icon(Icons.menu,color: AppColor.white,)
                        ),
                        SizedBox(width: 20,),
                        GestureDetector(
                            onTap: (){
                              Get.offAllNamed(Routes.home);
                            },
                            child: SvgPicture.asset(Images.logo,height: 40,width: 147,)),
                        Row(
                          children: [
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
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 20,),
                  Container(
                    width: Get.width,
                    color: AppColor.white,
                    // padding: EdgeInsets.only(left: 10,right: 10),
                    child: TabBar(
                        controller: _aboutController,
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
                        // UnderlineTabIndicator(
                        //   insets: EdgeInsets.symmetric(vertical: -8),
                        //   borderSide: BorderSide(color: AppColor.primaryColor, width: 4.0),
                        //
                        // ),
                        tabs: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 17),
                            child: Text("About Event",style: AppThemes.labelTextStyle().copyWith(color: AppColor.primaryColor)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 17),
                            child: Text("About Us",style: AppThemes.labelTextStyle().copyWith(color: AppColor.primaryColor),),
                          ),
                        ]),
                  )
                ],
              ):Padding(
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
          automaticallyImplyLeading: bottomNavbarIndex == 1||bottomNavbarIndex == 4?false:true,
          actions:bottomNavbarIndex == 1||bottomNavbarIndex == 4?null: [
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
          backgroundColor:bottomNavbarIndex == 1||bottomNavbarIndex == 4?AppColor.white:AppColor.primaryColor,
    ),
      ),
      body: bottomNavbarIndex == 0?const Home():bottomNavbarIndex == 1?Delegates(tabController: _controller!,):bottomNavbarIndex == 2?const Session():bottomNavbarIndex == 3?const Agenda():bottomNavbarIndex == 4?About(tabController: _aboutController!):SizedBox(),
      bottomNavigationBar:bottomNavbar(),
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
            InkWell(
              onTap: (){
                Get.toNamed(Routes.agenda);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(Images.piwotAgendaIcon,height: 21,width: 21,),
                        const SizedBox(width: 15,),
                        Text("Piwot 2024 Agenda",style: AppThemes.subtitle1TextStyle(),)
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

            const SizedBox(height: 20,),
            InkWell(
              onTap: (){
                Get.toNamed(Routes.survey);
              },
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
        padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: AppColor.FFEFEEFF
        ),
        child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(icon,color: AppColor.primaryColor,),
              SizedBox(width: 4,),
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


