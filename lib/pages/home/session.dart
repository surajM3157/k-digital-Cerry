import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:piwotapp/constants/api_urls.dart';
import 'package:piwotapp/constants/colors.dart';
import 'package:get/get.dart';
import 'package:piwotapp/responses/session_list_response.dart';
import 'package:piwotapp/widgets/app_themes.dart';
import '../../constants/font_family.dart';
import '../../repository/api_repo.dart';
import '../../route/route_names.dart';
import '../../widgets/custom_tabbar_indicator.dart';
import '../session_details_page.dart';

class Session extends StatefulWidget {
  const Session({super.key});

  @override
  State<Session> createState() => _SessionState();
}

class _SessionState extends State<Session> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  SessionListResponse? sessionListResponse;

  List<SessionListData> conference = [];
  List<SessionListData> hackathon = [];
  List<SessionListData> startups = [];
  List<SessionListData> firesides = [];
  bool isConnected = true;

  String sessionDate = "17 Jan";

  fetchSessionList(String date) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      isConnected = false;
      setState(() {});
    } else {
      isConnected = true;
      conference.clear();
      hackathon.clear();
      startups.clear();
      firesides.clear();

      await Future.delayed(Duration.zero);
      // Future.delayed(Duration.zero, () {
      //   showLoader(context);
      // });

      var response = await ApiRepo().getSessionListResponse(date);

      if (response.data != null) {
        sessionListResponse = response;
        for (SessionListData session in sessionListResponse!.data!) {
          if (session.category?.toLowerCase() == "conference") {
            conference.add(session);
          } else if (session.category?.toLowerCase() == "hackathon") {
            hackathon.add(session);
          } else if (session.category?.toLowerCase() == "startup") {
            startups.add(session);
          } else {
            firesides.add(session);
          }
        }
      }

      setState(() {});
    }
  }

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    fetchSessionList("2025/01/17");
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        isConnected = false;
      } else {
        // Handle case when internet connection is available
        isConnected = true;
        fetchSessionList("2025/01/17");
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return isConnected
        ? RefreshIndicator(
            onRefresh: () async {
              fetchSessionList("2025/01/17");
            },
            color: AppColor.primaryColor,
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        sessionDate = "17 Jan";
                        conference.clear();
                        hackathon.clear();
                        startups.clear();
                        firesides.clear();
                        setState(() {});
                        fetchSessionList("2025/01/17");
                      },
                      child: sessionDate == "17 Jan"
                          ? Container(
                              height: 35,
                              width: 99,
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(8)),
                                  gradient: LinearGradient(
                                      colors: AppColor.gradientColors,
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight)),
                              child: Center(
                                child: Text(
                                  "17 Jan",
                                  style: TextStyle(
                                      fontFamily: appFontFamily,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: AppColor.white),
                                ),
                              ),
                            )
                          : Container(
                              height: 35,
                              width: 99,
                              padding: const EdgeInsets.all(1),
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(9)),
                                  gradient: LinearGradient(
                                      colors: AppColor.gradientColors,
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight)),
                              child: Container(
                                height: 35,
                                width: 99,
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(8)),
                                    color: AppColor.white),
                                child: Center(
                                  child: Text(
                                    "17 Jan",
                                    style: TextStyle(
                                        fontFamily: appFontFamily,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: AppColor.FF161616),
                                  ),
                                ),
                              ),
                            ),
                    ),
                    GestureDetector(
                      onTap: () {
                        sessionDate = "18 Jan";
                        conference.clear();
                        hackathon.clear();
                        startups.clear();
                        firesides.clear();
                        setState(() {});
                        fetchSessionList("2025/01/18");
                      },
                      child: sessionDate == "18 Jan"
                          ? Container(
                              height: 35,
                              width: 99,
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(8)),
                                  gradient: LinearGradient(
                                      colors: AppColor.gradientColors,
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight)),
                              child: Center(
                                child: Text(
                                  "18 Jan",
                                  style: TextStyle(
                                      fontFamily: appFontFamily,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: AppColor.white),
                                ),
                              ),
                            )
                          : Container(
                              height: 35,
                              width: 99,
                              padding: const EdgeInsets.all(1),
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(9)),
                                  gradient: LinearGradient(
                                      colors: AppColor.gradientColors,
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight)),
                              child: Container(
                                height: 35,
                                width: 99,
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(8)),
                                    color: AppColor.white),
                                child: Center(
                                  child: Text(
                                    "18 Jan",
                                    style: TextStyle(
                                        fontFamily: appFontFamily,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: AppColor.FF161616),
                                  ),
                                ),
                              ),
                            ),
                    ),
                    GestureDetector(
                      onTap: () {
                        sessionDate = "19 Jan";
                        conference.clear();
                        hackathon.clear();
                        startups.clear();
                        firesides.clear();
                        setState(() {});
                        fetchSessionList("2025/01/19");
                      },
                      child: sessionDate == "19 Jan"
                          ? Container(
                              height: 35,
                              width: 99,
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(8)),
                                  gradient: LinearGradient(
                                      colors: AppColor.gradientColors,
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight)),
                              child: Center(
                                child: Text(
                                  "19 Jan",
                                  style: TextStyle(
                                      fontFamily: appFontFamily,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: AppColor.white),
                                ),
                              ),
                            )
                          : Container(
                              height: 35,
                              width: 99,
                              padding: const EdgeInsets.all(1),
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(9)),
                                  gradient: LinearGradient(
                                      colors: AppColor.gradientColors,
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight)),
                              child: Container(
                                height: 35,
                                width: 99,
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(8)),
                                    color: AppColor.white),
                                child: Center(
                                  child: Text(
                                    "19 Jan",
                                    style: TextStyle(
                                        fontFamily: appFontFamily,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: AppColor.FF161616),
                                  ),
                                ),
                              ),
                            ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),

                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 16),
                //   child: DropdownButtonFormField<String>(
                //     iconEnabledColor: AppColor.primaryColor,
                //     iconDisabledColor: AppColor.primaryColor,
                //     items: items.map<DropdownMenuItem<String>>((String value) {
                //       return DropdownMenuItem<String>(
                //         value: value,
                //         child: Text(value),
                //       );
                //     }).toList(),
                //     onChanged: (value) {},
                //     iconSize: 30,
                //     decoration: InputDecoration(
                //       hintText: "Topics",
                //       labelText: "Topics",
                //       fillColor: AppColor.FFD9D6FD.withOpacity(0.28),
                //       filled: true,
                //       labelStyle:  TextStyle(color: AppColor.primaryColor,fontFamily: appFontFamily,fontWeight:FontWeight.w400,fontSize: 16),
                //       hintStyle:  TextStyle(color: AppColor.primaryColor,fontFamily: appFontFamily,fontWeight:FontWeight.w400,fontSize: 16),
                //       contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                //       focusedBorder:  OutlineInputBorder(
                //           borderRadius: BorderRadius.circular(10.0),
                //           borderSide: BorderSide(color: AppColor.black.withOpacity(0.12))
                //       ),
                //       enabledBorder:  OutlineInputBorder(
                //           borderRadius: BorderRadius.circular(10.0),
                //           borderSide: BorderSide(color: AppColor.black.withOpacity(0.12))
                //       ),
                //       errorBorder: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(10.0),
                //         borderSide: const BorderSide(color: Colors.red, width: 2.0),
                //       ),
                //       focusedErrorBorder: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(10.0),
                //         borderSide: const BorderSide(color: Colors.red, width: 2.0),
                //       ),
                //     ),
                //   ),
                // ),
                TabBar(
                  isScrollable: true,
                  controller: _tabController,
                  indicatorSize: TabBarIndicatorSize.label,
                  labelPadding: const EdgeInsets.symmetric(horizontal: 25),
                  indicatorColor: AppColor.primaryColor,
                  indicator: CustomUnderlineTabIndicator(
                    borderSide:
                        BorderSide(width: 3.0, color: AppColor.primaryColor),
                    insets: const EdgeInsets.symmetric(vertical: -8),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12.0),
                      topRight: Radius.circular(12.0),
                    ),
                  ),
                  tabs: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text(
                        "Conference",
                        style: AppThemes.labelTextStyle()
                            .copyWith(color: AppColor.primaryColor),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text("Hackathon",
                          style: AppThemes.labelTextStyle()
                              .copyWith(color: AppColor.primaryColor)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text("Startups",
                          style: AppThemes.labelTextStyle()
                              .copyWith(color: AppColor.primaryColor)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text("Firesides",
                          style: AppThemes.labelTextStyle()
                              .copyWith(color: AppColor.primaryColor)),
                    ),
                  ],
                ),
                Container(
                  height: 1,
                  width: Get.width,
                  color: AppColor.grey,
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: TabBarView(controller: _tabController, children: [
                    conference.isNotEmpty
                        ? ListView.builder(
                            itemCount: conference.length,
                            itemBuilder: (context, index) {
                              return sessionItem(conference[index]);
                            })
                        : Center(
                            child: Text(
                            "No Data Found",
                            style: AppThemes.appBarTitleStyle(),
                          )),
                    hackathon.isNotEmpty
                        ? ListView.builder(
                            itemCount: hackathon.length,
                            itemBuilder: (context, index) {
                              return sessionItem(hackathon[index]);
                            })
                        : Center(
                            child: Text(
                            "No Data Found",
                            style: AppThemes.appBarTitleStyle(),
                          )),
                    startups.isNotEmpty
                        ? ListView.builder(
                            itemCount: startups.length,
                            itemBuilder: (context, index) {
                              return sessionItem(startups[index]);
                            })
                        : Center(
                            child: Text(
                            "No Data Found",
                            style: AppThemes.appBarTitleStyle(),
                          )),
                    firesides.isNotEmpty
                        ? ListView.builder(
                            itemCount: firesides.length,
                            itemBuilder: (context, index) {
                              return sessionItem(firesides[index]);
                            })
                        : Center(
                            child: Text(
                            "No Data Found",
                            style: AppThemes.appBarTitleStyle(),
                          )),
                  ]),
                )
              ],
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
          ));
  }

  Widget sessionItem(SessionListData session) {
    return Stack(
      children: [
        Container(
          width: Get.width,
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.only(bottom: 20, top: 200),
          decoration: BoxDecoration(
              color: AppColor.lightestGrey,
              border: Border.all(color: AppColor.black.withOpacity(0.13)),
              borderRadius: const BorderRadius.all(Radius.circular(20))),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Text(
                  session.sessionName ?? "",
                  style: AppThemes.titleTextStyle()
                      .copyWith(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.date_range,
                      size: 17,
                      color: AppColor.primaryColor,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      DateFormat('dd MMMM yyyy')
                          .format(DateTime.parse(session.date ?? "")),
                      style: AppThemes.labelTextStyle().copyWith(
                          color: AppColor.black, fontWeight: FontWeight.w400),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.access_time_filled,
                      size: 17,
                      color: AppColor.primaryColor,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      session.time ?? "",
                      style: AppThemes.labelTextStyle().copyWith(
                          color: AppColor.black, fontWeight: FontWeight.w400),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [joinSessionButton(session)],
                )
              ],
            ),
          ),
        ),
        Container(
            width: Get.width,
            height: 200,
            margin: const EdgeInsets.all(10),
            child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                child: Image.network(
                  ApiUrls.imageUrl + (session.sessionImage ?? ""),
                  fit: BoxFit.cover,
                ))),
      ],
    );
  }

  Widget joinSessionButton(SessionListData sessionModel) {
    return InkWell(
      onTap: () {
        Get.to(SessionDetailsPage(
          title: sessionModel.sessionName,
          image: sessionModel.sessionImage,
        ));
        Get.toNamed(Routes.sessionDetails, arguments: {"data": sessionModel});
      },
      child: Container(
        height: 45,
        width: Get.width - 42,
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: AppColor.gradientColors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(8))),
        child: Center(
            child: Text(
          "View Details",
          style: AppThemes.titleTextStyle()
              .copyWith(color: AppColor.white, fontSize: 17),
        )),
      ),
    );
  }
}

class SessionModel {
  String image;
  String title;
  String date;
  String time;
  SessionModel(
      {required this.title,
      required this.image,
      required this.date,
      required this.time});
}
