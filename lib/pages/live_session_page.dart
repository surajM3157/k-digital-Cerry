import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:piwotapp/widgets/app_themes.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../constants/colors.dart';
import '../constants/images.dart';
import '../widgets/gradient_text.dart';


class LiveSessionPage extends StatefulWidget {
  const LiveSessionPage({super.key});

  @override
  State<LiveSessionPage> createState() => _LiveSessionPageState();
}

class _LiveSessionPageState extends State<LiveSessionPage> {


  bool isPlay = false;

  YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: 'HhEoZTw1m9A',
    flags: YoutubePlayerFlags(
      autoPlay: true,
      mute: true,
    ),
  );

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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  isPlay?
          YoutubePlayerBuilder(
            player: YoutubePlayer(
              controller: _controller,
              liveUIColor: AppColor.secondaryColor,
            ), builder: (context , player ) {
              return Column(
                children: [
                  player,
                  SizedBox(height: 50,),
                ],
              );
          },
          ):
                  Container(
                      width: Get.width,
                      height: 390,

                      child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(25),
                                bottomLeft: Radius.circular(25),
                              ),
                          child: Image.asset(Images.liveEventBanner,fit: BoxFit.cover,))),
                  isPlay?SizedBox.shrink():Align(
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
              isPlay?SizedBox.shrink():SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: GradientText(text:"Welcome Party",style: AppThemes.titleTextStyle().copyWith(
                    fontWeight: FontWeight.w600,fontSize: 24
                ), gradient: LinearGradient(colors: [AppColor.primaryColor,AppColor.red]),),
              ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                   Row(
                     children: [
                       SvgPicture.asset(Images.likeIcon,),
                       SizedBox(width: 5,),
                       Text("24.4 k",style: AppThemes.labelTextStyle().copyWith(color: AppColor.primaryColor),),
                       SizedBox(width: 10,),
                       SvgPicture.asset(Images.dislikeIcon,),
                       SizedBox(width: 5,),
                       Text("10",style: AppThemes.labelTextStyle().copyWith(color: AppColor.primaryColor),),

                     ],
                   ),
                    Row(
                      children: [
                        Image.asset(Images.participantsIcon,),
                        SizedBox(width: 5,),
                        Text("2K Participants",style: AppThemes.labelTextStyle().copyWith(color: AppColor.primaryColor),),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text("Bridging Innovation and Collaboration Worldwide. Connecting Minds, Shaping the Future.",style: AppThemes.subtitleTextStyle().copyWith(fontSize: 16),),
              )
            ],
          ),
        ),
      ),
    );
  }
}
