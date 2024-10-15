import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../constants/colors.dart';
import '../../constants/font_family.dart';
import '../../constants/images.dart';
import '../../widgets/gradient_text.dart';

class SpeakerPage extends StatefulWidget {
  const SpeakerPage({super.key});

  @override
  State<SpeakerPage> createState() => _SpeakerPageState();
}

class _SpeakerPageState extends State<SpeakerPage> {

  TextEditingController searchController = TextEditingController();

  List<SpeakerModel> speakers = [
    SpeakerModel(title: 'Shri Narendra Modi', subtitle: 'Honourable Prime Minister of India Government of India', body: 'Narendra Modi is the Prime Minister of India, serving since 2014. He is a member of the Bharatiya Janata Party (BJP) and previously served as the Chief Minister of Gujarat from 2001 to 2014. Known for his economic and governance reforms, Modi has focused on modernizing India’s infrastructure, digital economy, and foreign relations. His leadership style is marked by strong centralization of power, and he remains a polarizing figure, with both supporters and critics of his policies.', image: Images.speaker4),
    SpeakerModel(title: 'Shri Ashwini Vaishnaw', subtitle: 'Honourable Minister of Electronics Government of India', body: 'Shri Ashwini Vaishnaw is an Indian politician, engineer, and bureaucrat, currently serving as the Minister of Railways, Communications, and Electronics & Information Technology in the Government of India. He is a member of the Bharatiya Janata Party (BJP) and represents Odisha in the Rajya Sabha (Upper House of Parliament). Vaishnaw has a background in engineering and public administration, having previously worked in the Indian Administrative Service (IAS). He is known for his efforts in modernizing India’s railways and advancing the country\'s digital infrastructure.', image: Images.speaker5),
    SpeakerModel(title: 'Shri Dinesh Kumar Khara', subtitle: 'Chairperson State Bank of India', body: 'Shri Dinesh Kumar Khara is an Indian banker and the Chairman of the State Bank of India (SBI), the largest public sector bank in the country. Appointed in October 2020, Khara has played a key role in driving SBI\'s digital transformation and expanding its global operations. He has been with the bank for over three decades, holding various leadership positions in retail banking, corporate banking, and global markets. Under his leadership, SBI has focused on financial inclusion, digital banking, and supporting economic growth in India.', image: Images.speaker6),

    SpeakerModel(title: 'Dr. Bharat Balasubramanian', subtitle: 'Executive Director Center Advanced Vehicle  Technologies', body: "Prof. Dr.-Ing. Bharat Balasubramanian Born in India, Prof. Bharat holds an honors degree in mechanical engineering from IIT Bombay. He pursued advanced engineering studies in Germany, launching a 38-year career at Daimler-Benz in Mercedes-Benz (MB) Cars R&D. Rising to Vice President in 1997, he was the first non-German VP in R&D history at MB. He led pioneering initiatives in connected vehicles, automated driving, electric cars, and lightweight materials, and spearheaded Daimler's partnership with Tesla. Retiring in 2012, he joined the University of Alabama, where his team has secured over \$20 million in federal grants for CAE research.", image: Images.speaker_11),
    SpeakerModel(title: 'Dr. R.A. Mashelkar', subtitle: 'Former Director General Council of Scientific and Industrial Research', body: '', image: Images.speaker_12),
    SpeakerModel(title: 'Dr. Sudhir Jain', subtitle: 'Vice-Chancellor - Banaras Hindu University ', body: '', image: Images.speaker_13),
    SpeakerModel(title: 'Mr. Abhay Karandikar', subtitle: 'Secretary - Department of Science and Technology', body: '', image: Images.speaker_1),
    SpeakerModel(title: 'Dr. Gururaj Desh Deshpande', subtitle: 'Chairman - Sycamore Networks', body: '', image: Images.speaker_4),
    SpeakerModel(title: 'Mr. Markus Schaefer', subtitle: 'Board of Directors Member and CTO - Mercedes-Benz Group AG', body: '', image: Images.speaker_3),
    SpeakerModel(title: 'Mr. Partha Ghosh', subtitle: 'Founder - Partha Ghosh Academy of Leadership', body: '', image: Images.speaker_2),
    SpeakerModel(title: 'Mr. Sanjiv Puri', subtitle: 'Chairman & Managing Director - ITC Limited', body: '', image: Images.speaker_8),
    SpeakerModel(title: 'Mr. Sunil Wadhwani', subtitle: 'Chief Executive Officer - Mastech, Inc. and IGATE', body: '', image: Images.speaker_9),
    SpeakerModel(title: 'Mr. Vindi Banga', subtitle: 'Chair - Imperial College London', body: '', image: Images.speaker_5),
    SpeakerModel(title: 'Mr. Yuki Kita', subtitle: 'Chief Executive Officer - FANUC', body: '', image: Images.speaker_10),
    SpeakerModel(title: 'Prof. Alon Chen', subtitle: 'President - Weizmann Institute of Science, Israel', body: '', image: Images.speaker_6),
    SpeakerModel(title: 'Mr Saakar S Yadav', subtitle: 'Founder and CMD, Lexlegis.ai', body: '', image: Images.speaker_7),
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: GradientText(text: "Paniit - 2024 SPEAKERS ", style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w600,fontFamily: appFontFamily), gradient: LinearGradient(
                colors: [AppColor.primaryColor, AppColor.red],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              )),
            ),
            const SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextFormField(
                controller: searchController,
                cursorColor: AppColor.primaryColor,
                decoration: InputDecoration(
                  hintText: "Search Speaker",
                  hintStyle: TextStyle(fontFamily: appFontFamily,fontWeight: FontWeight.w400,fontSize: 14,color: AppColor.black.withOpacity(0.50)),
                  suffixIcon: Container(
                    height: 60,width: 80,
                    decoration: BoxDecoration(
                      color: AppColor.primaryColor,
                      borderRadius: const BorderRadius.only(topRight: Radius.circular(8),bottomRight: Radius.circular(8))
                    ),
                    child: Center(child: Icon(Icons.search_rounded,color: AppColor.white,)),
                  ),
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8),borderSide: BorderSide(width: 0.5,color: AppColor.black.withOpacity(0.10))),
                  focusedBorder:  OutlineInputBorder(borderRadius: BorderRadius.circular(8),borderSide: BorderSide(width: 0.5,color: AppColor.black.withOpacity(0.10))),
                ),
              ),
            ),
            const SizedBox(height: 10,),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: speakers.length,
                itemBuilder: (context,index){
              return GestureDetector(
                onTap: (){
                  speakerDetails(title: speakers[index].title, subtitle: speakers[index].subtitle, body: speakers[index].body, image: speakers[index].image);
                },
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: Get.width,
                      height: 325,
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
                    Positioned(
                      bottom: -30,
                      left: 16,right: 16,
                      child: Container(
                        height: 102,
                        width: Get.width,
                        decoration: BoxDecoration(
                            color: AppColor.black.withOpacity(0.85),
                            borderRadius: const BorderRadius.all(Radius.circular(10))
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(speakers[index].title,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: AppColor.white,fontFamily: appFontFamily),),
                              Text(speakers[index].subtitle,style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,color: AppColor.white,fontFamily: appFontFamily),),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            }, separatorBuilder: (BuildContext context, int index) { return const SizedBox(height: 40,); },)
          ],
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


class SpeakerModel{
  SpeakerModel({required this.title,required this.subtitle, required this.body, required this.image});
  String image;
  String title;
  String subtitle;
  String body;
}