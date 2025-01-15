import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:piwotapp/constants/colors.dart';
import 'package:piwotapp/constants/font_family.dart';
import 'package:get/get.dart';
import 'package:piwotapp/responses/global_survey_response.dart';
import 'package:piwotapp/responses/session_surveys_response.dart';
import '../../constants/images.dart';
import '../../repository/api_repo.dart';
import '../../route/route_names.dart';
import '../../shared prefs/pref_manager.dart';
import '../../widgets/app_themes.dart';
import '../../widgets/custom_progress_indicator.dart';
import '../../widgets/gradient_text.dart';

class SurveyPage extends StatefulWidget {
  const SurveyPage({super.key});

  @override
  State<SurveyPage> createState() => _SurveyPageState();
}

class _SurveyPageState extends State<SurveyPage> {

  String sessionId = "";
  String type = "";
  String surveyName = ""; // Declare the variable for survey name

  int index = 0;

  bool isConnected = true;

  SessionSurveysData? sessionSurveysData;
  List<QuestionsDetails> questionList = [];
  List<Questions> globalQuestionList = [];
  String selectedValue = "";
  final Map<String, bool> selectedOptions = {};
  List<int> rating = [];
  bool isSurvey = false;

  GlobalSurveyData? globalSurveyData;

  @override
  void initState() {
    sessionId = Get.arguments['session_id'];
    type = Get.arguments['type'];
    print("sessionId 1 $sessionId");
    if(sessionId.isEmpty){
      fetchGlobalSurvey(type);
    }else {
      fetchSessionSurvey();
    }
    super.initState();
  }

  surveyStatus(String surveyId)async{

    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      isConnected = false;
      EasyLoading.showToast("No Internet",
          dismissOnTap: true,
          duration: const Duration(seconds: 1),
          toastPosition: EasyLoadingToastPosition.center);
      setState(() {

      });
    }else {
      isConnected = true;
      Map<String, String> params = <String, String>{};
      params["survey_id"] = surveyId;
      params["guest_id"] = Prefs.checkUserId;



      Future.delayed(Duration.zero, () {
        showLoader(context);
      });

      isSurvey =  await ApiRepo().surveyStatus(params);
    }
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
            surveyName = session.surveyName ?? "";
            await surveyStatus(session.sId??"");
            if(isSurvey){
              Get.offAllNamed(Routes.thankYou,arguments: {
                'surveyStatus':true
              });
            }else {
              for (QuestionsDetails question in session.questionsDetails!) {
                questionList.add(question);
              }
            }
          }

        }
      }

      // print("Question1 ${questionList[0].question}");
      // print("Question2 ${questionList[1].question}");

      setState(() {

      });}

  }

  fetchGlobalSurvey(String type) async
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

      var response = await ApiRepo().getGlobalSurveysResponse(type);

      if( response.data != null)
      {
        globalSurveyData = response.data?[0];
        surveyName = globalSurveyData?.surveyName ?? "";
        await surveyStatus(globalSurveyData?.sId??"");

        if(isSurvey){
          Get.offAllNamed(Routes.thankYou,arguments: {
            'surveyStatus':true
          });
        }else{
          for(Questions question in globalSurveyData!.questions!){
            globalQuestionList.add(question);

          }}
      }

      // print("Question1 ${globalQuestionList[0].question}");
      // print("Question2 ${globalQuestionList[1].question}");

      setState(() {

      });}

  }

  List globalSessionList(){
    if(sessionId.isEmpty){
      return globalQuestionList;
    }else{
      return questionList;
    }
  }

  addSurvey()async{
    List<Map<String, dynamic>> answer = [];

    List<String> checkboxAns = [];

    if (globalSessionList().isNotEmpty) {
      for (int i = 0; i < globalSessionList().length; i++) {
        if (globalSessionList()[i].typeOf!
            .toLowerCase() ==
            "stars") {
          Map<String, dynamic> oneItemAns = {
            "questionId":
            "${globalSessionList()[i].sId.toString()}",
            "question":
            "${globalSessionList()[i].question.toString()}",
            "typeOf":
            "${globalSessionList()[i].typeOf.toString()}",
            "answer":
            "${(globalSessionList()[i].selectedStarOption == 0 ? 1 : globalSessionList()[i].selectedStarOption)}"
          };
          print(
              "selectedStarOption ${globalSessionList()[i].selectedStarOption}");

          answer.add(oneItemAns);
        } else if (globalSessionList()[i].typeOf!
            .toLowerCase() ==
            "singlechoice") {
          Map<String, dynamic> oneItemAns = {
            "questionId":
            "${globalSessionList()[i].sId.toString()}",
            "question":
            "${globalSessionList()[i].question.toString()}",
            "typeOf":
            "${globalSessionList()[i].typeOf.toString()}",
            "answer":
            "${globalSessionList()[i].selectedRadioOption.toString().trim()}"
          };

          answer.add(oneItemAns);
        } else if (globalSessionList()[i].typeOf!
            .toLowerCase() ==
            "multiplechoice") {
          String checkBoxAnswer = "";

          for (int op = 0;
          op <
              globalSessionList()[i]
                  .selectedCheckboxOptions.length;
          op++) {
            if (checkBoxAnswer == "") {
              if ( globalSessionList()[i]
                  .selectedCheckboxOptions[op] ==
                  true) {
                checkBoxAnswer =
                "${ globalSessionList()[i].options![op].toString().trim()}";
                checkboxAns.add( globalSessionList()[i].options![op].toString().trim());
              }
            } else {
              if (globalSessionList()[i].selectedCheckboxOptions[op] ==
                  true) {
                checkBoxAnswer = "${checkBoxAnswer}, " +
                    "${globalSessionList()[i].options![op].toString().trim()}";
                checkboxAns.add("${globalSessionList()[i].options![op].toString().trim()}");
              }
            }
          }

          Map<String, dynamic> oneItemAns = {
            "questionId":
            "${globalSessionList()[i].sId.toString()}",
            "question":
            "${globalSessionList()[i].question.toString()}",
            "typeOf":
            "${globalSessionList()[i].typeOf.toString()}",
            "answer": checkboxAns
          };

          answer.add(oneItemAns);
        } else if (globalSessionList()[i].typeOf!
            .toLowerCase() ==
            "multiline") {
          Map<String, dynamic> oneItemAns = {
            "questionId":
            "${globalSessionList()[i].sId.toString()}",
            "question":
            "${globalSessionList()[i].question.toString()}",
            "typeOf":
            "${globalSessionList()[i].typeOf.toString()}",
            "answer":
            "${globalSessionList()[i].multiLineController.text.toString().trim()}"
          };

          answer.add(oneItemAns);
        }
      }
    }


    final Map<String, dynamic> params =sessionId.isEmpty?{
      "is_global":globalSurveyData?.isGlobal,
      // "room_id": null, "session_id": null,
      "questionAndAnswers": answer,"ratingAverage": calculateAverageRating(),"survey_id":globalSurveyData?.sId
    } :{
      "room_id": sessionSurveysData?.roomId, "session_id": sessionSurveysData?.sessionId,
      "questionAndAnswers": answer,"ratingAverage": calculateAverageRating(),"survey_id":sessionSurveysData?.sId,"is_global":sessionSurveysData?.isGlobal
    };

    print("is_global ${globalSurveyData?.isGlobal}");
    await ApiRepo().addSurvey(params);
  }




  double calculateAverageRating() {
    // Initialize sum and count of rated questions
    double totalRating = 0;
    int ratedQuestionsCount = 0;

    for (var question in globalSessionList()) {
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
          child: globalSessionList().isNotEmpty
              ? ListView(
            children: [
              const SizedBox(height: 20),

              // Survey Name with Gradient Text
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: GradientText(
                  text: surveyName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    fontFamily: appFontFamily,
                  ),
                  gradient: LinearGradient(
                    colors: AppColor.gradientColors,
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
              ),

              const SizedBox(height: 25),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomProgressIndicator(
                  totalSteps: globalSessionList().length,
                  currentStep: index,
                  size: 14,
                  padding: 6,
                  selectedColor: AppColor.primaryColor,
                  unselectedColor: AppColor.secondaryColor,
                  roundedEdges: const Radius.circular(10),
                ),
              ),

              const SizedBox(height: 25),

              questionItem(),

              const SizedBox(height: 20),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    backButton(),
                    nextButton(),
                  ],
                ),
              ),
            ],
          )
              : const SizedBox.shrink(),
        )

    );
  }

  Widget nextButton(){
    return GestureDetector(
      onTap: () {
        // Check if the last question is a multi-line question and validate if the input is empty or only contains spaces
        if ((globalSessionList().length - 1) == index) {
          if (globalSessionList()[index].typeOf?.toLowerCase() == "multiline" &&
              (globalSessionList()[index].multiLineController.text.trim().isEmpty)) {
            EasyLoading.showToast("Please Enter Valid Feedback",
                dismissOnTap: true,
                duration: const Duration(seconds: 1),
                toastPosition: EasyLoadingToastPosition.center);
          } else if (globalSessionList()[index].typeOf?.toLowerCase() == "multiplechoice" &&
              globalSessionList()[index].selectedCheckboxOptions.every((element) => element == false)) {
            EasyLoading.showToast("Please select at least one option",
                dismissOnTap: true,
                duration: const Duration(seconds: 1),
                toastPosition: EasyLoadingToastPosition.center);
          } else if (globalSessionList()[index].typeOf?.toLowerCase() == "singlechoice" &&
              globalSessionList()[index].selectedRadioOption == null) {
            EasyLoading.showToast("Please select an option",
                dismissOnTap: true,
                duration: const Duration(seconds: 1),
                toastPosition: EasyLoadingToastPosition.center);
          } else if (globalSessionList()[index].typeOf?.toLowerCase() == "stars" &&
              globalSessionList()[index].selectedStarOption == 0) {
            EasyLoading.showToast("Please select stars",
                dismissOnTap: true,
                duration: const Duration(seconds: 1),
                toastPosition: EasyLoadingToastPosition.center);
          } else {
            addSurvey();
          }
        } else {
          // For other question types
          if (globalSessionList()[index].typeOf?.toLowerCase() == "multiline" &&
              (globalSessionList()[index].multiLineController.text.trim().isEmpty)) {
            EasyLoading.showToast("Please Enter Valid Feedback",
                dismissOnTap: true,
                duration: const Duration(seconds: 1),
                toastPosition: EasyLoadingToastPosition.center);
          } else if (globalSessionList()[index].typeOf?.toLowerCase() == "multiplechoice" &&
              globalSessionList()[index].selectedCheckboxOptions.every((element) => element == false)) {
            EasyLoading.showToast("Please select at least one option",
                dismissOnTap: true,
                duration: const Duration(seconds: 1),
                toastPosition: EasyLoadingToastPosition.center);
          } else if (globalSessionList()[index].typeOf?.toLowerCase() == "singlechoice" &&
              globalSessionList()[index].selectedRadioOption == null) {
            EasyLoading.showToast("Please select an option",
                dismissOnTap: true,
                duration: const Duration(seconds: 1),
                toastPosition: EasyLoadingToastPosition.center);
          } else if (globalSessionList()[index].typeOf?.toLowerCase() == "stars" &&
              globalSessionList()[index].selectedStarOption == 0) {
            EasyLoading.showToast("Please select stars",
                dismissOnTap: true,
                duration: const Duration(seconds: 1),
                toastPosition: EasyLoadingToastPosition.center);
          } else {
            index++;
          }
        }
        setState(() {});
      },
      child: Container(
        height: 41,
        width: 105,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          gradient: LinearGradient(
            colors: AppColor.gradientColors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Text(
            (globalSessionList().length - 1) == index ? "Finish" : "Next",
            style: TextStyle(
              color: AppColor.white,
              fontSize: 20,
              fontFamily: appFontFamily,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }

  Widget backButton(){
    return index ==0?const SizedBox.shrink():GestureDetector(
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
            colors: AppColor.gradientColors,
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
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start, // Ensure text starts from top
            children: [
              Text(
                "${index + 1}. ",  // This will show question number starting from 1
                style: TextStyle(
                  fontFamily: appFontFamily,
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  color: AppColor.primaryColor,
                ),
              ),
              Expanded(
                child: Text(
                  globalSessionList()[index].question ?? "",
                  style: const TextStyle(
                    fontFamily: appFontFamily,
                    fontWeight: FontWeight.w500,
                    fontSize: 19,
                    color: Color(0xFF1B1464), // Set question text color here
                  ),
                  maxLines: null,
                  overflow: TextOverflow.visible,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        // Based on question type, show appropriate widgets (multiline, multiplechoice, etc.)
        globalSessionList()[index].typeOf?.toLowerCase() == "multiline" ?
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TextFormField(
            controller: globalSessionList()[index].multiLineController,
            maxLines: 5,
            cursorColor: AppColor.primaryColor,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColor.lightGrey),
                borderRadius: BorderRadius.circular(0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColor.lightGrey),
                borderRadius: BorderRadius.circular(0),
              ),
            ),
          ),
        )
            : globalSessionList()[index].typeOf?.toLowerCase() == "multiplechoice" ?
        ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          children: [
            if (globalSessionList()[index].typeOf?.toLowerCase() == "multiplechoice")
              ...List.generate(globalSessionList()[index].options!.length, (optionIndex) {
                if (globalSessionList()[index].selectedCheckboxOptions.length != globalSessionList()[index].options!.length) {
                  globalSessionList()[index].selectedCheckboxOptions = List<bool>.filled(
                      globalSessionList()[index].options!.length, false);
                }

                return CheckboxListTile(
                  activeColor: AppColor.primaryColor,
                  title: Text(globalSessionList()[index].options![optionIndex]),
                  value: globalSessionList()[index].selectedCheckboxOptions[optionIndex],
                  onChanged: (value) {
                    setState(() {
                      globalSessionList()[index].selectedCheckboxOptions[optionIndex] = value!;
                    });
                  },
                );
              })
          ],
        )
            : globalSessionList()[index].typeOf?.toLowerCase() == "singlechoice" ?
        ListView.builder(
            itemCount: globalSessionList()[index].options?.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, radioIndex) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: RadioListTile<String>(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    globalSessionList()[index].options?[radioIndex] ?? "",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      fontFamily: appFontFamily,
                      color: AppColor.primaryColor,
                    ),
                  ),
                  value: globalSessionList()[index].options![radioIndex],
                  activeColor: AppColor.primaryColor,
                  groupValue: globalSessionList()[index].selectedRadioOption,
                  onChanged: (String? value) {
                    setState(() {
                      globalSessionList()[index].selectedRadioOption = value;
                    });
                  },
                ),
              );
            })
            : globalSessionList()[index].typeOf?.toLowerCase() == "stars" ?
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (starIndex) {
              return IconButton(
                icon: Icon(
                  Icons.star,
                  color: starIndex < globalSessionList()[index].selectedStarOption ? Colors.amber : Colors.grey,
                ),
                iconSize: 40.0,
                onPressed: () {
                  setState(() {
                    globalSessionList()[index].selectedStarOption = starIndex + 1;
                  });
                },
              );
            })
        )
            : const SizedBox.shrink(),
      ],
    );
  }


}