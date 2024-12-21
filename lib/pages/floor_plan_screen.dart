import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:piwotapp/constants/api_urls.dart';
import 'package:piwotapp/constants/constants.dart';
import 'package:piwotapp/responses/floor_plan_response.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
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
  late PageController _pageController;

  List<int> _currentPages = [];

  fetchFloorPlan() async {
    Future.delayed(Duration.zero, () {
      showLoader(context);
    });

    var response = await ApiRepo().getFloorPlanResponse();

    floorPlanList.clear();
    if (response.data != null) {
      _floorPlanResponse = response;
      for (FloorPlanData floorPlan in _floorPlanResponse!.data!) {
        floorPlanList.add(floorPlan);
      }
      // Initialize the list of current page indices for each item
      _currentPages = List.generate(floorPlanList.length, (index) => 0);
      print("floorPlanList ${floorPlanList.length}");
    }

    setState(() {});
  }

  @override
  void initState() {
    _pageController = PageController(viewportFraction: 1.0);
    fetchFloorPlan();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Widget _buildIndicatorDots(int currentPage, int itemCount) {
    List<Widget> dots = [];
    for (int i = 0; i < itemCount; i++) {
      dots.add(
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 5),
          height: 42,
          width: 12,
          decoration: BoxDecoration(
            color: currentPage == i ? AppColor.primaryColor : Colors.grey,
            shape: BoxShape.circle,
          ),
        ),
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: dots,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColor.primaryColor,
        title: Padding(
          padding: const EdgeInsets.only(right: 60),
          child: Center(child: SvgPicture.asset(Images.logo, height: 40, width: 147)),
        ),
        leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: Icon(Icons.arrow_back_ios, size: 20, color: AppColor.white)
        ),
      ),
      body: RefreshIndicator(
        color: AppColor.primaryColor,
        onRefresh: () async {
          fetchFloorPlan();
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 18),
              Center(
                child: GradientText(
                  text: "Floor Plan",
                  style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 20, fontFamily: appFontFamily),
                  gradient: LinearGradient(
                    colors: AppColor.gradientColors,
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
              ),

              const SizedBox(height: 15),

              floorPlanList.isNotEmpty ? ListView.separated(
                itemCount: floorPlanList.length,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: GradientText(
                                text: "${capitalizeText(floorPlanList[index].floorName?.toLowerCase() ?? "")} Floor",
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 17,
                                  fontFamily: appFontFamily,
                                ),
                                gradient: LinearGradient(
                                  colors: AppColor.gradientColors,
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 5),

                        SizedBox(
                          height: 250,
                          child: PageView.builder(
                            controller: _pageController,
                            itemCount: floorPlanList[index].floorPlanImage?.length ?? 0,
                            itemBuilder: (context, imageIndex) {
                              return GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Dialog(
                                        backgroundColor: Colors.transparent,
                                        child: Stack(
                                          children: [
                                            PhotoViewGallery.builder(
                                              itemCount: floorPlanList[index].floorPlanImage?.length ?? 0,
                                              builder: (context, imageIndex) {
                                                return PhotoViewGalleryPageOptions(
                                                  imageProvider: NetworkImage(ApiUrls.imageUrl +
                                                      (floorPlanList[index].floorPlanImage?[imageIndex] ?? "")),
                                                  minScale: PhotoViewComputedScale.contained,
                                                  maxScale: PhotoViewComputedScale.covered,
                                                );
                                              },
                                              scrollPhysics: const BouncingScrollPhysics(),
                                              backgroundDecoration: const BoxDecoration(color: Colors.transparent),  // Make background transparent
                                              pageController: PageController(initialPage: imageIndex),
                                            ),
                                            Align(
                                              alignment: Alignment.bottomCenter,
                                              child: GestureDetector(
                                                onTap: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: Container(
                                                  margin: const EdgeInsets.all(16),
                                                  padding: const EdgeInsets.all(12),
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.white,
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.black.withOpacity(0.3),
                                                        blurRadius: 6,
                                                        offset: const Offset(0, 3),
                                                      ),
                                                    ],
                                                  ),
                                                  child: const Icon(Icons.close, color: Colors.black),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Card(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                                  elevation: 5,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(0),
                                    child: Image.network(
                                      ApiUrls.imageUrl +
                                          (floorPlanList[index].floorPlanImage?[imageIndex] ?? ""),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              );
                            },
                            onPageChanged: (pageIndex) {
                              setState(() {
                                _currentPages[index] = pageIndex;
                              });
                            },
                          ),
                        ),
                        _buildIndicatorDots(_currentPages[index], floorPlanList[index].floorPlanImage?.length ?? 0),
                      ],
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(height: 1);
                },
              ) : Center(
                child: Text(
                  "No Data Found",
                  style: AppThemes.appBarTitleStyle(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}