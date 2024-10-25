import 'dart:async';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:piwotapp/constants/font_family.dart';
import 'package:piwotapp/responses/faq_response.dart';
import '../../constants/colors.dart';
import '../../constants/images.dart';
import '../../repository/api_repo.dart';
import '../../widgets/app_themes.dart';

class FAQScreen extends StatefulWidget {
  const FAQScreen({super.key});

  @override
  State<FAQScreen> createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {


  // List of questions and answers
  FaqResponse? faqResponse;
   List<FaqData> faqList = [];

  // State to track which panel is expanded
  int expandedIndex = -1;
  Timer? debounceTimer;

  TextEditingController searchController = TextEditingController();



  fetchFaq(String search) async
  {
    Future.delayed(Duration.zero, () {
      showLoader(context);
    });

    try{
      var response = await ApiRepo().getFaqResponse(search);

      if( response.data != null)
      {
        faqResponse = response;
        for(FaqData faq in faqResponse!.data!){
          faqList.add(faq);

        }
        print("faqList ${faqList.length}");
      }

      setState(() {

      });

    }
    catch(e){}


    setState(() {});
  }

  @override
  void initState() {
    fetchFaq("");
    super.initState();
  }

  void onSearchChanged(String query) {
    faqList.clear();
    setState(() {});
    if (debounceTimer?.isActive ?? false) debounceTimer!.cancel();
    debounceTimer = Timer(const Duration(milliseconds: 1500), () {
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
          child: Center(child: SvgPicture.asset(Images.logo, height: 40,width: 147)),
        ),
        leading: InkWell(
            onTap: (){
              Get.back();
            },
            child: Icon(Icons.arrow_back_ios,size: 20,color: AppColor.white,)),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24,),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text("Frequently Asked Question",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16,fontFamily: appFontFamily,color: AppColor.black),),
            ),
            const SizedBox(height: 24,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: TextFormField(
                onChanged: onSearchChanged,
                cursorColor: AppColor.black,
                controller: searchController,
                decoration: InputDecoration(
                  filled: true,fillColor: AppColor.lightestGrey,
                  prefixIcon: Icon(Icons.search,color: AppColor.black,),
                  hintText: "Search your keyword",
                  hintStyle: TextStyle(
                    fontFamily: appFontFamily,fontSize: 14,fontWeight: FontWeight.w600,color: AppColor.darkGrey
                  ),
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8),borderSide: BorderSide.none),
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8),borderSide: BorderSide.none),
                ),
              ),
            ),
            const SizedBox(height: 24,),
            faqList.isNotEmpty?ListView.separated(
              shrinkWrap: true,physics: NeverScrollableScrollPhysics(),
              itemCount: faqList.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 2,
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        title: Text(
                          faqList[index].question??"",
                          style: TextStyle(fontWeight: FontWeight.w600,fontSize: 15,fontFamily: appFontFamily,color: AppColor.primaryColor),
                        ),
                        trailing: Icon(
                          expandedIndex == index ? Icons.remove : Icons.add,
                          color:AppColor.primaryColor,
                        ),
                        onTap: () {
                          setState(() {
                            expandedIndex = expandedIndex == index ? -1 : index;
                          });
                        },
                      ),
                      if (expandedIndex == index)
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8.0),
                          child: Text(
                            faqList[index].answer??"",
                            style: TextStyle(fontWeight: FontWeight.w600,fontSize: 12,fontFamily: appFontFamily,color: AppColor.black),
                          ),
                        )
                    ],
                  ),
                );
              }, separatorBuilder: (BuildContext context, int index) {
                return SizedBox(height: 24,);
            },
            ):SizedBox(),
            const SizedBox(height: 24,)
          ],
        ),
      ),
    );
  }
}


