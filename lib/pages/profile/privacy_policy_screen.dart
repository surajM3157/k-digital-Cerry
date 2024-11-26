import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:piwotapp/responses/list_link_response.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../constants/colors.dart';
import '../../constants/font_family.dart';
import '../../constants/images.dart';
import '../../repository/api_repo.dart';
import '../../widgets/app_themes.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {


  ListLinkData? listLinkData;
  WebViewController? controller;
  bool isConnected = true;


  fetchPrivacyLink() async
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
     var response = await ApiRepo().getListLinksResponse(false);

      if( response.data != null)
      {
        listLinkData = response.data?[0];
        controller = WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..setNavigationDelegate(
            NavigationDelegate(
              onProgress: (int progress) {
                // Update loading bar.
              },
              onPageStarted: (String url) {},
              onPageFinished: (String url) {},
              onWebResourceError: (WebResourceError error) {},
            ),
          );

// Ensure the URL has a scheme
        String? url = listLinkData?.privacyPolicyLink;
        if (url == null || !url.startsWith('https')) {
          url = 'https://default-url.com'; // Set a default URL or handle as needed
        }else{
          url = listLinkData?.privacyPolicyLink;
        }

        controller?.loadRequest(Uri.parse(url!));
      }

      setState(() {

      });}

  }

  @override
  void initState() {
    fetchPrivacyLink();
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        isConnected = false;
      } else {
        // Handle case when internet connection is available
        isConnected = true;
        fetchPrivacyLink();
      }
    });
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
          child: Center(child: SvgPicture.asset(Images.logo, height: 40,width: 147)),
        ),
        leading: InkWell(
            onTap: (){
              Get.back();
            },
            child: Icon(Icons.arrow_back_ios,size: 20,color: AppColor.white,)),
      ),
      body: isConnected?listLinkData?.privacyPolicyLink != null? WebViewWidget(controller: controller!):const SizedBox.shrink():const Center(child: Text("OOPS! NO INTERNET.",style: TextStyle(color: Colors.black87,fontWeight: FontWeight.w600,fontFamily: appFontFamily,fontSize: 20),)),
    );
  }
}
