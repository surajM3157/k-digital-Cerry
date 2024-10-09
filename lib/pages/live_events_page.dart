import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:piwotapp/constants/font_family.dart';
import '../constants/colors.dart';
import '../constants/images.dart';
import '../route/route_names.dart';
import '../widgets/gradient_text.dart';

class LiveEventsPage extends StatefulWidget {
  const LiveEventsPage({super.key});

  @override
  State<LiveEventsPage> createState() => _LiveEventsPageState();
}

class _LiveEventsPageState extends State<LiveEventsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: ListView(
        children: [
          const SizedBox(height: 12,),
          Center(child: GradientText(text:"Live Event",style: const TextStyle(fontFamily: appFontFamily,fontSize: 20,fontWeight: FontWeight.w600), gradient: LinearGradient(colors: [AppColor.primaryColor,AppColor.red]),)),
          const SizedBox(height: 33,),

          ListView.separated(
            itemCount: 3,
              shrinkWrap: true,physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index){
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColor.FF646464.withOpacity(0.3))
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                          borderRadius:BorderRadius.circular(8),
                          child: SizedBox(
                              height: 144,width: 113,
                              child: Image.asset(index==0?Images.liveEvent1:index==1?Images.liveEvent2:Images.liveEvent3,fit: BoxFit.fill,))),
                      const SizedBox(width: 15  ,),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GradientText(text:index==0?"Tech Innovator":index==1?"Innovation Nexus":"Future of E-commerce",style: const TextStyle(fontWeight: FontWeight.w600,fontSize: 14,fontFamily: appFontFamily,), gradient: LinearGradient(
                              colors: [AppColor.primaryColor,AppColor.red]
                            ),),
                            const SizedBox(height: 5,),
                            Text(index==0?"Join experts to discuss future tech innovations.":index==1?"Explore the intersection of technology and innovation":"Learn how e-commerce is evolving in the digital era",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 10,fontFamily: appFontFamily,color: AppColor.FF161616)),
                            const SizedBox(height: 13,),
                            Row(
                              children: [
                                SvgPicture.asset(Images.calendarIcon),
                                const SizedBox(width: 2,),
                                 Text(index==0?"17, January 2024":index==1?"18, January 2024":"19, January 2024",style: const TextStyle(fontFamily: appFontFamily,fontSize: 10,fontWeight: FontWeight.w600),)
                              ],
                            ),
                            const SizedBox(height: 10,),
                            Row(
                              children: [
                                SvgPicture.asset(Images.participantIcon),
                                const SizedBox(width: 2,),
                                const Text("30k Participants",style: TextStyle(fontFamily: appFontFamily,fontSize: 10,fontWeight: FontWeight.w600),)
                              ],
                            ),
                            const SizedBox(height: 10,),
                            GestureDetector(
                              onTap: (){
                                Get.toNamed(Routes.liveSession);
                              },
                              child: Container(
                                width: 87,height: 27,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                  color: AppColor.red
                                ),
                                child: Center(child: Text("Watch Now",style: TextStyle(fontFamily: appFontFamily,fontSize: 12,fontWeight: FontWeight.w600,color: AppColor.white),)),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                );
              }, separatorBuilder: (BuildContext context, int index) { return const SizedBox(height: 16,); },)
        ],
      ),
    );
  }
}
