import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:piwotapp/responses/live_session_response.dart';
import 'package:piwotapp/widgets/app_themes.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../constants/colors.dart';
import '../constants/font_family.dart';
import '../constants/images.dart';
import '../widgets/gradient_text.dart';
import '../widgets/youtube_thumbnail.dart';


class LiveSessionPage extends StatefulWidget {
  const LiveSessionPage({super.key});

  @override
  State<LiveSessionPage> createState() => _LiveSessionPageState();
}

class _LiveSessionPageState extends State<LiveSessionPage> {

  LiveSessionData? liveSessionData;
  bool isFullScreen = false;
  bool isPlay = false;

   YoutubePlayerController? _controller;

  @override
  void initState() {
    liveSessionData = Get.arguments["data"];
    _controller = YoutubePlayerController(
      initialVideoId: (liveSessionData?.link?.split("=").last??""),
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: true,
      ),
    );

    // Listener to handle full-screen mode changes
    _controller!.addListener(() {
      setState(() {
        isFullScreen = _controller!.value.isFullScreen;
      });

      if (isFullScreen) {
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.landscapeRight,
          DeviceOrientation.landscapeLeft,
        ]);
      } else {
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
        SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller!.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isFullScreen
          ? null:AppBar(
        elevation: 0,
        backgroundColor: AppColor.primaryColor,
        title: Padding(
          padding: const EdgeInsets.only(right: 60),
          child: Center(child: SvgPicture.asset(Images.logo, height: 40,width: 147)),
        ),
        leading: InkWell(
            onTap: (){
              SystemChrome.setPreferredOrientations([
                DeviceOrientation.portraitUp, // Locks the app to portrait mode
                // DeviceOrientation.landscapeLeft, // Uncomment this line to lock to landscape mode
                // DeviceOrientation.landscapeRight,
              ]);
              Get.back();
            },
            child: Icon(Icons.arrow_back_ios,size: 20,color: AppColor.white,)),
      ),
      body: SafeArea(
        child:isFullScreen
            ? _buildVideoPlayer():
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  isPlay?
          YoutubePlayerBuilder(
            player: YoutubePlayer(
              controller: _controller!,
              liveUIColor: AppColor.secondaryColor,
            ), builder: (context , player ) {
              return Column(
                children: [
                  player,
                  const SizedBox(height: 50,),
                ],
              );
          },
          ):
                  SizedBox(
                      width: Get.width,
                      height: 390,
                      child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                bottomRight: Radius.circular(25),
                                bottomLeft: Radius.circular(25),
                              ),
                          child: YouTubeThumbnail(
                            youtubeUrl: liveSessionData?.link?.split("=").last??"", // Replace with your YouTube link
                          ))),
                  isPlay?const SizedBox.shrink():Align(
                    alignment: Alignment.topCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 150),
                        child: InkWell(
                          onTap: (){
                            isPlay = true;
                            setState(() {
                            });
                          },
                            child: SvgPicture.asset(Images.playBtnIcon)),
                      )),
                ],
              ),
              isPlay?const SizedBox.shrink():const SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: GradientText(text:liveSessionData?.title??"",style: AppThemes.titleTextStyle().copyWith(
                    fontWeight: FontWeight.w600,fontSize: 24
                ), gradient: LinearGradient(colors: [AppColor.primaryColor,AppColor.red]),),
              ),
              const SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    SvgPicture.asset(Images.calendarIcon),
                    const SizedBox(width: 2,),
                    Text(DateFormat("dd, MMM yyyy").format(DateTime.parse(liveSessionData?.eventDate??"")),style: const TextStyle(fontFamily: appFontFamily,fontSize: 14,fontWeight: FontWeight.w600),)
                  ],
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 20),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //      Row(
              //        children: [
              //          SvgPicture.asset(Images.likeIcon,),
              //          const SizedBox(width: 5,),
              //          Text("24.4 k",style: AppThemes.labelTextStyle().copyWith(color: AppColor.primaryColor),),
              //          const SizedBox(width: 10,),
              //          SvgPicture.asset(Images.dislikeIcon,),
              //          const SizedBox(width: 5,),
              //          Text("10",style: AppThemes.labelTextStyle().copyWith(color: AppColor.primaryColor),),
              //
              //        ],
              //      ),
              //       Row(
              //         children: [
              //           Image.asset(Images.participantsIcon,),
              //           const SizedBox(width: 5,),
              //           Text("2K Participants",style: AppThemes.labelTextStyle().copyWith(color: AppColor.primaryColor),),
              //         ],
              //       )
              //     ],
              //   ),
              // ),
              const SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(liveSessionData?.description??"",style: AppThemes.subtitleTextStyle().copyWith(fontSize: 16),),
              )
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildVideoPlayer() {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _controller!,
        liveUIColor: AppColor.secondaryColor,
      ),
      builder: (context, player) {
        return Column(
          children: [
            player,
            const SizedBox(height: 50),
          ],
        );
      },
    );
  }
}

