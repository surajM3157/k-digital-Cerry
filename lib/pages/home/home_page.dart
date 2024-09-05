import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
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

  @override
  void initState() {
    _controller = new TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        toolbarHeight: bottomNavbarIndex == 3?120:null,
        elevation: 0,
        leading:bottomNavbarIndex == 3?null:bottomNavbarIndex == 0? InkWell(
          onTap: (){
            Get.toNamed(Routes.profile);
          },
            child: SvgPicture.asset(Images.profileIcon,color: AppColor.white,)):InkWell(
            onTap: (){
              bottomNavbarIndex = 0;
              setState(() {

              });
            },
            child: Icon(Icons.arrow_back_ios,size: 20,color: AppColor.primaryColor,)),
        actions: [
          bottomNavbarIndex == 0?InkWell(
            onTap: (){
              Get.toNamed(Routes.notification);
            },
              child: SvgPicture.asset(Images.notificationIcon,color: AppColor.white,)):SizedBox.shrink(),
        ],
        backgroundColor:bottomNavbarIndex == 3?AppColor.secondaryColor:bottomNavbarIndex == 0? AppColor.primaryColor:AppColor.white,
        title:bottomNavbarIndex == 0? Center(
          child: Text('Home',style: AppThemes.titleTextStyle().copyWith(color: AppColor.white,),
      ),
        ):bottomNavbarIndex == 3?
        Column(
          children: [
            SizedBox(height: 10,),
            TextFormField(
              controller: searchController,
              style: TextStyle(color: AppColor.white),
              cursorColor: AppColor.white,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search_rounded,color: AppColor.white,),
                hintText: "Search Delegates",
                hintStyle: TextStyle(color: Colors.white,fontFamily: appFontFamilyBody,fontWeight:FontWeight.w400,fontSize: 14),
                fillColor: AppColor.primaryColor,
                filled: true,
                contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color:AppColor.secondaryColor)),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color:AppColor.secondaryColor)),
                errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.red, width: 2.0)),
                focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.red, width: 2.0)),
              ),
            ),
            SizedBox(height: 20,),
            SizedBox(
              width: Get.width,
              child: TabBar(
                controller: _controller,
                  isScrollable: true,
                  physics: NeverScrollableScrollPhysics(),
                  labelPadding: EdgeInsets.symmetric(horizontal: 25),
                  indicatorColor: AppColor.primaryColor,
                  indicator:CustomUnderlineTabIndicator(
                    borderSide: BorderSide(width: 3.0, color: AppColor.primaryColor),
                    insets:EdgeInsets.symmetric(vertical: -8),
                    borderRadius: BorderRadius.only(
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
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Text("Chats 22",style: AppThemes.labelTextStyle().copyWith(color: AppColor.primaryColor),),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Text("Invite Delegates",style: AppThemes.labelTextStyle().copyWith(color: AppColor.primaryColor)),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Text("Request",style: AppThemes.labelTextStyle().copyWith(color: AppColor.primaryColor)),
                ),
              ]),
            )
          ],
        ):Center(child: Padding(
          padding: const EdgeInsets.only(right: 70),
          child: Text(bottomNavbarIndex == 1?"Ticket":"Breakout Rooms",style:  AppThemes.appBarTitleStyle(),),
        )),
    ),
      body: bottomNavbarIndex == 0?Home():bottomNavbarIndex == 1?Booking():bottomNavbarIndex == 2?Session():Delegates(tabController: _controller!,),
      bottomNavigationBar: bottomNavbar(),
    );
  }



  Widget bottomNavbar(){
    return CurvedNavigationBar(
      key: bottomNavigationKey,
      color: AppColor.primaryColor,
      backgroundColor: Colors.white,
      buttonBackgroundColor: AppColor.bottomNavColor,
      items: [
        CurvedNavigationBarItem(
          child:         Padding(
            padding: const EdgeInsets.all(8.0),
            child: SvgPicture.asset(bottomNavbarIndex==0?Images.homeSelectedIcon:Images.homeUnselectedIcon),
          ),
          label:bottomNavbarIndex == 0? 'Home':null,
            labelStyle: AppThemes.labelTextStyle()
        ),CurvedNavigationBarItem(
          child:     Padding(
            padding: const EdgeInsets.all(8.0),
            child: SvgPicture.asset(bottomNavbarIndex==1?Images.bookingSelectedIcon:Images.bookingUnselectedIcon),
          ),
          label: bottomNavbarIndex == 1?'Booking':null,
            labelStyle: AppThemes.labelTextStyle()
        ),CurvedNavigationBarItem(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SvgPicture.asset(bottomNavbarIndex==2?Images.sessionSelectedIcon:Images.sessionUnselectedIcon),
          ),
          label: bottomNavbarIndex == 2?'Session':null,
            labelStyle: AppThemes.labelTextStyle()
        ),CurvedNavigationBarItem(
          child:
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SvgPicture.asset(bottomNavbarIndex==3?Images.delegatesSelectedIcon:Images.delegatesUnselectedIcon),
          ),
          label: bottomNavbarIndex == 3?'Delegates':null,
          labelStyle: AppThemes.labelTextStyle()
        ),


      ],
      index: bottomNavbarIndex,
      onTap: (index) {
        bottomNavbarIndex = index;
        setState(() {

        });
      },
    );
  }

}


