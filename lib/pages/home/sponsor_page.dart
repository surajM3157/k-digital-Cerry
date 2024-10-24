import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:piwotapp/constants/api_urls.dart';
import 'package:piwotapp/responses/partner_response.dart';
import 'package:piwotapp/responses/sponsor_response.dart';
import '../../constants/colors.dart';
import '../../constants/images.dart';
import '../../repository/api_repo.dart';
import '../../widgets/app_themes.dart';
import '../../widgets/custom_tabbar_indicator.dart';

class SponsorPage extends StatefulWidget {
  const SponsorPage({super.key});

  @override
  State<SponsorPage> createState() => _SponsorPageState();
}

class _SponsorPageState extends State<SponsorPage> with SingleTickerProviderStateMixin{

  List<Sponsor> sponsors = [Sponsor("Co-Powered By", Images.sponsorLogo1),Sponsor("Co-Powered By", Images.sponsorLogo2),
    Sponsor("Associate Partner", Images.sponsorLogo3),Sponsor("Associate Partner", Images.sponsorLogo4),
    Sponsor("Technology- Partner", Images.sponsorLogo5),Sponsor("Technology- Partner", Images.sponsorLogo6)
  ];

  late TabController _tabController;
  SponsorResponse? sponsorResponse;
  List<SponsorData> sponsorList = [];

  PartnerResponse? partnerResponse;
  List<PartnerData> partnerList = [];

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    fetchSponsorList();
    fetchPartnerList();
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColor.primaryColor,
        title: Padding(
          padding: const EdgeInsets.only(right: 60),
          child: Center(child: SvgPicture.asset(Images.logo, height: 40,width: 147)),
        ),
        leading: InkWell(
            onTap: (){
              Get.back();
            },
            child: Icon(Icons.arrow_back_ios,size: 20,color: AppColor.white,)),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10,),
          TabBar(
            controller: _tabController,
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
            tabs: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text("Sponsor",style: AppThemes.labelTextStyle().copyWith(color: AppColor.primaryColor),),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text("Partner",style: AppThemes.labelTextStyle().copyWith(color: AppColor.primaryColor)),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 1),
            height: 1,width: Get.width,color: AppColor.grey,),
          const SizedBox(height: 10,),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
              sponsorList.isNotEmpty?GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                itemBuilder: (_, index) => Container
                  (
                  margin: const EdgeInsets.all(10),
                  height: 143,width: 155,
                  decoration: BoxDecoration(
                      color: AppColor.FFFFFDFD,
                      borderRadius: const BorderRadius.all(Radius.circular(8),),
                      border: Border.all(color: AppColor.grey)),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 70,width: 100,
                            child: Image.network(ApiUrls.imageUrl+(sponsorList[index].sponsorImage??""))),
                        const SizedBox(height: 10,),
                        Text(sponsorList[index].sponsorName??"",style: AppThemes.labelTextStyle().copyWith(color: AppColor.black),)
                      ],
                    ),
                  ),
                ),
                itemCount: sponsorList.length,):SizedBox.shrink(),
              partnerList.isNotEmpty?GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                itemBuilder: (_, index) => Container
                  (
                  margin: const EdgeInsets.all(10),
                  height: 143,width: 155,
                  decoration: BoxDecoration(
                      color: AppColor.FFFFFDFD,
                      borderRadius: const BorderRadius.all(Radius.circular(8),),
                      border: Border.all(color: AppColor.grey)),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                            height: 70,width: 100,
                            child: Image.network(ApiUrls.imageUrl+(partnerList[index].partnerImage??""))),
                        const SizedBox(height: 10,),
                        Text(partnerList[index].partnerName??"",style: AppThemes.labelTextStyle().copyWith(color: AppColor.black),)
                      ],
                    ),
                  ),
                ),
                itemCount: partnerList.length,):SizedBox.shrink()
            ],

            ),
          )
        ],
      ),
    );
  }

  fetchSponsorList() async
  {
    Future.delayed(Duration.zero, () {
      showLoader(context);
    });

    try{
      var response = await ApiRepo().getSponsorResponse(false);

      if( response.data != null)
      {
        sponsorResponse = response;
        for(SponsorData sponsor in sponsorResponse!.data!){
          sponsorList.add(sponsor);

        }
        print("sponsorlist ${sponsorList.length}");
      }

      setState(() {

      });

    }
    catch(e){}


    setState(() {});
  }

  fetchPartnerList() async
  {
    Future.delayed(Duration.zero, () {
      showLoader(context);
    });

    try{
      var response = await ApiRepo().getPartnerResponse();

      if( response.data != null)
      {
        partnerResponse = response;
        for(PartnerData partner in partnerResponse!.data!){
          partnerList.add(partner);

        }
        print("partnerlist ${partnerList.length}");
      }

      setState(() {

      });

    }
    catch(e){}


    setState(() {});
  }
}

class Sponsor{
  String title;
  String icon;
  Sponsor(this.title,this.icon);
}