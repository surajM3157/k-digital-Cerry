import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:piwotapp/constants/colors.dart';
import 'package:piwotapp/constants/font_family.dart';
import 'package:get/get.dart';
import 'package:piwotapp/responses/session_surveys_response.dart';
import '../../constants/images.dart';
import '../../repository/api_repo.dart';
import '../../route/route_names.dart';
import '../../widgets/app_themes.dart';
import '../../widgets/custom_progress_indicator.dart';

class SurveyPage extends StatefulWidget {
  const SurveyPage({super.key});

  @override
  State<SurveyPage> createState() => _SurveyPageState();
}

class _SurveyPageState extends State<SurveyPage> {

  String sessionId = "";

  // String selectedRadio = '';
  // List questions = [
  //   "1.How would you rate your overall experience at the event?",
  //   "2.How satisfied were you with the networking opportunities provided during the event?",
  //   "3.How likely are you to attend future events organized by PAN IIT Alumni India?",
  //   "4.How would you rate your overall experience at the event?",
  //   "5.How would you rate the organization and management of the event?"
  // ];
  int index = 0;
  // List<QuestionModel> questions = [
  //   QuestionModel(question: "1.How would you rate your overall experience at the event?", options: ["Excellent","Good","Average","Poor"], selectedRadio: ''),
  //   QuestionModel(question: "2.How satisfied were you with the networking opportunities provided during the event?", options: ["Excellent","Good","Average","Poor"], selectedRadio: ''),
  //   QuestionModel(question: "3.How likely are you to attend future events organized by PAN IIT Alumni India?", options: ["Excellent","Good","Average","Poor"], selectedRadio: ''),
  //   QuestionModel(question: "4.How would you rate your overall experience at the event?", options: ["Excellent","Good","Average","Poor"], selectedRadio: ''),
  //   QuestionModel(question: "5.How would you rate the organization and management of the event?", options: ["Excellent","Good","Average","Poor"], selectedRadio: ''),
  // ];

  bool isConnected = true;

  SessionSurveysData? sessionSurveysData;
  List<QuestionsDetails> questionList = [];
  String selectedValue = "";
  final Map<String, bool> selectedOptions = {};
  int _selectedRating = 0;
  List<int> rating = [];

  @override
  void initState() {
    sessionId = Get.arguments['session_id'];
    print("sessionId 1 $sessionId");
    fetchSessionSurvey();
    super.initState();
  }

  fetchSessionSurvey() async
  {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      isConnected = false;
      setState(() {

      });
    }else {
      isConnected = true;
      Future.delayed(Duration.zero, () {
        showLoader(context);
      });

      var response = await ApiRepo().getSessionSurveysResponse();

      if( response.data != null)
      {
        for(SessionSurveysData session in response.data!){
          if(sessionId == session.sessionId){
            sessionSurveysData = session;
            for(QuestionsDetails question in session.questionsDetails!){
              questionList.add(question);
            }
          }

        }
      }

      print("Question1 ${questionList[0].question}");
      print("Question2 ${questionList[1].question}");

      setState(() {

      });}

  }

  addSurvey()async{
    List<Map<String, dynamic>> answer = [];

    List<String> checkboxAns = [];

    if (questionList.isNotEmpty) {
      for (int i = 0; i < questionList.length; i++) {
        if (questionList[i].typeOf!
            .toLowerCase() ==
            "stars") {
          Map<String, dynamic> oneItemAns = {
            "questionId":
            "${questionList[i].sId.toString()}",
            "question":
            "${questionList[i].question.toString()}",
            "typeOf":
            "${questionList[i].typeOf.toString()}",
            "answer":
            "${(questionList[i].selectedStarOption == 0 ? 1 : questionList[i].selectedStarOption)}"
          };
          print(
              "selectedStarOption ${questionList[i].selectedStarOption}");

          answer.add(oneItemAns);
        } else if (questionList[i].typeOf!
            .toLowerCase() ==
            "singlechoice") {
          Map<String, dynamic> oneItemAns = {
            "questionId":
            "${questionList[i].sId.toString()}",
            "question":
            "${questionList[i].question.toString()}",
            "typeOf":
            "${questionList[i].typeOf.toString()}",
            "answer":
            "${questionList[i].selectedRadioOption.toString().trim()}"
          };

          answer.add(oneItemAns);
        } else if (questionList[i].typeOf!
            .toLowerCase() ==
            "multiplechoice") {
          String checkBoxAnswer = "";

          for (int op = 0;
          op <
              questionList[i]
                  .selectedCheckboxOptions.length;
          op++) {
            if (checkBoxAnswer == "") {
              if ( questionList[i]
                  .selectedCheckboxOptions[op] ==
                  true) {
                checkBoxAnswer =
                "${ questionList[i].selectedCheckboxOptions![op].toString().trim()}";
                checkboxAns.add( questionList[i].selectedCheckboxOptions[op].toString().trim());
              }
            } else {
              if (questionList[i].selectedCheckboxOptions[op] ==
                  true) {
                checkBoxAnswer = "${checkBoxAnswer}, " +
                    "${questionList[i].selectedCheckboxOptions![op].toString().trim()}";
                checkboxAns.add("${questionList[i].selectedCheckboxOptions[op].toString().trim()}");
              }
            }
          }

          Map<String, dynamic> oneItemAns = {
            "questionId":
            "${questionList[i].sId.toString()}",
            "question":
            "${questionList[i].question.toString()}",
            "typeOf":
            "${questionList[i].typeOf.toString()}",
            "answer": checkboxAns
          };

          answer.add(oneItemAns);
        } else if (questionList[i].typeOf!
            .toLowerCase() ==
            "multiline") {
          Map<String, dynamic> oneItemAns = {
            "questionId":
            "${questionList[i].sId.toString()}",
            "question":
            "${questionList[i].question.toString()}",
            "typeOf":
            "${questionList[i].typeOf.toString()}",
            "answer":
            "${questionList[i].multiLineController.text.toString().trim()}"
          };

          answer.add(oneItemAns);
        }
      }
    }

    final Map<String, dynamic> params = {
      "room_id": sessionSurveysData?.roomId, "session_id": sessionSurveysData?.sessionId,
      "questionAndAnswers": answer,"ratingAverage": calculateAverageRating()
    };

    await ApiRepo().addSurvey(params);
  }


  double calculateAverageRating() {
    // Initialize sum and count of rated questions
    double totalRating = 0;
    int ratedQuestionsCount = 0;

    for (var question in questionList) {
      if (question.selectedStarOption != null && question.selectedStarOption > 0) {
        // Add rating and count if the question has a rating
        totalRating += question.selectedStarOption;
        ratedQuestionsCount++;
      }
    }

    // Calculate and return average rating
    return ratedQuestionsCount > 0 ? totalRating / ratedQuestionsCount : 0.0;
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
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomProgressIndicator(
                  totalSteps: questionList.length, currentStep: index, size: 20, padding: 6, selectedColor: AppColor.primaryColor, unselectedColor: AppColor.secondaryColor, roundedEdges: const Radius.circular(10)),
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
            const SizedBox(height: 20,),
           questionItem(),
            const SizedBox(height: 20,),
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
        if((questionList.length-1) == index){

          addSurvey();
        }else{
          index++;

        }
        setState(() {

        });
      },
      child: Container(
        height: 41,width: 105,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          gradient: LinearGradient(
            colors: [AppColor.primaryColor, AppColor.red],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Text((questionList.length-1) == index?"Finish":"Next",style: TextStyle(
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
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(11)),
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
              borderRadius: const BorderRadius.all(Radius.circular(10)),
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
          child: Text(questionList[index].question??"",
            style: TextStyle(fontFamily: appFontFamily,fontWeight: FontWeight.w500,fontSize: 20,color: AppColor.primaryColor),
          ),
        ),
        const SizedBox(height: 20,),
        questionList[index].typeOf?.toLowerCase() == "multiline"?
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextFormField(
                controller: questionList[index].multiLineController,
                maxLines: 5,
                cursorColor: AppColor.primaryColor,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColor.lightGrey),borderRadius: BorderRadius.circular(10)),
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColor.lightGrey),borderRadius: BorderRadius.circular(10))
                ),
              ),
            )
            :questionList[index].typeOf?.toLowerCase()=="multiplechoice"?ListView(
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(horizontal: 16),
          children: [
            if (questionList[index].typeOf?.toLowerCase() == "multiplechoice")
              ...List.generate(questionList[index].options!.length, (optionIndex) {
                // Ensure `selectedCheckboxOptions` is initialized as a boolean list
                if (questionList[index].selectedCheckboxOptions.length != questionList[index].options!.length) {
                  questionList[index].selectedCheckboxOptions = List<bool>.filled(
                      questionList[index].options!.length, false);
                }

                return CheckboxListTile(
                  activeColor: AppColor.primaryColor,
                  title: Text(questionList[index].options![optionIndex]),
                  value: questionList[index].selectedCheckboxOptions[optionIndex],
                  onChanged: (value) {
                    setState(() {
                      questionList[index].selectedCheckboxOptions[optionIndex] = value!;
                    });
                  },
                );
              })
          ],
        )
            :questionList[index].typeOf?.toLowerCase()== "singlechoice"?ListView.builder(
          itemCount: questionList[index].options?.length,
          shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context,radioIndex){
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: RadioListTile<String>(
              contentPadding:EdgeInsets.zero,
              title: Text(questionList[index].options?[radioIndex]??"",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400,fontFamily: appFontFamily,color: AppColor.primaryColor),),
              value: questionList[index].options![radioIndex],
              activeColor: AppColor.primaryColor,
              groupValue: questionList[index].selectedRadioOption,
              onChanged: (String? value) {
                print(value!);
                setState(() {
                  questionList[index].selectedRadioOption = value;
                });

              },
            ),
          );
        }):questionList[index].typeOf?.toLowerCase()== "stars"?Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (starIndex) {
              return IconButton(
                icon: Icon(
                  Icons.star,
                  color: starIndex < questionList[index].selectedStarOption ? Colors.amber : Colors.grey,
                ),
                iconSize: 40.0,
                onPressed: () {
                  setState(() {
                    // Update the rating based on tapped star
                    questionList[index].selectedStarOption = starIndex + 1;
                  });
                },
              );
            })):SizedBox.shrink(),
      ],
    );
  }
}

