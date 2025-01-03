import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:piwotapp/constants/constants.dart';
import '../../constants/colors.dart';
import 'package:get/get.dart';
import '../../constants/font_family.dart';
import '../../constants/images.dart';
import '../../repository/api_repo.dart';
import '../../responses/guest_details_response.dart';
import '../../widgets/app_themes.dart';
import '../../widgets/gradient_text.dart';

class TicketPage extends StatefulWidget {
  const TicketPage({super.key});

  @override
  State<TicketPage> createState() => _TicketPageState();
}

class _TicketPageState extends State<TicketPage> {
  GuestDetailsData? guestDetails;
  bool isConnected = true;
  String qrLink = '';

  fetchGuestDetails() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      isConnected = false;
      setState(() {});
    } else {
      isConnected = true;

      Future.delayed(Duration.zero, () {
        showLoader(context);
      });

      var response = await ApiRepo().getGuestDetailsResponse();

      if (response.data != null) {
        guestDetails = response.data;
      }

      setState(() {});
    }
  }

  fetchQRCode() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      isConnected = false;
      setState(() {});
    } else {
      isConnected = true;

      var response = await ApiRepo().getQRCodeResponse();

      if (response != null) {
        qrLink = response;
      }

      setState(() {});
    }
  }

  @override
  void initState() {
    fetchQRCode();
    fetchGuestDetails();
    super.initState();
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
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Center(
            child: GradientText(
              text: "QR Code Badge",
              style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  fontFamily: appFontFamily),
              gradient: LinearGradient(
                colors: AppColor.gradientColors,
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
          ),
          Container(
            width: Get.width,
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: AppColor.gradientColors),
                borderRadius: const BorderRadius.all(Radius.circular(12))),
            child: Container(
              width: 288,
              padding: const EdgeInsets.only(
                  top: 0, bottom: 20, left: 10, right: 10),
              decoration: BoxDecoration(
                  color: AppColor.white,
                  borderRadius: const BorderRadius.all(Radius.circular(12))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  qrLink.isNotEmpty
                      ? ClipRRect(
                          borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(12),
                              topLeft: Radius.circular(12)),
                          child: Image.network(
                            qrLink,
                            height: 250,
                            width: 288,
                            fit: BoxFit.fill,
                          ))
                      : const SizedBox.shrink(),
                  Text(
                    "${guestDetails?.firstName ?? ""} ${guestDetails?.lastName ?? ""}",
                    style: AppThemes.titleTextStyle(),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: 2,
                    width: 200,
                    decoration: BoxDecoration(
                        gradient:
                            LinearGradient(colors: AppColor.gradientColors)),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(guestDetails?.companyName ?? "",
                      style: AppThemes.subtitleTextStyle()
                          .copyWith(color: AppColor.FF161616, fontSize: 16)),
                  const SizedBox(
                    height: 7,
                  ),
                  Text(capitalizeText(guestDetails?.designation ?? ""),
                      style: AppThemes.subtitleTextStyle()
                          .copyWith(color: AppColor.FF161616, fontSize: 16)),
                  const SizedBox(
                    height: 7,
                  ),
                  (guestDetails?.alumniOfIit ?? false)
                      ? Text(
                          '${guestDetails?.iitName ?? ""}, ${guestDetails?.batch ?? ""}',
                          style: AppThemes.subtitleTextStyle()
                              .copyWith(color: AppColor.FF161616, fontSize: 16))
                      : const SizedBox.shrink()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
