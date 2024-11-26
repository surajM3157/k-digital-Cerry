import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:piwotapp/constants/api_urls.dart';
import 'package:piwotapp/constants/constants.dart';
import 'package:piwotapp/constants/font_family.dart';
import 'package:piwotapp/responses/session_list_response.dart';
import 'package:piwotapp/widgets/app_button.dart';
import '../constants/colors.dart';
import '../constants/images.dart';
import '../repository/api_repo.dart';
import '../responses/session_surveys_response.dart';
import '../route/route_names.dart';
import '../widgets/app_themes.dart';
import '../widgets/gradient_text.dart';

class SessionDetailsPage extends StatefulWidget {
   SessionDetailsPage({super.key,this.title,this.image});
  String? title;
  String? image;

  @override
  State<SessionDetailsPage> createState() => _SessionDetailsPageState();
}

class _SessionDetailsPageState extends State<SessionDetailsPage> {


  SessionListData? _sessionListData;
  bool isConnected = true;

  SessionSurveysData? sessionSurveysData;
  bool isSurvey = false;

  @override
  void initState() {
    _sessionListData = Get.arguments['data'];
    fetchSessionSurvey();
    super.initState();
  }

  fetchSessionSurvey() async
  {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      isConnected = false;
      setState(() {

      });
    }else {
      isConnected = true;
      Future.delayed(Duration.zero, () {
        showLoader(context);
      });

      var response = await ApiRepo().getSessionSurveysResponse();

      if( response.data != null)
      {
        for(SessionSurveysData session in response.data!){
          if(_sessionListData?.sId == session.sessionId){
            sessionSurveysData = session;
            if(sessionSurveysData != null){
              if(sessionSurveysData!.questionsDetails!.isNotEmpty){
                isSurvey = true;
              }
            }
          }

        }
      }

      // print("Question1 ${questionList[0].question}");
      // print("Question2 ${questionList[1].question}");

      setState(() {

      });}

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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              SizedBox(
                  width: Get.width,
                  child: Image.network(ApiUrls.imageUrl+(_sessionListData?.sessionImage??""),fit: BoxFit.contain,)),
              Container(
                margin: const EdgeInsets.only(top: 260),
                decoration: BoxDecoration(
                  color: AppColor.white,
                  borderRadius: const BorderRadius.only(topRight: Radius.circular(25),topLeft: Radius.circular(25))
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 14,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: GradientText(text:_sessionListData?.sessionName??"",style: AppThemes.titleTextStyle().copyWith(
                              fontWeight: FontWeight.w600,fontSize: 20
                          ), gradient: LinearGradient(colors: AppColor.gradientColors),),
                        ),
                        const SizedBox(height: 14,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(_sessionListData?.sessionDescription??"",style:AppThemes.subtitleTextStyle().copyWith(fontSize: 16)),
                        ),
                        const SizedBox(height: 12,),
                        Container(width: Get.width,
                          height: 1,color: AppColor.primaryColor,
                        ),
                        const SizedBox(height: 17,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            children: [
                              GradientText(text:"Room: ", style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w600,fontFamily: appFontFamily), gradient: LinearGradient(
                                colors: AppColor.gradientColors
                              ),),
                              Text(_sessionListData?.roomDetails?.roomNo??"",style: TextStyle(fontSize: 16,fontFamily: appFontFamily,fontWeight: FontWeight.w400,color: AppColor.FF161616),)
                            ],
                          ),
                        ),
                        const SizedBox(height: 7,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            children: [
                              GradientText(text:"Floor: ", style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w600,fontFamily: appFontFamily), gradient: LinearGradient(
                                colors: AppColor.gradientColors
                              ),),
                              Text(capitalizeText(_sessionListData?.floorDetails!.floorName?.toLowerCase()??""),style: TextStyle(fontSize: 16,fontFamily: appFontFamily,fontWeight: FontWeight.w400,color: AppColor.FF161616),)
                            ],
                          ),
                        ),
                        const SizedBox(height: 20,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            children: [
                              Icon(Icons.date_range,size: 17,color: AppColor.primaryColor,),
                              const SizedBox(width: 5,),
                              GradientText(text:"Date & Time",style: AppThemes.labelTextStyle().copyWith(color: AppColor.primaryColor,fontWeight: FontWeight.w600),gradient:LinearGradient(
                                colors: AppColor.gradientColors,
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              )),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10,),
                        Padding(
                          padding: const EdgeInsets.only(left: 40),
                          child: Text(DateFormat('dd MMMM yyyy, EEEE').format(DateTime.parse(_sessionListData?.date??"")),style: AppThemes.subtitleTextStyle(),),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 40),
                          child: Text(_sessionListData?.time??"",style: AppThemes.subtitleTextStyle(),),
                        ),

                      ],
                    ),
                    const SizedBox(height: 20,),
                    Container(width: Get.width,
                      height: 1,color: AppColor.primaryColor,
                    ),
                    const SizedBox(height: 20,),
                    _sessionListData?.speakerDetails !=null?Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: GradientText(text: "Speaker", style: const TextStyle(fontWeight: FontWeight.w600,fontFamily: appFontFamily,fontSize: 16), gradient: LinearGradient(
                        colors: AppColor.gradientColors
                      )),
                    ):const SizedBox.shrink(),
                    _sessionListData?.speakerDetails !=null?SizedBox(
                      height: 200,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _sessionListData?.speakerDetails?.length,
                          itemBuilder: (context,index){
                            return GestureDetector(
                              onTap: (){
                                speakerDetails(title: _sessionListData?.speakerDetails?[index].speakerName??"", subtitle: _sessionListData?.speakerDetails?[index].designation??"", body: _sessionListData?.speakerDetails?[index].bio??"", image: _sessionListData?.speakerDetails?[index].speakerImage??"");
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 30),
                                child: Stack(
                                  alignment: Alignment.bottomCenter,
                                  clipBehavior: Clip.none,
                                  children: [
                                    Container(
                                      width: 210,
                                      height: 210,
                                      margin: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                                          gradient: LinearGradient(
                                            colors: AppColor.gradientColors,
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                          )
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                          child: Image.network(ApiUrls.imageUrl+(_sessionListData?.speakerDetails?[index].speakerImage??""),fit: BoxFit.fill,)),
                                    ),
                                    Positioned(
                                      bottom: -30,
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(horizontal: 20),
                                        width: 210,
                                        // height: 80,
                                        decoration: BoxDecoration(
                                            color: AppColor.black.withOpacity(0.85),
                                            borderRadius: const BorderRadius.all(Radius.circular(10))
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(_sessionListData?.speakerDetails?[index].speakerName??"",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: AppColor.white,fontFamily: appFontFamily),overflow: TextOverflow.ellipsis,),
                                              Text(_sessionListData?.speakerDetails?[index].designation??"",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: AppColor.white,fontFamily: appFontFamily),overflow: TextOverflow.ellipsis,),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          }),
                    ):const SizedBox.shrink(),
                    const SizedBox(height: 30,),
                 //  DateTime.parse(_sessionListData?.date??"") == DateTime.now()?
                  isSurvey? AppButton(title: "Take Survey", onTap: (){
                      Get.toNamed(Routes.survey, arguments: {
                        "session_id": _sessionListData?.sId,"type":""
                      });
                    }):const SizedBox.shrink(),
                       //:SizedBox.shrink(),
                    const SizedBox(height: 20,),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  speakerDetails({required String title, required String subtitle, required String body, required String image}){

    return showModalBottomSheet<void>(
      // context and builder are
      // required properties in this widget
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(32.0)),
      ),
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        // we set up a container inside which
        // we create center column and display text

        // Returning SizedBox instead of a Container
        return Stack(
          alignment: Alignment.topRight,
          children: [
            Container(
              width: Get.width,
              height: Get.height/1.5,
              decoration: BoxDecoration(
                  color: AppColor.white,
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(32),topRight: Radius.circular(32))
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 30,),
                    Container(
                      width: 148,height: 156,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        gradient: LinearGradient(colors: AppColor.gradientColors),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                          child: Image.network(ApiUrls.imageUrl+image,fit: BoxFit.fill,)),
                    ),
                    // const SizedBox(height: 10,),
                    // Row(
                    //   children: [
                    //     Icon(Icons.flag,color: AppColor.FF050505,),
                    //     const SizedBox(width: 5,),
                    //     Text("India",style: TextStyle(fontFamily: appFontFamily,fontSize: 14,fontWeight: FontWeight.w400,color: AppColor.FF444444),)
                    //   ],
                    // ),
                    const SizedBox(height: 20,),
                    Text(title,style: TextStyle(fontFamily: appFontFamily,fontSize: 16,fontWeight: FontWeight.w700,color: AppColor.FF050505),),
                    const SizedBox(height: 10,),
                    Text(subtitle,style: TextStyle(fontFamily: appFontFamily,fontSize: 14,fontWeight: FontWeight.w600,color: AppColor.primaryColor),),
                    const SizedBox(height: 30,),
                    Text(body,style: TextStyle(fontFamily: appFontFamily,fontSize: 14,fontWeight: FontWeight.w400,color: AppColor.FF050505),),
                    const SizedBox(height: 20,)
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: GestureDetector(
                  onTap: (){
                    Get.back();
                  },
                  child: Image.asset(Images.cancelIcon)),
            )
          ],
        );
      },
    );
  }

}
