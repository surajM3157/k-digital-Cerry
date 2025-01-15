import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:piwotapp/constants/api_urls.dart';
import 'package:piwotapp/responses/speaker_response.dart';
import '../../constants/colors.dart';
import '../../constants/font_family.dart';
import '../../constants/images.dart';
import '../../repository/api_repo.dart';
import '../../widgets/app_themes.dart';
import '../../widgets/gradient_text.dart';

class SpeakerPage extends StatefulWidget {
  const SpeakerPage({super.key});

  @override
  State<SpeakerPage> createState() => _SpeakerPageState();
}

class _SpeakerPageState extends State<SpeakerPage> {
  TextEditingController searchController = TextEditingController();
  SpeakerResponse? speakerResponse;

  List<SpeakerData> speakerList = [];
  Timer? debounceTimer;
  bool isConnected = true;
  bool isLoading = true;

  @override
  void initState() {
    fetchSpeakerList("");
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        isConnected = false;
      } else {
        // Handle case when internet connection is available
        isConnected = true;
        fetchSpeakerList("");
      }
    });
    super.initState();
  }

  void onSearchChanged(String query) {
    speakerList.clear();
    isLoading = true;
    setState(() {});
    if (debounceTimer?.isActive ?? false) debounceTimer!.cancel();
    debounceTimer = Timer(const Duration(milliseconds: 500), () {
      fetchSpeakerList(searchController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColor.primaryColor,
        title: Padding(
          padding: const EdgeInsets.only(right: 60),
          child: Center(
              child: SvgPicture.asset(Images.logo, height: 40, width: 147)),
        ),
        leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_back_ios,
              size: 20,
              color: AppColor.white,
            )),
      ),
      body: isConnected
          ? RefreshIndicator(
              onRefresh: () async {
                fetchSpeakerList("");
              },
              color: AppColor.primaryColor,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: GradientText(
                          text: "PanIIT - 2025 Speakers ",
                          style: const TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w600,
                              fontFamily: appFontFamily),
                          gradient: LinearGradient(
                            colors: AppColor.gradientColors,
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          )),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 11),
                      child: TextFormField(
                        controller: searchController,
                        onChanged: onSearchChanged,
                        cursorColor: AppColor.primaryColor,
                        decoration: InputDecoration(
                          hintText: "Search Speaker",
                          hintStyle: TextStyle(
                            fontFamily: appFontFamily,
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: AppColor.black.withOpacity(0.50),
                          ),
                          // Modify the suffix icon container size
                          suffixIcon: Container(
                            height:
                                40, // Modify the height of the suffix icon container
                            width:
                                40, // Modify the width of the suffix icon container
                            decoration: BoxDecoration(
                              color: AppColor.primaryColor,
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(8),
                                bottomRight: Radius.circular(8),
                              ),
                            ),
                            child: Center(
                              child: Icon(
                                Icons.search_rounded,
                                color: AppColor.white,
                                size: 20, // Modify the size of the search icon
                              ),
                            ),
                          ),
                          // Modify the TextFormField container size
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 15,
                              horizontal:
                                  10), // Adjust padding inside the TextFormField
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              width: 0.5,
                              color: AppColor.black.withOpacity(0.10),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              width: 0.5,
                              color: AppColor.black.withOpacity(0.10),
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 11),
                    //   child: TextFormField(
                    //     controller: searchController,
                    //     onChanged: onSearchChanged,
                    //     cursorColor: AppColor.primaryColor,
                    //     decoration: InputDecoration(
                    //       hintText: "Search Speaker",
                    //       hintStyle: TextStyle(
                    //           fontFamily: appFontFamily,
                    //           fontWeight: FontWeight.w400,
                    //           fontSize: 14,
                    //           color: AppColor.black.withOpacity(0.50)),
                    //       suffixIcon: Container(
                    //         height: 60,
                    //         width: 60,
                    //         decoration: BoxDecoration(
                    //             color: AppColor.primaryColor,
                    //             borderRadius: const BorderRadius.only(
                    //                 topRight: Radius.circular(8),
                    //                 bottomRight: Radius.circular(8))),
                    //         child: Center(
                    //             child: Icon(
                    //           Icons.search_rounded,
                    //           color: AppColor.white,
                    //         )),
                    //       ),
                    //       enabledBorder: OutlineInputBorder(
                    //           borderRadius: BorderRadius.circular(8),
                    //           borderSide: BorderSide(
                    //               width: 0.5,
                    //               color: AppColor.black.withOpacity(0.10))),
                    //       focusedBorder: OutlineInputBorder(
                    //           borderRadius: BorderRadius.circular(8),
                    //           borderSide: BorderSide(
                    //               width: 0.5,
                    //               color: AppColor.black.withOpacity(0.10))),
                    //     ),
                    //   ),
                    // ),
                    const SizedBox(
                      height: 2,
                    ),
                    speakerList.isEmpty && isLoading == false
                        ? Center(
                            child: Text(
                            "No Data Found.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: AppColor.primaryColor,
                                fontWeight: FontWeight.w600,
                                fontFamily: appFontFamily,
                                fontSize: 20),
                          ))
                        : ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: speakerList.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  speakerDetails(
                                      title:
                                          speakerList[index].speakerName ?? "",
                                      subtitle:
                                          speakerList[index].designation ?? "",
                                      body: speakerList[index].bio ?? "",
                                      image: speakerList[index].speakerImage ??
                                          "");
                                },
                                child: Stack(
                                  alignment: Alignment.bottomCenter,
                                  clipBehavior: Clip.none,
                                  children: [
                                    Container(
                                      width: Get.width,
                                      height: 325,
                                      margin: const EdgeInsets.all(23),
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10)),
                                          // gradient: LinearGradient(
                                          //   colors: AppColor.gradientColors,
                                          //   begin: Alignment.centerLeft,
                                          //   end: Alignment.centerRight,
                                          // )
                                          color: AppColor.white),
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.network(
                                            ApiUrls.imageUrl +
                                                (speakerList[index]
                                                        .speakerImage ??
                                                    ""),
                                            fit: BoxFit.fill,
                                          )),
                                    ),
                                    Positioned(
                                      bottom: -1,
                                      left: 34,
                                      right: 34,
                                      child: Container(
                                        // height: 102,
                                        width: Get.width,
                                        decoration: BoxDecoration(
                                            color: AppColor.black
                                                .withOpacity(0.85),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(10))),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                speakerList[index]
                                                        .speakerName ??
                                                    "",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w600,
                                                    color: AppColor.white,
                                                    fontFamily: appFontFamily),
                                              ),
                                              Text(
                                                speakerList[index]
                                                        .designation ??
                                                    "",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                    color: AppColor.white,
                                                    fontFamily: appFontFamily),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return const SizedBox(
                                height: 2,
                              );
                            },
                          ),
                    const SizedBox(
                      height: 50,
                    )
                  ],
                ),
              ),
            )
          : const Center(
              child: Text(
              "OOPS! NO INTERNET.",
              style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                  fontFamily: appFontFamily,
                  fontSize: 20),
            )),
    );
  }

  speakerDetails(
      {required String title,
      required String subtitle,
      required String body,
      required String image}) {
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
              height: Get.height / 1.5,
              decoration: BoxDecoration(
                  color: AppColor.white,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight: Radius.circular(32))),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      width: 148,
                      height: 156,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        gradient:
                            LinearGradient(colors: AppColor.gradientColors),
                      ),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.network(
                            ApiUrls.imageUrl + image,
                            fit: BoxFit.fill,
                          )),
                    ),
                    // const SizedBox(height: 10,),
                    // Row(
                    //   children: [
                    //     Icon(Icons.flag,color: AppColor.FF050505,),
                    //     const SizedBox(width: 5,),
                    //     Text("India",style: TextStyle(fontFamily: appFontFamily,fontSize: 14,fontWeight: FontWeight.w400,color: AppColor.FF444444),)
                    //   ],
                    // ),
                    const SizedBox(
                      height: 20,
                    ),
                    GradientText(
                      text: title,
                      style: const TextStyle(
                          fontFamily: appFontFamily,
                          fontSize: 16,
                          fontWeight: FontWeight.w700),
                      gradient: LinearGradient(colors: AppColor.gradientColors),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      subtitle,
                      style: TextStyle(
                          fontFamily: appFontFamily,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: AppColor.FF161616),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      body,
                      style: TextStyle(
                          fontFamily: appFontFamily,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColor.FF050505),
                    ),
                    const SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Image.asset(Images.cancelIcon)),
            )
          ],
        );
      },
    );
  }
  fetchSpeakerList(String search) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      isConnected = false;
      setState(() {});
    } else {
      isConnected = true;
      setState(() {
        isLoading = true;
      });

      speakerList.clear();
      Future.delayed(Duration.zero, () {
        showLoader(context); // Show loading indicator
      });

      // Fetch all speakers without any search query
      var response = await ApiRepo().getSpeakerResponse("", false);

      if (response.data != null) {
        speakerResponse = response;

        // Trim the search query and convert to lowercase
        String trimmedSearch = search.trim().toLowerCase();

        // Debugging: Print the trimmed search query
        print("Searching for: $trimmedSearch");

        // Filter speakers based on both name and designation locally
        for (SpeakerData speaker in speakerResponse!.data!) {
          // Trim and convert name and designation to lowercase
          String speakerName = speaker.speakerName?.toLowerCase() ?? "";
          String speakerDesignation = speaker.designation?.toLowerCase() ?? "";

          // Debugging: Print speaker's name and designation (lowercased)
          print("Speaker Name: $speakerName");
          print("Speaker Designation: $speakerDesignation");

          bool isNameMatch = speakerName.contains(trimmedSearch);
          bool isDesignationMatch = speakerDesignation.contains(trimmedSearch);

          // Debugging: Print search results for each field
          print("Name Match: $isNameMatch, Designation Match: $isDesignationMatch");

          // Check if either name or designation matches the search query
          if (isNameMatch || isDesignationMatch) {
            speakerList.add(speaker);
          }
        }

        // Debugging: Print number of speakers found
        print("Found ${speakerList.length} matching speakers.");

        isLoading = false;
      }

      setState(() {});
    }
  }

}
