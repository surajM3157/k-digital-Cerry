import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../constants/colors.dart';
import '../../constants/images.dart';
import '../../repository/api_repo.dart';
import '../../responses/list_link_response.dart';
import '../../widgets/app_themes.dart';

class TermsConditionScreen extends StatefulWidget {
  const TermsConditionScreen({super.key});

  @override
  State<TermsConditionScreen> createState() => _TermsConditionScreenState();
}

class _TermsConditionScreenState extends State<TermsConditionScreen> {

  ListLinkData? listLinkData;
  WebViewController? controller;

  fetchPrivacyLink() async
  {
    Future.delayed(Duration.zero, () {
      showLoader(context);
    });

    try{
      var response = await ApiRepo().getListLinksResponse();

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
        String? url = listLinkData?.termsAndConditionsLink;
        if (url == null || !url.startsWith('https')) {
          url = 'https://default-url.com'; // Set a default URL or handle as needed
        }else{
          url = listLinkData?.termsAndConditionsLink;
        }

        controller?.loadRequest(Uri.parse(url!));
      }

      setState(() {

      });

    }
    catch(e){}


    setState(() {});
  }

  @override
  void initState() {
    fetchPrivacyLink();


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
      body:  listLinkData?.privacyPolicyLink!=null?WebViewWidget(controller: controller!):CircularProgressIndicator(),
    );
  }
}
