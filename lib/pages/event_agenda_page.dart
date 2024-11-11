import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:piwotapp/constants/font_family.dart';
import '../constants/colors.dart';
import '../constants/images.dart';
import '../repository/api_repo.dart';
import '../responses/agenda_response.dart';
import '../widgets/app_themes.dart';
import '../widgets/gradient_text.dart';

class EventAgendaPage extends StatefulWidget {
  const EventAgendaPage({super.key});

  @override
  State<EventAgendaPage> createState() => _EventAgendaPageState();
}

class _EventAgendaPageState extends State<EventAgendaPage> {



  AgendaResponse? agendaResponse;
  List<AgendaData> agendaList = [];
  int expandedIndex = -1;


  String date = "17 Jan";


  fetchAgendaList(String date) async
  {
    Future.delayed(Duration.zero, () {
      showLoader(context);
    });

      var response = await ApiRepo().getAgendaResponse(date);

      if( response.data != null)
      {
        agendaResponse = response;

        for(AgendaData agendaData in agendaResponse!.data!){
          agendaList.add(agendaData);
        }

        print("agendaList ${agendaResponse?.data?.length}");
      }

      setState(() {

      });

  }

  @override
  void initState() {
    fetchAgendaList("2025/01/17");
    super.initState();
  }

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
      body:SingleChildScrollView(
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
            dateFilter(),
            const SizedBox(height: 20,),
            ListView.separated(
              itemCount: agendaList.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index){
                return Card(
                  elevation: 2,
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        title: GradientText(
                          text: agendaList[index].roomId?.roomNo??"",
                          style: TextStyle(fontWeight: FontWeight.w600,fontSize: 15,fontFamily: appFontFamily), gradient: LinearGradient(colors: [AppColor.primaryColor,AppColor.red]

                        ),
                        ),
                        trailing:  expandedIndex == index ?Image.asset(Images.upArrowIcon,height: 30,width: 30,):Image.asset(Images.downArrowIcon,height: 30,width: 30,),
                        onTap: () {
                          setState(() {
                            expandedIndex = expandedIndex == index ? -1 : index;
                          });
                        },
                      ),
                      if (expandedIndex == index)
                        agendaList[index].agendas!.isNotEmpty? Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(
                                flex: 1,
                                child: ListView.builder(
                                    shrinkWrap: true,physics: NeverScrollableScrollPhysics(),
                                    itemCount: agendaList[index].agendas?.length,
                                    itemBuilder: (index,context){
                                      return Column(
                                        children: [
                                          Container(
                                            height: 10,width: 10,
                                            decoration: BoxDecoration(
                                                color: AppColor.primaryColor,
                                                borderRadius: const BorderRadius.all(Radius.circular(5))
                                            ),
                                          ),
                                          Container(height: 132,width: 1,color: AppColor.primaryColor,),
                                        ],
                                      );
                                    }),
                              ),
                              Flexible(
                                flex: 4,
                                child: ListView.separated(
                                  shrinkWrap: true,physics: NeverScrollableScrollPhysics(),
                                  itemCount: agendaList[index].agendas!.length,
                                  itemBuilder: (context, index){
                                    return Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(agendaList[index].agendas?[index].time??"",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 12,color: AppColor.FF161616,fontFamily: appFontFamily),),
                                        const SizedBox(height: 20,),
                                        Text(agendaList[index].agendas?[index].title??"",style: TextStyle(fontFamily: appFontFamily,fontSize: 14,fontWeight: FontWeight.w600,color: AppColor.FF161616),),
                                        const SizedBox(height: 10,),
                                        ListView(
                                          padding: EdgeInsets.only(right: 10),
                                          shrinkWrap: true,physics: NeverScrollableScrollPhysics(),
                                          children: agendaList[index].agendas![index].activities!.map((item) {
                                            return AppThemes.buildBulletPoint(Text(item,style: TextStyle(
                                                fontWeight: FontWeight.w400,fontSize: 14,fontFamily: appFontFamily,color: AppColor.FF161616
                                            ),));
                                          }).toList(), // Convert the iterable to a list
                                        ),
                                      ],
                                    );
                                  }, separatorBuilder: (BuildContext context, int index) {
                                  return SizedBox(height: 10,);
                                },),
                              )
                            ],
                          ),
                        ):SizedBox.shrink(),
                    ],
                  ),
                );
              }, separatorBuilder: (BuildContext context, int index) { return SizedBox(
              height: 10,
            ); },),
            SizedBox(height: 20,)
          ],
        ),
      ));
  }

  Widget dateFilter(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [

        GestureDetector(
          onTap: (){
            date = "17 Jan";
            agendaList.clear();
            setState(() {
            });
            fetchAgendaList("2025/01/17");
          },
          child:date == "17 Jan"? Container(
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
          ):Container(
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
                child: Text("17 Jan",style: TextStyle(
                    fontFamily: appFontFamily,fontSize: 14,fontWeight: FontWeight.w600,color: AppColor.FF161616
                ),),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: (){
            date = "18 Jan";
            agendaList.clear();
            setState(() {
            });
            fetchAgendaList("2025/01/18");
          },
          child: date == "18 Jan"? Container(
            height: 35,width: 99,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                gradient: LinearGradient(colors: [AppColor.primaryColor,AppColor.red],
                    begin: Alignment.centerLeft,end: Alignment.centerRight
                )
            ),
            child: Center(
              child: Text("18 Jan",style: TextStyle(
                  fontFamily: appFontFamily,fontSize: 14,fontWeight: FontWeight.w600,color: AppColor.white
              ),),
            ),
          ):Container(
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
        ),
        GestureDetector(
          onTap: (){
            date = "19 Jan";
            agendaList.clear();
            setState(() {
            });
            fetchAgendaList("2025/01/19");
          },
          child: date == "19 Jan"? Container(
            height: 35,width: 99,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                gradient: LinearGradient(colors: [AppColor.primaryColor,AppColor.red],
                    begin: Alignment.centerLeft,end: Alignment.centerRight
                )
            ),
            child: Center(
              child: Text("19 Jan",style: TextStyle(
                  fontFamily: appFontFamily,fontSize: 14,fontWeight: FontWeight.w600,color: AppColor.white
              ),),
            ),
          ):Container(
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
        ),
      ],
    );
  }
}
