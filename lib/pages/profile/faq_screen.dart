import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Importing Clipboard functionality
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart'; // Importing url_launcher to handle mailto
import 'package:piwotapp/constants/font_family.dart';
import 'package:piwotapp/constants/colors.dart';
import 'package:piwotapp/constants/images.dart';
import 'package:piwotapp/responses/faq_response.dart';
import 'package:piwotapp/repository/api_repo.dart';
import 'package:get/get.dart';
import '../../widgets/app_themes.dart';

class FAQScreen extends StatefulWidget {
  const FAQScreen({super.key});

  @override
  State<FAQScreen> createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
  FaqResponse? faqResponse;
  List<FaqData> faqList = [];
  int expandedIndex = -1;
  Timer? debounceTimer;
  TextEditingController searchController = TextEditingController();
  bool isConnected = true;

  // Detect if text is a URL
  bool isUrl(String text) {
    final urlRegex = RegExp(r'http[s]?://\S+');
    return urlRegex.hasMatch(text);
  }

  // Detect if text is an Email
  bool isEmail(String text) {
    final emailRegex = RegExp(r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}\b');
    return emailRegex.hasMatch(text);
  }

  // Launch URL or email client
  void _launchLink(String link) async {
    if (isUrl(link)) {
      // Open URL in browser
      if (await canLaunch(link)) {
        await launch(link);
      } else {
        throw 'Could not launch $link';
      }
    } else if (isEmail(link)) {
      // Open email client
      final mailtoLink = 'mailto:$link';
      if (await canLaunch(mailtoLink)) {
        await launch(mailtoLink);
      } else {
        throw 'Could not launch mail client for $link';
      }
    }
  }

  fetchFaq(String search) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      isConnected = false;
      setState(() {});
    } else {
      isConnected = true;
      faqList.clear();
      Future.delayed(Duration.zero, () {
        showLoader(context);
      });

      var response = await ApiRepo().getFaqResponse(search);

      if (response.data != null) {
        faqResponse = response;
        for (FaqData faq in faqResponse!.data!) {
          faqList.add(faq);
        }
      }

      setState(() {});
    }
  }

  @override
  void initState() {
    fetchFaq("");
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        isConnected = false;
      } else {
        isConnected = true;
        fetchFaq("");
      }
    });
    super.initState();
  }

  void onSearchChanged(String query) {
    faqList.clear();
    setState(() {});
    if (debounceTimer?.isActive ?? false) debounceTimer!.cancel();
    debounceTimer = Timer(const Duration(milliseconds: 500), () {
      fetchFaq(searchController.text);
    });
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
          child: Center(child: SvgPicture.asset(Images.logo, height: 40, width: 147)),
        ),
        leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: Icon(Icons.arrow_back_ios, size: 20, color: AppColor.white)),
      ),
      body: isConnected
          ? SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text(
                "Frequently Asked Question",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    fontFamily: appFontFamily,
                    color: AppColor.black),
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextFormField(
                onChanged: onSearchChanged,
                cursorColor: AppColor.black,
                controller: searchController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColor.lightestGrey,
                  prefixIcon: Icon(
                    Icons.search,
                    color: AppColor.black,
                  ),
                  hintText: "Search your keyword",
                  hintStyle: TextStyle(
                      fontFamily: appFontFamily,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColor.darkGrey),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
                ),
              ),
            ),
            const SizedBox(height: 24),
            faqList.isNotEmpty
                ? ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: faqList.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        title: Text(
                          faqList[index].question ?? "",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                              fontFamily: appFontFamily,
                              color: AppColor.primaryColor),
                        ),
                        trailing: Icon(
                          expandedIndex == index ? Icons.remove : Icons.add,
                          color: AppColor.primaryColor,
                        ),
                        onTap: () {
                          setState(() {
                            expandedIndex = expandedIndex == index ? -1 : index;
                          });
                        },
                      ),
                      if (expandedIndex == index)
                        Padding(
                          padding: const EdgeInsets.only(top: 0, bottom: 16, left: 16, right: 16),
                          child: Text.rich(
                            TextSpan(
                              children: _buildAnswerText(faqList[index].answer ?? ""),
                            ),
                          ),
                        ),
                    ],
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(height: 24);
              },
            )
                : Center(
              child: Text(
                "No FAQ Found",
                style: TextStyle(
                    color: AppColor.primaryColor,
                    fontWeight: FontWeight.w600,
                    fontFamily: appFontFamily,
                    fontSize: 20),
              ),
            ),
            const SizedBox(height: 24),
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
        ),
      ),
    );
  }

  // Function to build the answer text with clickable links (URLs and emails) and clipboard support
  List<TextSpan> _buildAnswerText(String text) {
    final List<TextSpan> textSpans = [];
    final regexUrl = RegExp(r'http[s]?://\S+');
    final regexEmail = RegExp(r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}\b');

    // Split the text based on the URLs and emails
    final parts = text.splitMapJoin(regexUrl, onMatch: (match) {
      // If we match a URL, return it as a clickable link
      final url = match.group(0)!;
      textSpans.add(TextSpan(
        text: url,
        style: const TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
        recognizer: TapGestureRecognizer()..onTap = () => _launchLink(url),
      ));
      return ''; // Returning an empty string for the URL match
    }, onNonMatch: (nonMatch) {
      // If the text doesn't match a URL, check for emails
      if (regexEmail.hasMatch(nonMatch)) {
        final email = nonMatch;
        textSpans.add(TextSpan(
          text: email,
          style: const TextStyle(color: Colors.black), // Email color
          recognizer: TapGestureRecognizer()..onTap = () => _launchLink(email), // Mailto link
        ));
      } else {
        // Add normal text and implement long press for copying to clipboard
        textSpans.add(TextSpan(
          text: nonMatch,
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 12,
              fontFamily: appFontFamily,
              color: AppColor.black),
          recognizer: LongPressGestureRecognizer()
            ..onLongPress = () {
              Clipboard.setData(ClipboardData(text: nonMatch));
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Copied to clipboard!"),
                duration: Duration(seconds: 2),
              ));
            },
        ));
      }
      return nonMatch;
    });

    return textSpans;
  }
}
