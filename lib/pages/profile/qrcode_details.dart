import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart'; // For easy loading
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../constants/api_urls.dart';
import '../../constants/font_family.dart';
import '../../constants/images.dart';
import '../../responses/qrcode_response.dart';
import '../../route/route_names.dart';
import '../../shared prefs/pref_manager.dart';
import 'package:http/http.dart' as http;

class QRDetailsScreen extends StatelessWidget {
  final QRCodeResponse qrCodeDetails;

  const QRDetailsScreen({Key? key, required this.qrCodeDetails}) : super(key: key);

  sendRequest(String receiverId) async {
    try {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.none) {
        EasyLoading.showToast("No Internet",
            dismissOnTap: true, duration: const Duration(seconds: 1), toastPosition: EasyLoadingToastPosition.center);
        return;
      } else {
        print("Receiver ID: $receiverId");

        print("From ID: ${Prefs.checkUserId}");

        Map<String, String> params = <String, String>{};
        params["from"] = Prefs.checkUserId;
        params["to"] = receiverId;

        final response = await http.post(
          Uri.parse(ApiUrls.sendRequestApiUrl),
          body: params,
          headers: {
            'token': '${Prefs.checkAuthToken}',  // Assuming token from Prefs
          },
        );

        if (response.statusCode == 200) {
          var res = json.decode(response.body);
          EasyLoading.showToast("${res['message']}",
              dismissOnTap: true, duration: const Duration(seconds: 2), toastPosition: EasyLoadingToastPosition.center);
          print("Request Sent to $receiverId");

          Future.delayed(const Duration(seconds: 1), () {
            Get.offAllNamed(Routes.home); // Redirect to home page after 2 seconds
          });
        } else {
          var res = json.decode(response.body);
          EasyLoading.showToast("${res['message']}",
              dismissOnTap: true, duration: const Duration(seconds: 2), toastPosition: EasyLoadingToastPosition.center);
          print("Request failed: ${res['message']}");
        }
      }
    } catch (e) {
      print("Request error: $e");
      EasyLoading.showToast("Something went wrong!",
          dismissOnTap: true, duration: const Duration(seconds: 2), toastPosition: EasyLoadingToastPosition.center);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF1B1464),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
        title: const Center(
          child: Padding(
            padding: EdgeInsets.only(right: 60),
            child: Text(
              "QR Code Details",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 50),
            // Image
            SvgPicture.asset(Images.logoDark,
              height: 60,
              width: 80,
            ),
            const SizedBox(height: 40),

            Center(
              child: Text(
                '${qrCodeDetails.data?.firstName ?? ""} ${qrCodeDetails.data?.lastName ?? ""}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFF1B1464), // appColor
                  fontWeight: FontWeight.w600,
                  fontSize: 30,
                ),
              ),
            ),

            const SizedBox(height: 10),

            Center(
              child: Container(
                width: 200,
                height: 3,
                color: Colors.black,
              ),
            ),

            const SizedBox(height: 20),

            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: "Company : ",
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  fontFamily: 'Roboto',
                ),
                children: [
                  TextSpan(
                    text: qrCodeDetails.data?.companyName ?? "-",
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      fontFamily: 'Roboto',
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 15),

            // Designation if available
            if (qrCodeDetails.data?.designation != null)
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: "Designation : ",
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    fontFamily: 'Roboto',
                  ),
                  children: [
                    TextSpan(
                      text: qrCodeDetails.data?.designation ?? "-",
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        fontFamily: 'Roboto',
                      ),
                    ),
                  ],
                ),
              ),

            const SizedBox(height: 15),

            if (qrCodeDetails.data?.alumniOfIit == true)
              Column(
                children: [
                  Text(
                    'IIT Alumni : ${qrCodeDetails.data?.iitName ?? "-"}',
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 7),

                  Text(
                    'Stream : ${qrCodeDetails.data?.stream ?? "-"}',
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 7),

                  Text(
                    'Batch : ${qrCodeDetails.data?.batch?.toString() ?? "-"}',
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),

            const SizedBox(height: 20),

            // Connect button
            ElevatedButton(
              onPressed: () async {
                print("QR Code Response: ${jsonEncode(qrCodeDetails)}");
                // Print the receiverId to check if it is populated
                print("Receiver ID: ${qrCodeDetails.data?.id}");

                // Check if receiverId exists and print the value
                if (qrCodeDetails.data?.id != null) {
                  // Show loading indicator
                  EasyLoading.show(status: 'Sending request...');

                  // Call sendRequest method
                  await sendRequest(qrCodeDetails.data!.id!);

                  // After sending request, show success or failure message based on response
                  EasyLoading.showToast('Request sent successfully!',
                      dismissOnTap: true,
                      duration: const Duration(seconds: 1),
                      toastPosition: EasyLoadingToastPosition.center);
                } else {
                  // If receiverId is null, print the debug message
                  print("Receiver ID is null or missing");

                  // Show error message
                  EasyLoading.showToast('Failed to send request! Receiver ID is missing.',
                      dismissOnTap: true,
                      duration: const Duration(seconds: 2),
                      toastPosition: EasyLoadingToastPosition.center);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1B1464),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
              child: const Text('Connect', style: TextStyle(color: Colors.white, fontFamily: appFontFamily, fontSize: 17)),
            )

          ],
        ),
      ),
    );
  }
}
