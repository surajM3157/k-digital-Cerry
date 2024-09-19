import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:piwotapp/constants/font_family.dart';
import 'package:piwotapp/widgets/gradient_text.dart';
import '../../constants/colors.dart';
import '../../constants/images.dart';

class SponsorPage extends StatefulWidget {
  const SponsorPage({super.key});

  @override
  State<SponsorPage> createState() => _SponsorPageState();
}

class _SponsorPageState extends State<SponsorPage> {

  List<Sponsor> sponsors = [Sponsor("Co-Powered By", Images.sponsorLogo1),Sponsor("Co-Powered By", Images.sponsorLogo2),
    Sponsor("Associate Partner", Images.sponsorLogo3),Sponsor("Associate Partner", Images.sponsorLogo4),
    Sponsor("Technology- Partner", Images.sponsorLogo5),Sponsor("Technology- Partner", Images.sponsorLogo6)
  ];

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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: GradientText(text: "Sponsor", style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w600,fontFamily: appFontFamily), gradient: LinearGradient(
              colors: [AppColor.primaryColor, AppColor.red],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            )),
          ),
          const SizedBox(height: 10,),
          Expanded(
            child: GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (_, index) => Container
                (
                margin: const EdgeInsets.all(10),
                height: 143,width: 155,
                decoration: BoxDecoration(
                  color: AppColor.FFFFFDFD,
                    borderRadius: const BorderRadius.all(Radius.circular(8),),
                border: Border.all(color: AppColor.grey)),
                child: Column(
                  children: [
                    const SizedBox(height: 20,),
                    Text(sponsors[index].title,style: TextStyle(fontFamily: appFontFamily,fontWeight: FontWeight.w400,fontSize: 12,color: AppColor.black),),
                    const SizedBox(height: 50,),
                    Center(
                      child: SizedBox(
                        height: 50,width: 100,
                        child: Image.asset(sponsors[index].icon,fit: BoxFit.fill,),
                      ),
                    )
                  ],
                ),
              ),
              itemCount: sponsors.length,),
          )
        ],
      ),
    );
  }
}

class Sponsor{
  String title;
  String icon;
  Sponsor(this.title,this.icon);
}