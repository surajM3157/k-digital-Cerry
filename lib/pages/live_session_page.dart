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
  Duration? currentPosition;

  @override
  void initState() {
    super.initState();
    liveSessionData = Get.arguments["data"];
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(liveSessionData?.link ?? "") ?? "",
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: true,
      ),
    );

    // Listener to handle full-screen mode changes
    _controller!.addListener(() {
      setState(() {
        isFullScreen = _controller!.value.isFullScreen;
        currentPosition = _controller!.value.position;
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
  }

  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);
    _controller!.seekTo(_controller!.value.position);
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
          ? null
          : AppBar(
        elevation: 0,
        backgroundColor: AppColor.primaryColor,
        title: Padding(
          padding: const EdgeInsets.only(right: 60),
          child: Center(child: SvgPicture.asset(Images.logo, height: 40, width: 147)),
        ),
        leading: InkWell(
          onTap: () {
            SystemChrome.setPreferredOrientations([
              DeviceOrientation.portraitUp,
            ]);
            Get.back();
          },
          child: Icon(Icons.arrow_back_ios, size: 20, color: AppColor.white),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding:isFullScreen
              ?  const EdgeInsets.only(top: 27, bottom: 27):EdgeInsets.zero,
          child: YoutubePlayerBuilder(
            player: YoutubePlayer(
              controller: _controller!,
              liveUIColor: AppColor.secondaryColor,
            ),
            builder: (context, player) {
              return isFullScreen
                  ? player
                  : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        isPlay
                            ? player
                            : SizedBox(
                          width: Get.width,
                          height: 390,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              bottomRight: Radius.circular(25),
                              bottomLeft: Radius.circular(25),
                            ),
                            child: YouTubeThumbnail(
                              youtubeUrl: liveSessionData?.link ?? "",
                            ),
                          ),
                        ),
                        isPlay
                            ? const SizedBox.shrink()
                            : Align(
                          alignment: Alignment.topCenter,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 150),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  isPlay = true;
                                });
                              },
                              child: SvgPicture.asset(Images.playBtnIcon),
                            ),
                          ),
                        ),
                      ],
                    ),
                    isPlay ? const SizedBox.shrink() : const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: GradientText(
                        text: liveSessionData?.title ?? "",
                        style: AppThemes.titleTextStyle().copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 24,
                        ),
                        gradient: LinearGradient(colors: AppColor.gradientColors),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          SvgPicture.asset(Images.calendarIcon),
                          const SizedBox(width: 2),
                          Text(
                            DateFormat("dd, MMM yyyy").format(DateTime.parse(liveSessionData?.eventDate ?? "")),
                            style: const TextStyle(
                              fontFamily: appFontFamily,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        liveSessionData?.description ?? "",
                        style: AppThemes.subtitleTextStyle().copyWith(fontSize: 16),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}


