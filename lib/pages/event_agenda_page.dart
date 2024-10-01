import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:piwotapp/constants/font_family.dart';
import '../constants/colors.dart';
import '../constants/images.dart';
import '../widgets/gradient_text.dart';

class EventAgendaPage extends StatefulWidget {
  const EventAgendaPage({super.key});

  @override
  State<EventAgendaPage> createState() => _EventAgendaPageState();
}

class _EventAgendaPageState extends State<EventAgendaPage> {
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 10,),
              Center(
                child: GradientText(text:"Agenda",style: const TextStyle(fontWeight: FontWeight.w600,fontFamily: appFontFamily,fontSize: 20), gradient: LinearGradient(
                  colors: [AppColor.primaryColor, AppColor.red],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [

              Container(
                height: 35,width: 99,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  gradient: LinearGradient(colors: [AppColor.primaryColor,AppColor.red],
                    begin: Alignment.centerLeft,end: Alignment.centerRight
                  )
                ),
                child: Center(
                  child: Text("17 Jan",style: TextStyle(
                    fontFamily: appFontFamily,fontSize: 14,fontWeight: FontWeight.w600,color: AppColor.white
                  ),),
                ),
              ),
              Container(
                height: 35,width: 99,
                padding: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(9)),
                    gradient: LinearGradient(colors: [AppColor.primaryColor,AppColor.red],
                        begin: Alignment.centerLeft,end: Alignment.centerRight
                    )
                ),
                child: Container(
                  height: 35,width: 99,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    color: AppColor.white
                  ),
                  child: Center(
                    child: Text("18 Jan",style: TextStyle(
                        fontFamily: appFontFamily,fontSize: 14,fontWeight: FontWeight.w600,color: AppColor.FF161616
                    ),),
                  ),
                ),
              ),
              Container(
                height: 35,width: 99,
                padding: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(9)),
                    gradient: LinearGradient(colors: [AppColor.primaryColor,AppColor.red],
                        begin: Alignment.centerLeft,end: Alignment.centerRight
                    )
                ),
                child: Container(
                  height: 35,width: 99,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    color: AppColor.white
                  ),
                  child: Center(
                    child: Text("19 Jan",style: TextStyle(
                        fontFamily: appFontFamily,fontSize: 14,fontWeight: FontWeight.w600,color: AppColor.FF161616
                    ),),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Container(height: 10,width: 1,color: AppColor.primaryColor,),
                  Container(
                    height: 10,width: 10,
                    decoration: BoxDecoration(
                        color: AppColor.primaryColor,
                        borderRadius: const BorderRadius.all(Radius.circular(5))
                    ),
                  ),
                  Container(height: 132,width: 1,color: AppColor.primaryColor,),
                  Container(
                    height: 10,width: 10,
                    decoration: BoxDecoration(
                        color: AppColor.primaryColor,
                        borderRadius: const BorderRadius.all(Radius.circular(5))
                    ),
                  ),
                  Container(height: 132,width: 1,color: AppColor.primaryColor,),
                  Container(
                    height: 10,width: 10,
                    decoration: BoxDecoration(
                        color: AppColor.primaryColor,
                        borderRadius: const BorderRadius.all(Radius.circular(5))
                    ),
                  ),
                  Container(height: 132,width: 1,color: AppColor.primaryColor,),
                  Container(
                    height: 10,width: 10,
                    decoration: BoxDecoration(
                        color: AppColor.primaryColor,
                        borderRadius: const BorderRadius.all(Radius.circular(5))
                    ),
                  ),
                  Container(height: 132,width: 1,color: AppColor.primaryColor,),
                ],
              ),
              const SizedBox(width: 10,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 7,),
                  Text("11:00 Am",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 12,color: AppColor.FF161616,fontFamily: appFontFamily),),
                  const SizedBox(height: 20,),
                  Text("Arrival and Welcome Drinks",style: TextStyle(fontFamily: appFontFamily,fontSize: 14,fontWeight: FontWeight.w600,color: AppColor.FF161616),),
                  const SizedBox(height: 10,),
                  buildBulletPoint(Text('Guests arrive and check-in.',style: TextStyle(
                    fontWeight: FontWeight.w400,fontSize: 14,fontFamily: appFontFamily,color: AppColor.FF161616
                  ),)),
                  buildBulletPoint(Text('Welcome drinks and light appetizers served.',style: TextStyle(
                    fontWeight: FontWeight.w400,fontSize: 14,fontFamily: appFontFamily,color: AppColor.FF161616
                  ),)),
                  buildBulletPoint(Text('Informal mingling.',style: TextStyle(
                    fontWeight: FontWeight.w400,fontSize: 14,fontFamily: appFontFamily,color: AppColor.FF161616
                  ),)),
                  const SizedBox(height: 7,),
                  Text("12:00 Pm",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 12,color: AppColor.FF161616,fontFamily: appFontFamily),),
                  const SizedBox(height: 20,),
                  Text("Opening Remarks",style: TextStyle(fontFamily: appFontFamily,fontSize: 14,fontWeight: FontWeight.w600,color: AppColor.FF161616),),
                  const SizedBox(height: 10,),
                  buildBulletPoint(Text('Host welcomes guests.',style: TextStyle(
                      fontWeight: FontWeight.w400,fontSize: 14,fontFamily: appFontFamily,color: AppColor.FF161616
                  ),)),
                  buildBulletPoint(Text('Brief introduction to the purpose of the dinner.',style: TextStyle(
                      fontWeight: FontWeight.w400,fontSize: 14,fontFamily: appFontFamily,color: AppColor.FF161616
                  ),)),
                  buildBulletPoint(Text('Overview of the evening\'s agenda.',style: TextStyle(
                      fontWeight: FontWeight.w400,fontSize: 14,fontFamily: appFontFamily,color: AppColor.FF161616
                  ),)),
                  const SizedBox(height: 7,),
                  Text("01:00 Pm",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 12,color: AppColor.FF161616,fontFamily: appFontFamily),),
                  const SizedBox(height: 20,),
                  Text("Opening Remarks",style: TextStyle(fontFamily: appFontFamily,fontSize: 14,fontWeight: FontWeight.w600,color: AppColor.FF161616),),
                  const SizedBox(height: 10,),
                  buildBulletPoint(Text('Host welcomes guests.',style: TextStyle(
                      fontWeight: FontWeight.w400,fontSize: 14,fontFamily: appFontFamily,color: AppColor.FF161616
                  ),)),
                  buildBulletPoint(Text('Brief introduction to the purpose of the dinner.',style: TextStyle(
                      fontWeight: FontWeight.w400,fontSize: 14,fontFamily: appFontFamily,color: AppColor.FF161616
                  ),)),
                  buildBulletPoint(Text('Overview of the evening\'s agenda.',style: TextStyle(
                      fontWeight: FontWeight.w400,fontSize: 14,fontFamily: appFontFamily,color: AppColor.FF161616
                  ),)),
                  const SizedBox(height: 7,),
                  Text("02:00 Pm",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 12,color: AppColor.FF161616,fontFamily: appFontFamily),),
                  const SizedBox(height: 20,),
                  Text("Networking",style: TextStyle(fontFamily: appFontFamily,fontSize: 14,fontWeight: FontWeight.w600,color: AppColor.FF161616),),
                  const SizedBox(height: 10,),
                  buildBulletPoint(Text('Introduction of the speaker.',style: TextStyle(
                      fontWeight: FontWeight.w400,fontSize: 14,fontFamily: appFontFamily,color: AppColor.FF161616
                  ),)),
                  buildBulletPoint(Text('Talk on a networking relevant industry topic.',style: TextStyle(
                      fontWeight: FontWeight.w400,fontSize: 14,fontFamily: appFontFamily,color: AppColor.FF161616
                  ),)),
                  buildBulletPoint(Text('Brief Q&A session (if time allows).',style: TextStyle(
                      fontWeight: FontWeight.w400,fontSize: 14,fontFamily: appFontFamily,color: AppColor.FF161616
                  ),)),
                ],
              )
            ],
          )
        ],
      ),
    )));
  }

  Widget buildBulletPoint(Widget text,) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("• ", style: TextStyle(fontSize: 20)),
        text,
      ],
    );
  }
}
