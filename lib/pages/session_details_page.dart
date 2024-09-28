import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:piwotapp/constants/font_family.dart';

import '../constants/colors.dart';
import '../constants/images.dart';
import '../widgets/app_themes.dart';
import '../widgets/gradient_text.dart';
import 'home/speaker_page.dart';

class SessionDetailsPage extends StatefulWidget {
   SessionDetailsPage({super.key,this.title,this.image});
  String? title;
  String? image;

  @override
  State<SessionDetailsPage> createState() => _SessionDetailsPageState();
}

class _SessionDetailsPageState extends State<SessionDetailsPage> {

  List<SpeakerModel> speakers = [
    SpeakerModel(title: 'Shri Narendra Modi', subtitle: 'Honourable Prime Minister of India Government of India', body: 'Narendra Modi is the Prime Minister of India, serving since 2014. He is a member of the Bharatiya Janata Party (BJP) and previously served as the Chief Minister of Gujarat from 2001 to 2014. Known for his economic and governance reforms, Modi has focused on modernizing India’s infrastructure, digital economy, and foreign relations. His leadership style is marked by strong centralization of power, and he remains a polarizing figure, with both supporters and critics of his policies.', image: Images.speaker4),
    SpeakerModel(title: 'Shri Ashwini Vaishnaw', subtitle: 'Honourable Minister of Electronics Government of India', body: 'Shri Ashwini Vaishnaw is an Indian politician, engineer, and bureaucrat, currently serving as the Minister of Railways, Communications, and Electronics & Information Technology in the Government of India. He is a member of the Bharatiya Janata Party (BJP) and represents Odisha in the Rajya Sabha (Upper House of Parliament). Vaishnaw has a background in engineering and public administration, having previously worked in the Indian Administrative Service (IAS). He is known for his efforts in modernizing India’s railways and advancing the country\'s digital infrastructure.', image: Images.speaker5),
    SpeakerModel(title: 'Shri Dinesh Kumar Khara', subtitle: 'Chairperson State Bank of India', body: 'Shri Dinesh Kumar Khara is an Indian banker and the Chairman of the State Bank of India (SBI), the largest public sector bank in the country. Appointed in October 2020, Khara has played a key role in driving SBI\'s digital transformation and expanding its global operations. He has been with the bank for over three decades, holding various leadership positions in retail banking, corporate banking, and global markets. Under his leadership, SBI has focused on financial inclusion, digital banking, and supporting economic growth in India.', image: Images.speaker6),
  ];

  @override
  void initState() {
    // Get.arguments['sessionModel'] =
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              SizedBox(
                  width: Get.width,
                  height: 390,

                  child: Image.asset(widget.image??"",fit: BoxFit.cover,)),
              Container(
                margin: const EdgeInsets.only(top: 350),
                decoration: BoxDecoration(
                  color: AppColor.white,
                  borderRadius: const BorderRadius.only(topRight: Radius.circular(25),topLeft: Radius.circular(25))
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(widget.title??"",style: AppThemes.titleTextStyle().copyWith(
                              fontWeight: FontWeight.w600,fontSize: 24
                          ),),
                        ),
                        const SizedBox(height: 20,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text("Bridging Innovation and Collaboration Worldwide. Connecting Minds, Shaping the Future.",style:AppThemes.subtitleTextStyle().copyWith(fontSize: 16)),
                        ),
                        const SizedBox(height: 20,),
                        Container(width: Get.width,
                          height: 1,color: AppColor.primaryColor,
                        ),
                        const SizedBox(height: 20,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            children: [
                              GradientText(text:"Room No: ", style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,fontFamily: appFontFamily), gradient: LinearGradient(
                                colors: [AppColor.primaryColor,AppColor.red]
                              ),),
                              Text("201",style: TextStyle(fontSize: 16,fontFamily: appFontFamily,fontWeight: FontWeight.w400,color: AppColor.FF161616),)
                            ],
                          ),
                        ),
                        const SizedBox(height: 20,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            children: [
                              Icon(Icons.date_range,size: 17,color: AppColor.primaryColor,),
                              const SizedBox(width: 5,),
                              GradientText(text:"Date & Time",style: AppThemes.labelTextStyle().copyWith(color: AppColor.primaryColor,fontWeight: FontWeight.w600),gradient:LinearGradient(
                                colors: [AppColor.primaryColor, AppColor.red],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              )),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10,),
                        Padding(
                          padding: const EdgeInsets.only(left: 40),
                          child: Text("22 September 2024 , Tuesday",style: AppThemes.subtitleTextStyle(),),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 40),
                          child: Text("10:00 am to 12:00 am",style: AppThemes.subtitleTextStyle(),),
                        ),

                      ],
                    ),
                    const SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.location_on_outlined,size: 17,color: AppColor.primaryColor,),
                              const SizedBox(width: 5,),
                              GradientText(text:"Location",style: AppThemes.labelTextStyle().copyWith(color: AppColor.primaryColor,fontWeight: FontWeight.w600),gradient:LinearGradient(
                                colors: [AppColor.primaryColor, AppColor.red],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              )),
                            ],
                          ),
                          const SizedBox(height: 10,),
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Text("Indian Institute of Technology Delhi, Hauz Khas, Delhi 110016.",style: AppThemes.subtitleTextStyle(),),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Container(width: Get.width,
                      height: 1,color: AppColor.primaryColor,
                    ),
                    const SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: GradientText(text: "Speaker", style: TextStyle(fontWeight: FontWeight.w600,fontFamily: appFontFamily,fontSize: 16), gradient: LinearGradient(
                        colors: [AppColor.primaryColor,AppColor.red]
                      )),
                    ),
                    SizedBox(
                      height: 200,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: speakers.length,
                          itemBuilder: (context,index){
                            return GestureDetector(
                              onTap: (){
                                speakerDetails(title: speakers[index].title, subtitle: speakers[index].subtitle, body: speakers[index].body, image: speakers[index].image);
                              },
                              child: Stack(
                                alignment: Alignment.bottomCenter,
                                children: [
                                  Container(
                                    width: 250,
                                    height: 210,
                                    margin: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                                        gradient: LinearGradient(
                                          colors: [AppColor.primaryColor, AppColor.red],
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight,
                                        )
                                    ),
                                    child: Image.asset(speakers[index].image),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.symmetric(horizontal: 20),
                                    width: 250,
                                    decoration: BoxDecoration(
                                        color: AppColor.black.withOpacity(0.85),
                                        borderRadius: const BorderRadius.all(Radius.circular(10))
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(speakers[index].title,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: AppColor.white,fontFamily: appFontFamily),),
                                          Text(speakers[index].subtitle,style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,color: AppColor.white,fontFamily: appFontFamily),),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          }),
                    ),
                    SizedBox(height: 20,)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  speakerDetails({required String title, required String subtitle, required String body, required String image}){

    return showModalBottomSheet<void>(
      // context and builder are
      // required properties in this widget
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(32.0)),
      ),
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        // we set up a container inside which
        // we create center column and display text

        // Returning SizedBox instead of a Container
        return Stack(
          alignment: Alignment.topRight,
          children: [
            Container(
              height: Get.height/1.5,
              decoration: BoxDecoration(
                  color: AppColor.white,
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(32),topRight: Radius.circular(32))
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 30,),
                    Container(
                      width: 148,height: 156,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        gradient: LinearGradient(colors: [AppColor.primaryColor,AppColor.red]),
                      ),
                      child: Image.asset(image,fit: BoxFit.fitHeight,),
                    ),
                    const SizedBox(height: 10,),
                    Row(
                      children: [
                        Icon(Icons.flag,color: AppColor.FF050505,),
                        const SizedBox(width: 5,),
                        Text("India",style: TextStyle(fontFamily: appFontFamily,fontSize: 14,fontWeight: FontWeight.w400,color: AppColor.FF444444),)
                      ],
                    ),
                    const SizedBox(height: 20,),
                    Text(title,style: TextStyle(fontFamily: appFontFamily,fontSize: 16,fontWeight: FontWeight.w700,color: AppColor.FF050505),),
                    const SizedBox(height: 10,),
                    Text(subtitle,style: TextStyle(fontFamily: appFontFamily,fontSize: 14,fontWeight: FontWeight.w600,color: AppColor.primaryColor),),
                    const SizedBox(height: 30,),
                    Text(body,style: TextStyle(fontFamily: appFontFamily,fontSize: 14,fontWeight: FontWeight.w400,color: AppColor.FF050505),),
                    const SizedBox(height: 20,)
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: GestureDetector(
                  onTap: (){
                    Get.back();
                  },
                  child: Image.asset(Images.cancelIcon)),
            )
          ],
        );
      },
    );
  }

}
