import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:piwotapp/constants/colors.dart';
import 'package:piwotapp/constants/font_family.dart';
import 'package:piwotapp/constants/images.dart';
import 'package:get/get.dart';
import 'package:piwotapp/pages/home/booking.dart';
import 'package:piwotapp/pages/home/delegates.dart';
import 'package:piwotapp/pages/home/session.dart';
import '../../route/route_names.dart';
import '../../widgets/app_themes.dart';
import '../../widgets/custom_tabbar_indicator.dart';
import 'home.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin{

  GlobalKey<CurvedNavigationBarState> bottomNavigationKey = GlobalKey();
  int page = 0;
  int bottomNavbarIndex = 0;
  TextEditingController searchController = TextEditingController();
  TabController? _controller;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();


  @override
  void initState() {
    _controller =  TabController(length: 3, vsync: this);
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
        preferredSize: bottomNavbarIndex == 3? Size.fromHeight(screenHeight * 0.152):Size.fromHeight(screenHeight * 0.08),
        child: AppBar(
          // toolbarHeight: bottomNavbarIndex == 3?screenHeight*0.152:null,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: EdgeInsets.zero, // Removes the padding
              title: bottomNavbarIndex == 3?
              Column(
                children: [
                  Container(
                    color: AppColor.primaryColor,
                    padding: const EdgeInsets.only(top: 30,left: 10,right: 10,bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SvgPicture.asset(Images.logo,height: 40,width: 147,),
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
                            InkWell(
                                onTap: _openDrawer,
                                child: Icon(Icons.menu,color: AppColor.white,)
                            ),
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
              ):Padding(
                padding: const EdgeInsets.only(left: 10,bottom: 10),
                child: Align(
                  alignment: Alignment.bottomLeft,
                    child: SvgPicture.asset(Images.logo,height: 40,width: 147,)),
              ),
            ),
          automaticallyImplyLeading: false,
          actions:bottomNavbarIndex == 3?null: [
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
            InkWell(
              onTap: _openDrawer,
              child: Icon(Icons.menu,color: AppColor.white,)
            ),
            const SizedBox(width: 20,)
          ],
          backgroundColor:bottomNavbarIndex == 3?AppColor.white:AppColor.primaryColor,
    ),
      ),
      body: bottomNavbarIndex == 0?const Home():bottomNavbarIndex == 1?const Booking():bottomNavbarIndex == 2?const Session():Delegates(tabController: _controller!,),
      bottomNavigationBar: bottomNavbar(),
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
            Container(
              height: 48,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              width: Get.width,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColor.primaryColor, AppColor.red],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                borderRadius: const BorderRadius.all(Radius.circular(8))
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Conference",style: AppThemes.subtitle1TextStyle().copyWith(color:AppColor.white),),
                  SvgPicture.asset(Images.downArrowIcon)
                ],
              ),
            ),
            const SizedBox(height: 20,),
            InkWell(
              onTap: (){
                Get.toNamed(Routes.agenda);
              },
              child: Row(
                children: [
                  const SizedBox(width: 20,),
                  SvgPicture.asset(Images.agendaIcon,height: 21,width: 21,),
                  const SizedBox(width: 5,),
                  Text("Piwot 2024 Agenda",style: AppThemes.subtitle1TextStyle(),)
                ],
              ),
            ),
            const SizedBox(height: 20,),
            InkWell(
              onTap: (){
                Get.toNamed(Routes.speaker);
              },
              child: Row(
                children: [
                  const SizedBox(width: 20,),
                  SvgPicture.asset(Images.speakerIcon,height: 21,width: 21,),
                  const SizedBox(width: 5,),
                  Text("Speaker",style: AppThemes.subtitle1TextStyle(),)
                ],
              ),
            ),
            const SizedBox(height: 20,),
            InkWell(
              onTap: (){
                Get.toNamed(Routes.sponsor);
              },
              child: Row(
                children: [
                  const SizedBox(width: 20,),
                  SvgPicture.asset(Images.sponsorIcon,height: 21,width: 21,),
                  const SizedBox(width: 5,),
                  Text("Sponsor",style: AppThemes.subtitle1TextStyle(),)
                ],
              ),
            ),
            const SizedBox(height: 30,),
            Container(
              height: 48,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              width: Get.width,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColor.primaryColor, AppColor.red],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(8))
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Festivities",style: AppThemes.subtitle1TextStyle().copyWith(color:AppColor.white),),
                  SvgPicture.asset(Images.downArrowIcon)
                ],
              ),
            ),
            const SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text("Privacy Policy",style: AppThemes.subtitle1TextStyle(),),
            ),
            const SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text("Terms & Condition",style: AppThemes.subtitle1TextStyle(),),
            ),
            const SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text("Terms of Use",style: AppThemes.subtitle1TextStyle(),),
            ),
            const SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text("News",style: AppThemes.subtitle1TextStyle(),),
            ),
            const SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text("FAQ",style: AppThemes.subtitle1TextStyle(),),
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
          _buildNavItem(Images.bookingSelectedIcon, "Bookings", 1),
          _buildNavItem(Images.sessionSelectedIcon, "Session", 2),
          _buildNavItem(Images.delegatesSelectedIcon, "Delegates", 3),
        ],
      ),
    );
  }

  Widget _buildNavItem(String icon, String label, int index) {
    return InkWell(
      onTap: () => _onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 10,),
          SvgPicture.asset(icon),
          const SizedBox(height: 10,),
          Text(label,style: TextStyle(fontSize: 12,fontWeight: FontWeight.w600,fontFamily: appFontFamily,color: AppColor.white),),
          const SizedBox(height: 10,),
          bottomNavbarIndex==index?Container(
            height: 5,
            width: 61,
            color: AppColor.red,
          ):const SizedBox()
        ],
      ),
    );
  }

}


