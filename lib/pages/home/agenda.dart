import 'package:flutter/material.dart';
import 'package:piwotapp/responses/agenda_response.dart';
import '../../constants/colors.dart';
import '../../constants/font_family.dart';
import '../../repository/api_repo.dart';
import '../../widgets/app_themes.dart';
import '../../widgets/gradient_text.dart';

class Agenda extends StatefulWidget {
  const Agenda({super.key});

  @override
  State<Agenda> createState() => _AgendaState();
}

class _AgendaState extends State<Agenda> {

  AgendaResponse? agendaResponse;


  fetchAgendaList() async
  {
    Future.delayed(Duration.zero, () {
      showLoader(context);
    });

    try{
      var response = await ApiRepo().getAgendaResponse();

      if( response.data != null)
      {
        agendaResponse = response;

        print("sponsorlist ${agendaResponse?.data?.length}");
      }

      setState(() {

      });

    }
    catch(e){}


    setState(() {});
  }

  @override
  void initState() {
    fetchAgendaList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
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
      ),
    );
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
