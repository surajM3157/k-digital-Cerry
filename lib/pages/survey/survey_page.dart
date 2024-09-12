import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:piwotapp/constants/colors.dart';
import 'package:piwotapp/constants/font_family.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:get/get.dart';

import '../../constants/images.dart';
import '../../route/route_names.dart';
import '../../widgets/app_themes.dart';
import '../../widgets/custom_progress_indicator.dart';

class SurveyPage extends StatefulWidget {
  const SurveyPage({super.key});

  @override
  State<SurveyPage> createState() => _SurveyPageState();
}

class _SurveyPageState extends State<SurveyPage> {

  // String selectedRadio = '';
  // List questions = [
  //   "1.How would you rate your overall experience at the event?",
  //   "2.How satisfied were you with the networking opportunities provided during the event?",
  //   "3.How likely are you to attend future events organized by PAN IIT Alumni India?",
  //   "4.How would you rate your overall experience at the event?",
  //   "5.How would you rate the organization and management of the event?"
  // ];
  int index = 0;
  List<QuestionModel> questions = [
    QuestionModel(question: "1.How would you rate your overall experience at the event?", options: ["Excellent","Good","Average","Poor"], selectedRadio: ''),
    QuestionModel(question: "2.How satisfied were you with the networking opportunities provided during the event?", options: ["Excellent","Good","Average","Poor"], selectedRadio: ''),
    QuestionModel(question: "3.How likely are you to attend future events organized by PAN IIT Alumni India?", options: ["Excellent","Good","Average","Poor"], selectedRadio: ''),
    QuestionModel(question: "4.How would you rate your overall experience at the event?", options: ["Excellent","Good","Average","Poor"], selectedRadio: ''),
    QuestionModel(question: "5.How would you rate the organization and management of the event?", options: ["Excellent","Good","Average","Poor"], selectedRadio: ''),
  ];

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
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomProgressIndicator(
                  totalSteps: 5, currentStep: index, size: 20, padding: 6, selectedColor: AppColor.primaryColor, unselectedColor: AppColor.secondaryColor, roundedEdges: Radius.circular(10)),
            ),
            // SizedBox(height: 20,),
            //
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 10),
            //   child: StepProgressIndicator(
            //     totalSteps: 5,
            //     currentStep: index,
            //     size: 20,
            //     padding: 6,
            //     selectedColor: AppColor.primaryColor,
            //     unselectedColor: AppColor.secondaryColor,
            //     roundedEdges: Radius.circular(10),
            //   ),
            // ),
            SizedBox(height: 20,),
           questionItem(),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  backButton(),
                  nextButton(),

                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget nextButton(){
    return GestureDetector(
      onTap: (){
        if((questions.length-1) == index){
          Get.toNamed(Routes.thankYou);
        }else{
          index++;

        }
        setState(() {

        });
      },
      child: Container(
        height: 41,width: 105,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          gradient: LinearGradient(
            colors: [AppColor.primaryColor, AppColor.red],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Text((questions.length-1) == index?"Finish":"Next",style: TextStyle(
              color:AppColor.white,fontSize: 20,fontFamily: appFontFamily,fontWeight: FontWeight.w400
          ),),
        ),
      ),
    );
  }

  Widget backButton(){
    return GestureDetector(
      onTap: (){
        if(index>0) {
          index --;
        }
        setState(() {

        });
      },
      child: Container(
        width: 105,height: 41,
        padding: EdgeInsets.all(1),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(11)),
          gradient: LinearGradient(
            colors: [AppColor.primaryColor, AppColor.red],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Container(
          width: 103, height: 39,
          decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Center(
            child: Text("Back",style: TextStyle(
                color:AppColor.primaryColor,fontSize: 20,fontFamily: appFontFamily,fontWeight: FontWeight.w400
            ),),
          ),
        ),
      ),
    );
  }

  Widget questionItem(){
    return  Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(questions[index].question,
            style: TextStyle(fontFamily: appFontFamily,fontWeight: FontWeight.w500,fontSize: 20,color: AppColor.primaryColor),
          ),
        ),
        SizedBox(height: 20,),
        ListView.builder(
          itemCount: questions[index].options.length,
          shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context,radioIndex){
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: RadioListTile(
              contentPadding:EdgeInsets.zero,
              title: Text(questions[index].options[radioIndex],style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400,fontFamily: appFontFamily,color: AppColor.primaryColor),),
              value: questions[index].options[radioIndex],
              activeColor: AppColor.primaryColor,
              groupValue: questions[index].selectedRadio,
              onChanged: (String? value) {
                print(value!);
                setState(() {
                  questions[index].selectedRadio = value!;
                });

              },
            ),
          );
        }),
      ],
    );
  }
}

class QuestionModel{
  QuestionModel({required this.question,required this.options,required this.selectedRadio});

  String question;
  List<String> options;
  String selectedRadio;

}
