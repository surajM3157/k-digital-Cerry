import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:piwotapp/constants/api_urls.dart';
import 'package:piwotapp/responses/floor_plan_response.dart';
import '../constants/colors.dart';
import '../constants/font_family.dart';
import '../constants/images.dart';
import '../repository/api_repo.dart';
import '../widgets/app_themes.dart';
import '../widgets/gradient_text.dart';


class FloorPlanScreen extends StatefulWidget {
  const FloorPlanScreen({super.key});

  @override
  State<FloorPlanScreen> createState() => _FloorPlanScreenState();
}

class _FloorPlanScreenState extends State<FloorPlanScreen> {

  FloorPlanResponse? _floorPlanResponse;

  List<FloorPlanData> floorPlanList = [];

  fetchFloorPlan() async
  {
    Future.delayed(Duration.zero, () {
      showLoader(context);
    });

      var response = await ApiRepo().getFloorPlanResponse();

      floorPlanList.clear();
      if( response.data != null)
      {
        _floorPlanResponse = response;
        for(FloorPlanData floorPlan in _floorPlanResponse!.data!){
          floorPlanList.add(floorPlan);

        }
        print("floorPlanList ${floorPlanList.length}");
      }

      setState(() {

      });

  }


  @override
  void initState() {
    fetchFloorPlan();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: RefreshIndicator(
        color: AppColor.primaryColor,
        onRefresh: ()async{
          fetchFloorPlan();
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20,),
              Center(
                child: GradientText(text: "Floor Plan", style: const TextStyle(fontWeight: FontWeight.w600,fontSize: 20,fontFamily: appFontFamily), gradient:LinearGradient(
                  colors: [AppColor.primaryColor, AppColor.red],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),),
              ),
              floorPlanList.isNotEmpty?ListView.separated(
                itemCount: floorPlanList.length,
                  physics: const NeverScrollableScrollPhysics(),shrinkWrap: true,
                  itemBuilder: (context,index){
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(floorPlanList[index].floorName??"",style: AppThemes.labelTextStyle().copyWith(color: AppColor.primaryColor),),
                      const SizedBox(height: 10,),
                      SizedBox(
                        width: Get.width,
                        height: 200,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                            child: Image.network(ApiUrls.imageUrl + (floorPlanList[index].floorPlanImage??""),fit: BoxFit.fill,)),
                      )
                    ],
                  ),
                );
              }, separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(height: 16,);
              },):Center(child: Text("No Data Found",style: AppThemes.appBarTitleStyle(),))
            ],
          ),
        ),
      ),
    );
  }
}
