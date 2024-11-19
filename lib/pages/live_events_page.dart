import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:piwotapp/constants/font_family.dart';
import '../constants/colors.dart';
import '../constants/images.dart';
import '../repository/api_repo.dart';
import '../responses/live_session_response.dart';
import '../route/route_names.dart';
import '../widgets/app_themes.dart';
import '../widgets/gradient_text.dart';
import '../widgets/youtube_thumbnail.dart';

class LiveEventsPage extends StatefulWidget {
  const LiveEventsPage({super.key});

  @override
  State<LiveEventsPage> createState() => _LiveEventsPageState();
}

class _LiveEventsPageState extends State<LiveEventsPage> {

  LiveSessionResponse? liveSessionResponse;
  List<LiveSessionData> liveSessions = [];
  bool isConnected = true;


  fetchLiveSessionList() async
  {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      isConnected = false;
      setState(() {

      });
    }else {
      isConnected = true;
      liveSessions.clear();
      Future.delayed(Duration.zero, () {
        showLoader(context);
      });

      var response = await ApiRepo().getLiveSessionResponse(false);

      if (response.data != null) {
        liveSessionResponse = response;
        for (LiveSessionData live in liveSessionResponse!.data!) {
          liveSessions.add(live);
        }
        print("liveSessions ${liveSessions.length}");
      }

      setState(() {

      });
    }
  }

  @override
  void initState() {
    fetchLiveSessionList();
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        isConnected = false;
      } else {
        // Handle case when internet connection is available
        isConnected = true;
        fetchLiveSessionList();
      }
    });
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
      body: isConnected?RefreshIndicator(
        color: AppColor.primaryColor,
        onRefresh: () async{
          fetchLiveSessionList();
        },
        child: ListView(
          children: [
            const SizedBox(height: 12,),
            Center(child: GradientText(text:"Live Event",style: const TextStyle(fontFamily: appFontFamily,fontSize: 20,fontWeight: FontWeight.w600), gradient: LinearGradient(colors: AppColor.gradientColors),)),
            const SizedBox(height: 33,),

           liveSessions.isNotEmpty? ListView.separated(
              itemCount: liveSessions.length,
                shrinkWrap: true,physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index){
                  return liveSessions[index].link!.contains("=")? Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: AppColor.FF646464.withOpacity(0.3))
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                            borderRadius:BorderRadius.circular(8),
                            child: SizedBox(
                                height: 120,width: 113,
                                child: YouTubeThumbnail(
                                  youtubeUrl: liveSessions[index].link??"", // Replace with your YouTube link
                                ))),
                        const SizedBox(width: 15,),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GradientText(text:liveSessions[index].title??"",style: const TextStyle(fontWeight: FontWeight.w600,fontSize: 14,fontFamily: appFontFamily,), gradient: LinearGradient(
                                colors: AppColor.gradientColors
                              ),),
                              // const SizedBox(height: 5,),
                              // Text(liveSessions[index].description??"",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 10,fontFamily: appFontFamily,color: AppColor.FF161616)),
                              const SizedBox(height: 13,),
                              Row(
                                children: [
                                  SvgPicture.asset(Images.calendarIcon),
                                  const SizedBox(width: 2,),
                                   Text(DateFormat("dd, MMM yyyy").format(DateTime.parse(liveSessions[index].eventDate??"")),style: const TextStyle(fontFamily: appFontFamily,fontSize: 10,fontWeight: FontWeight.w600),)
                                ],
                              ),
                              // const SizedBox(height: 10,),
                              // Row(
                              //   children: [
                              //     SvgPicture.asset(Images.participantIcon),
                              //     const SizedBox(width: 2,),
                              //     const Text("30k Participants",style: TextStyle(fontFamily: appFontFamily,fontSize: 10,fontWeight: FontWeight.w600),)
                              //   ],
                              // ),
                              const SizedBox(height: 10,),
                              GestureDetector(
                                onTap: (){
                                  Get.toNamed(Routes.liveSession,arguments: {
                                    "data":liveSessions[index]
                                  });
                                },
                                child: Container(
                                  width: 87,height: 27,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7),
                                    color: AppColor.red
                                  ),
                                  child: Center(child: Text("Watch Now",style: TextStyle(fontFamily: appFontFamily,fontSize: 12,fontWeight: FontWeight.w600,color: AppColor.white),)),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ):const SizedBox.shrink();
                }, separatorBuilder: (BuildContext context, int index) { return const SizedBox(height: 16,); },):const SizedBox.shrink()
          ],
        ),
      ):const Center(child: Text("OOPS! NO INTERNET.",style: TextStyle(color: Colors.black87,fontWeight: FontWeight.w600,fontFamily: appFontFamily,fontSize: 20),)),
    );
  }
}
