import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;
import 'package:piwotapp/responses/about_us_response.dart';
import 'package:piwotapp/responses/agenda_response.dart';
import 'package:piwotapp/responses/banner_response.dart';
import 'package:piwotapp/responses/faq_response.dart';
import 'package:piwotapp/responses/floor_plan_response.dart';
import 'package:piwotapp/responses/friend_list_response.dart';
import 'package:piwotapp/responses/global_survey_response.dart';
import 'package:piwotapp/responses/guest_details_response.dart';
import 'package:piwotapp/responses/guest_list_response.dart';
import 'package:piwotapp/responses/list_link_response.dart';
import 'package:piwotapp/responses/live_session_response.dart';
import 'package:piwotapp/responses/otp_response.dart';
import 'package:piwotapp/responses/partner_response.dart';
import 'package:piwotapp/responses/pending_request_response.dart';
import 'package:piwotapp/responses/sent_requests_response.dart';
import 'package:piwotapp/responses/session_list_response.dart';
import 'package:piwotapp/responses/session_surveys_response.dart';
import 'package:piwotapp/responses/speaker_response.dart';
import 'package:piwotapp/responses/sponsor_response.dart';
import 'package:http_parser/http_parser.dart';
import '../constants/api_urls.dart';
import '../route/route_names.dart';
import '../services/notification_service.dart';
import '../shared prefs/pref_manager.dart';


class ApiRepo
{

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;



  loginResponse(var params,String type) async {
    final response = await http.post(Uri.parse("${ApiUrls.loginApiUrl}?type=$type"),
      body: params,
    );

    Get.back();

    print("params ${params}");
    print("Api url ${ApiUrls.loginApiUrl}?type=$type");
    print("response ${response.body}");


    if(response.statusCode == 200)
    {

      var res = await json.decode(response.body);

      if(res["statusCode"] != 200){
        EasyLoading.showToast("${res['message']}",
            dismissOnTap: true,
            duration: const Duration(seconds: 1),
            toastPosition: EasyLoadingToastPosition.center);
      }else {
        EasyLoading.showToast("${res['message']}",
            dismissOnTap: true,
            duration: const Duration(seconds: 1),
            toastPosition: EasyLoadingToastPosition.center);
        Get.toNamed(Routes.otp, arguments: {
          "data": res['data'],
          'mobile_number': params['mobile_number']
        });
      }
    }
    else
    {
      var res = await json.decode(response.body);

      EasyLoading.showToast("${res['message']}",
          dismissOnTap: true,
          duration: const Duration(seconds: 1),
          toastPosition: EasyLoadingToastPosition.center);
    }
  }

  resedOtp(var params) async {
    final response = await http.post(Uri.parse("${ApiUrls.loginApiUrl}"),
      body: params,
    );

    Get.back();

    print("params ${params}");
    print("Api url ${ApiUrls.loginApiUrl}");
    print("response ${response.body}");


    if(response.statusCode == 200)
    {

      var res = await json.decode(response.body);

      EasyLoading.showToast("OTP Send Successfully",
          dismissOnTap: true,
          duration: const Duration(seconds: 1),
          toastPosition: EasyLoadingToastPosition.center);

    }
    else
    {
      var res = await json.decode(response.body);

      EasyLoading.showToast("${res['message']}",
          dismissOnTap: true,
          duration: const Duration(seconds: 1),
          toastPosition: EasyLoadingToastPosition.center);
    }
  }

  verifyOtp(var params, String id) async {
    final response = await http.post(Uri.parse("${ApiUrls.otpApiUrl}/$id"),
      body: params,
    );

    Get.back();

    print("params ${params}");
    print("Api url ${ApiUrls.otpApiUrl}/$id");
    print("response ${response.body}");


    if(response.statusCode == 200)
    {

      OtpResponse model = otpResponseFromJson(response.body);

      EasyLoading.showToast("${model.message}",
          dismissOnTap: true,
          duration: const Duration(seconds: 1),
          toastPosition: EasyLoadingToastPosition.center);

      Prefs.setBool('is_logged_in_new', true);
      Prefs.setString('user_id_new', "${model.data?.guestDetails?.sId?? ""}");
      Prefs.setString('user_email_new', "${model.data?.guestDetails?.emailId ?? ""}");
      Prefs.setString('user_auth_token', "${model.data?.token ?? ""}");
      Prefs.setString("user_name_new", "${model.data?.guestDetails?.firstName ?? ""} ${model.data?.guestDetails?.lastName ?? ""}");
      Prefs.setString("mobile_no", "${model.data?.guestDetails?.mobileNumber}");
      Prefs.setBool("notificationsEnabled", true);
      Prefs.loadData();
      Prefs.load();




      _firestore.collection("users").doc("${model.data?.guestDetails?.sId?? ""}").set(
          {
            "uid":"${model.data?.guestDetails?.sId?? ""}",
            "name":"${model.data?.guestDetails?.firstName ?? ""} ${model.data?.guestDetails?.lastName ?? ""}",
          }, SetOptions(merge: true)
      );
      print("Prefs.checkProfile ${Prefs.checkProfile}");
      NotificationService fcmService = NotificationService();
      if(Prefs.checkNotificationEnabled == true){
        fcmService.subscribeToTopic('allUsers');
        fcmService.subscribeToTopic(model.data?.guestDetails?.sId?? "");
        print("subscribe to ${model.data?.guestDetails?.sId?? ""}");
      }
      if(Prefs.checkProfile == true){
        Get.offAllNamed(Routes.editProfile);
      }else{
      Get.offAllNamed(Routes.home);
      }

    }
    else
    {
      var res = await json.decode(response.body);

      EasyLoading.showToast("${res['message']}",
          dismissOnTap: true,
          duration: const Duration(seconds: 1),
          toastPosition: EasyLoadingToastPosition.center);
    }
  }

  Future<SpeakerResponse> getSpeakerResponse(String search,bool isHome) async {

    final response = await http.get(Uri.parse("${ApiUrls.speakerApiUrl}?search=$search"), headers: {'token': '${Prefs.checkAuthToken}',});

    var res = await json.decode(response.body);

    // if(res['message'] == "Token expired."){
    //   Prefs.setBool('is_logged_in_new', false);
    //   Prefs.setString('user_id_new', "");
    //   Prefs.setString('user_email_new', "");
    //   Prefs.setString('user_auth_token', "");
    //   Prefs.setString("user_name_new", "");
    //   Prefs.setString("mobile_no", "");
    //   Get.offAllNamed(Routes.login);
    // }

    if(isHome){}else
      {
     Get.back();}
    print("Api url ${ApiUrls.speakerApiUrl}?search=$search");
    print("response ${response.body}");

    return speakerResponseFromJson(response.body);
  }

  Future<SponsorResponse> getSponsorResponse(bool isHome) async {

    final response = await http.get(Uri.parse("${ApiUrls.sponsorApiUrl}"), headers: {'token': '${Prefs.checkAuthToken}',});


    var res = await json.decode(response.body);

    // if(res['message'] == "Token expired."){
    //   Prefs.setBool('is_logged_in_new', false);
    //   Prefs.setString('user_id_new', "");
    //   Prefs.setString('user_email_new', "");
    //   Prefs.setString('user_auth_token', "");
    //   Prefs.setString("user_name_new", "");
    //   Prefs.setString("mobile_no", "");
    //   Get.offAllNamed(Routes.login);
    // }
    if(isHome){}else
    {
      Get.back();}
    print("Api url ${ApiUrls.sponsorApiUrl}");
    print("response ${response.body}");

    return sponsorResponseFromJson(response.body);
  }

  Future<PartnerResponse> getPartnerResponse() async {

    final response = await http.get(Uri.parse("${ApiUrls.partnerApiUrl}"), headers: {'token': '${Prefs.checkAuthToken}',});

    var res = await json.decode(response.body);

    // if(res['message'] == "Token expired."){
    //   Prefs.setBool('is_logged_in_new', false);
    //   Prefs.setString('user_id_new', "");
    //   Prefs.setString('user_email_new', "");
    //   Prefs.setString('user_auth_token', "");
    //   Prefs.setString("user_name_new", "");
    //   Prefs.setString("mobile_no", "");
    //   Get.offAllNamed(Routes.login);
    // }
    Get.back();
    print("Api url ${ApiUrls.partnerApiUrl}");
    print("response ${response.body}");

    return partnerResponseFromJson(response.body);
  }

  Future<BannerResponse> getBannerResponse() async {

    final response = await http.get(Uri.parse("${ApiUrls.bannerApiUrl}"), headers: {'token': '${Prefs.checkAuthToken}',});

    var res = await json.decode(response.body);

    if(res['message'] == "Token expired."|| res['message'] == 'Your account has been suspended. Please contact admin.'){
      Prefs.setBool('is_logged_in_new', false);
      Prefs.setString('user_id_new', "");
      Prefs.setString('user_email_new', "");
      Prefs.setString('user_auth_token', "");
      Prefs.setString("user_name_new", "");
      Prefs.setString("mobile_no", "");
      Get.offAllNamed(Routes.login);
    }
    Get.back();
    print("Api url ${ApiUrls.bannerApiUrl}");
    print("response ${response.body}");

    return bannerResponseFromJson(response.body);
  }

  Future<AgendaResponse> getAgendaResponse(String date) async {

    final response = await http.get(Uri.parse("${ApiUrls.agendaApiUrl}?date=$date"), headers: {'token': '${Prefs.checkAuthToken}',});
    var res = await json.decode(response.body);

    if(res['message'] == "Token expired."|| res['message'] == 'Your account has been suspended. Please contact admin.'){
      Prefs.setBool('is_logged_in_new', false);
      Prefs.setString('user_id_new', "");
      Prefs.setString('user_email_new', "");
      Prefs.setString('user_auth_token', "");
      Prefs.setString("user_name_new", "");
      Prefs.setString("mobile_no", "");
      Get.offAllNamed(Routes.login);
    }
    Get.back();
    print("Api url ${ApiUrls.agendaApiUrl}?date=$date");
    print("response ${response.body}");

    return agendaResponseFromJson(response.body);
  }

  Future<SessionListResponse> getSessionListResponse(String date) async {

    final response = await http.get(Uri.parse("${ApiUrls.sessionListApiUrl}?date=$date"), headers: {'token': '${Prefs.checkAuthToken}',});
    var res = await json.decode(response.body);

    if(res['message'] == "Token expired."|| res['message'] == 'Your account has been suspended. Please contact admin.'){
      Prefs.setBool('is_logged_in_new', false);
      Prefs.setString('user_id_new', "");
      Prefs.setString('user_email_new', "");
      Prefs.setString('user_auth_token', "");
      Prefs.setString("user_name_new", "");
      Prefs.setString("mobile_no", "");
      Get.offAllNamed(Routes.login);
    }
    Get.back();
    print("Api url ${ApiUrls.sessionListApiUrl}?date=$date");
    print("response ${response.body}");

    return sessionResponseFromJson(response.body);
  }

  Future<FloorPlanResponse> getFloorPlanResponse() async {

    final response = await http.get(Uri.parse("${ApiUrls.floorPlanApiUrl}"), headers: {'token': '${Prefs.checkAuthToken}',});
    var res = await json.decode(response.body);

    if(res['message'] == "Token expired."|| res['message'] == 'Your account has been suspended. Please contact admin.'){
      Prefs.setBool('is_logged_in_new', false);
      Prefs.setString('user_id_new', "");
      Prefs.setString('user_email_new', "");
      Prefs.setString('user_auth_token', "");
      Prefs.setString("user_name_new", "");
      Prefs.setString("mobile_no", "");
      Get.offAllNamed(Routes.login);
    }
    Get.back();
    print("Api url ${ApiUrls.floorPlanApiUrl}");
    print("response ${response.body}");

    return floorPlanResponseFromJson(response.body);
  }

  Future<ListLinkResponse> getListLinksResponse(bool isHome) async {

    final response = await http.get(Uri.parse("${ApiUrls.listLinksApiUrl}"), headers: {'token': '${Prefs.checkAuthToken}',});
    var res = await json.decode(response.body);

    // if(res['message'] == "Token expired."){
    //   Prefs.setBool('is_logged_in_new', false);
    //   Prefs.setString('user_id_new', "");
    //   Prefs.setString('user_email_new', "");
    //   Prefs.setString('user_auth_token', "");
    //   Prefs.setString("user_name_new", "");
    //   Prefs.setString("mobile_no", "");
    //   Get.offAllNamed(Routes.login);
    // }
    if(isHome){}else{
    Get.back();}
    print("Api url ${ApiUrls.listLinksApiUrl}");
    print("response ${response.body}");

    return listLinkResponseFromJson(response.body);
  }

  Future<String> getQRCodeResponse() async {

    final response = await http.get(Uri.parse("${ApiUrls.qrcodeApiUrl}?id=${Prefs.checkUserId}"), headers: {'token': '${Prefs.checkAuthToken}',});
    var res = await json.decode(response.body);
    print("Api url ${ApiUrls.qrcodeApiUrl}?id=${Prefs.checkUserId}");
    print("response ${response.body}");

    return res['data'];
  }

  Future<LiveSessionResponse> getLiveSessionResponse(bool isHome) async {

    final response = await http.get(Uri.parse("${ApiUrls.liveSessionApiUrl}"), headers: {'token': '${Prefs.checkAuthToken}',});
    var res = await json.decode(response.body);

    // if(res['message'] == "Token expired."){
    //   Prefs.setBool('is_logged_in_new', false);
    //   Prefs.setString('user_id_new', "");
    //   Prefs.setString('user_email_new', "");
    //   Prefs.setString('user_auth_token', "");
    //   Prefs.setString("user_name_new", "");
    //   Prefs.setString("mobile_no", "");
    //   Get.offAllNamed(Routes.login);
    // }
    if(isHome){}else {
      Get.back();
    }
    print("Api url ${ApiUrls.liveSessionApiUrl}");
    print("response ${response.body}");

    return liveSessionResponseFromJson(response.body);
  }


  Future<GuestDetailsResponse> getGuestDetailsResponse() async {

    final response = await http.get(Uri.parse("${ApiUrls.guestDetailsApiUrl}/${Prefs.checkUserId}"), headers: {'token': '${Prefs.checkAuthToken}',});
    var res = await json.decode(response.body);

    if(res['message'] == "Token expired."|| res['message'] == 'Your account has been suspended. Please contact admin.'){
      Prefs.setBool('is_logged_in_new', false);
      Prefs.setString('user_id_new', "");
      Prefs.setString('user_email_new', "");
      Prefs.setString('user_auth_token', "");
      Prefs.setString("user_name_new", "");
      Prefs.setString("mobile_no", "");
      Get.offAllNamed(Routes.login);
    }
    Get.back();
    print("Api url ${ApiUrls.floorPlanApiUrl}");
    print("response ${response.body}");

    return guestDetailsResponseFromJson(response.body);
  }

  updateProfile(Map<String, dynamic> params, {File? image}) async {

    var uri = Uri.parse("${ApiUrls.updateProfileApiUrl}/${Prefs.checkUserId}");
    var request = http.MultipartRequest('POST', uri);
    request.fields.addAll(params.map((key, value) => MapEntry(key, value.toString())));
    print("params $params");
    request.headers['token'] = '${Prefs.checkAuthToken}';
    if(image != null){
      final extension = p.extension(image.path);
      print('extension $extension');
      request.files.add(
        http.MultipartFile.fromBytes(
            'guest_profile_image',
            File(image.path).readAsBytesSync(),
            filename: image.path.split("/").last,
            contentType: MediaType(image.toString(), extension)
        ),
      );
    }

    var responseSend = await request.send();

    var response = await http.Response.fromStream(responseSend);

    // final response = await http.post(Uri.parse("${ApiUrls.updateProfileApiUrl}/${Prefs.checkUserId}"),
    //   body: params,
    // );

    Get.back();

    print("params ${params}");
    print("Api url ${ApiUrls.updateProfileApiUrl}/${Prefs.checkUserId}");
    print("response ${response.body}");


    if(response.statusCode == 200)
    {

      Prefs.setBool("is_profile_new", false);
      var res = await json.decode(response.body);

      if(res["data"]["guest_profile_image"] != null) {
        _firestore.collection("users").doc(Prefs.checkUserId).set(
          {
            "uid":Prefs.checkUserId,
            "name":res["data"]["first_name"] +" "+ res["data"]["last_name"],
            "profile": ApiUrls.imageUrl + res["data"]["guest_profile_image"]
          }, SetOptions(merge: true)
      );
      }else{
        _firestore.collection("users").doc(Prefs.checkUserId).set(
            {
              "uid":Prefs.checkUserId,
              "name":res["data"]["first_name"] +" "+ res["data"]["last_name"],
            }, SetOptions(merge: true)
        );
      }
      Get.offAllNamed(Routes.home);
      EasyLoading.showToast("${res['message']}",
          dismissOnTap: true,
          duration: const Duration(seconds: 1),
          toastPosition: EasyLoadingToastPosition.center);

    }
    else
    {
      var res = await json.decode(response.body);

      EasyLoading.showToast("${res['message']}",
          dismissOnTap: true,
          duration: const Duration(seconds: 1),
          toastPosition: EasyLoadingToastPosition.center);
    }
  }


 contactus(var params) async {
    try{
      final response = await http.post(Uri.parse("${ApiUrls.contactusApiUrl}"),
          body: params,headers: {'token': '${Prefs.checkAuthToken}',}
      );

      Get.back();

      print("params ${params}");
      print("Api url ${ApiUrls.contactusApiUrl}");
      print("response ${response.body}");


      if(response.statusCode == 200)
      {

        var res = await json.decode(response.body);

        EasyLoading.showToast("${res['message']}",
            dismissOnTap: true,
            duration: const Duration(seconds: 1),
            toastPosition: EasyLoadingToastPosition.center);
        Get.back();

      }
      else
      {
        var res = await json.decode(response.body);

        EasyLoading.showToast("${res['message']}",
            dismissOnTap: true,
            duration: const Duration(seconds: 1),
            toastPosition: EasyLoadingToastPosition.center);
      }}catch(e){
      print("Request error: $e");

    }
  }

  Future<AboutUsResponse> getAboutUsResponse() async {

    final response = await http.get(Uri.parse("${ApiUrls.aboutUsApiUrl}"), headers: {'token': '${Prefs.checkAuthToken}',});
    var res = await json.decode(response.body);

    if(res['message'] == "Token expired."|| res['message'] == 'Your account has been suspended. Please contact admin.'){
      Prefs.setBool('is_logged_in_new', false);
      Prefs.setString('user_id_new', "");
      Prefs.setString('user_email_new', "");
      Prefs.setString('user_auth_token', "");
      Prefs.setString("user_name_new", "");
      Prefs.setString("mobile_no", "");
      Get.offAllNamed(Routes.login);
    }
    Get.back();
    print("Api url ${ApiUrls.aboutUsApiUrl}");
    print("response ${response.body}");

    return aboutUsResponseFromJson(response.body);
  }

  Future<FaqResponse> getFaqResponse(String search) async {

    final response = await http.get(Uri.parse("${ApiUrls.faqApiUrl}?search=$search"), headers: {'token': '${Prefs.checkAuthToken}',});
    var res = await json.decode(response.body);

    if(res['message'] == "Token expired."|| res['message'] == 'Your account has been suspended. Please contact admin.'){
      Prefs.setBool('is_logged_in_new', false);
      Prefs.setString('user_id_new', "");
      Prefs.setString('user_email_new', "");
      Prefs.setString('user_auth_token', "");
      Prefs.setString("user_name_new", "");
      Prefs.setString("mobile_no", "");
      Get.offAllNamed(Routes.login);
    }
    Get.back();
    print("Api url ${ApiUrls.faqApiUrl}?search=$search");
    print("response ${response.body}");

    return faqResponseFromJson(response.body);
  }

  Future<FriendListResponse> getFriendListResponse() async {

    final response = await http.get(Uri.parse("${ApiUrls.friendListApiUrl}/${Prefs.checkUserId}"), headers: {'token': '${Prefs.checkAuthToken}',});
    var res = await json.decode(response.body);

    if(res['message'] == "Token expired."|| res['message'] == 'Your account has been suspended. Please contact admin.'){
      Prefs.setBool('is_logged_in_new', false);
      Prefs.setString('user_id_new', "");
      Prefs.setString('user_email_new', "");
      Prefs.setString('user_auth_token', "");
      Prefs.setString("user_name_new", "");
      Prefs.setString("mobile_no", "");
      Get.offAllNamed(Routes.login);
    }
     Get.back();
    print("Api url ${ApiUrls.friendListApiUrl}/${Prefs.checkUserId}");
    print("response ${response.body}");

    return friendListResponseFromJson(response.body);
  }

  Future<GuestListResponse> getGuestListResponse(String search) async {

    final response = await http.get(Uri.parse("${ApiUrls.guestListApiUrl}?search=$search"), headers: {'token': '${Prefs.checkAuthToken}',});
    var res = await json.decode(response.body);

    if(res['message'] == "Token expired."|| res['message'] == 'Your account has been suspended. Please contact admin.'){
      Prefs.setBool('is_logged_in_new', false);
      Prefs.setString('user_id_new', "");
      Prefs.setString('user_email_new', "");
      Prefs.setString('user_auth_token', "");
      Prefs.setString("user_name_new", "");
      Prefs.setString("mobile_no", "");
      Get.offAllNamed(Routes.login);
    }
    Get.back();
    print("Api url ${ApiUrls.guestListApiUrl}");
    print("response ${response.body}");

    return guestListResponseFromJson(response.body);
  }

  Future<SessionSurveysResponse> getSessionSurveysResponse() async {

    final response = await http.get(Uri.parse("${ApiUrls.sessionSurveysApiUrl}"), headers: {'token': '${Prefs.checkAuthToken}',});
    var res = await json.decode(response.body);

    if(res['message'] == "Token expired."|| res['message'] == 'Your account has been suspended. Please contact admin.'){
      Prefs.setBool('is_logged_in_new', false);
      Prefs.setString('user_id_new', "");
      Prefs.setString('user_email_new', "");
      Prefs.setString('user_auth_token', "");
      Prefs.setString("user_name_new", "");
      Prefs.setString("mobile_no", "");
      Get.offAllNamed(Routes.login);
    }
    Get.back();
    print("Api url ${ApiUrls.sessionSurveysApiUrl}");
    print("response ${response.body}");

    return sessionSurveysResponseFromJson(response.body);
  }

  Future<GlobalSurveyResponse> getGlobalSurveysResponse(String type) async {

    final response = await http.get(Uri.parse("${ApiUrls.globalSurveyApiUrl}?type=$type"), headers: {'token': '${Prefs.checkAuthToken}',});
    var res = await json.decode(response.body);

    if(res['message'] == "Token expired."|| res['message'] == 'Your account has been suspended. Please contact admin.'){
      Prefs.setBool('is_logged_in_new', false);
      Prefs.setString('user_id_new', "");
      Prefs.setString('user_email_new', "");
      Prefs.setString('user_auth_token', "");
      Prefs.setString("user_name_new", "");
      Prefs.setString("mobile_no", "");
      Get.offAllNamed(Routes.login);
    }
    Get.back();
    print("Api url ${ApiUrls.globalSurveyApiUrl}?type=$type");
    print("response ${response.body}");

    return globalSurveyResponseFromJson(response.body);
  }

  surveyStatus(var params) async {
      final response = await http.post(Uri.parse("${ApiUrls.surveyStatusApiUrl}"),
          body: params,headers: {'token': '${Prefs.checkAuthToken}',}
      );

      Get.back();

      print("params ${params}");
      print("Api url ${ApiUrls.surveyStatusApiUrl}");
      print("response ${response.body}");


      var res = await json.decode(response.body);
      return res["success"];
  }

  addSurvey(Map<String, dynamic> params) async {
    final response = await http.post(Uri.parse("${ApiUrls.addSurveyApiUrl}"),
        body: json.encode(params),headers: {
          'Content-Type': 'application/json',
          'token': '${Prefs.checkAuthToken}',}
    );

    Get.back();

    print("params ${params}");
    print("Api url ${ApiUrls.addSurveyApiUrl}");
    print("response ${response.body}");

    var res = await json.decode(response.body);

    if(response.statusCode == 200)
    {


      EasyLoading.showToast("${res['message']}",
          dismissOnTap: true,
          duration: const Duration(seconds: 1),
          toastPosition: EasyLoadingToastPosition.center);
      Get.toNamed(Routes.thankYou,arguments: {
      'surveyStatus':false
      });

    }
    else
    {

      EasyLoading.showToast("${res['message']}",
          dismissOnTap: true,
          duration: const Duration(seconds: 1),
          toastPosition: EasyLoadingToastPosition.center);
    }
  }

  sendRequest(var params,String receiverId) async {
    try{
    final response = await http.post(Uri.parse("${ApiUrls.sendRequestApiUrl}"),
      body: params,headers: {'token': '${Prefs.checkAuthToken}',}
    );

    Get.back();

    print("params ${params}");
    print("Api url ${ApiUrls.sendRequestApiUrl}");
    print("response ${response.body}");


    if(response.statusCode == 200)
    {

      var res = await json.decode(response.body);

      EasyLoading.showToast("${res['message']}",
          dismissOnTap: true,
          duration: const Duration(seconds: 1),
          toastPosition: EasyLoadingToastPosition.center);
      print("receiverId $receiverId");
      sendNotification(receiverId);

    }
    else
    {
      var res = await json.decode(response.body);

      EasyLoading.showToast("${res['message']}",
          dismissOnTap: true,
          duration: const Duration(seconds: 1),
          toastPosition: EasyLoadingToastPosition.center);
    }}catch(e){
      print("Request error: $e");

    }
  }

  Future<SentRequestsResponse> sendRequestsResponse() async {

    final response = await http.get(Uri.parse("${ApiUrls.sentRequestsApiUrl}/${Prefs.checkUserId}"), headers: {
      'token': '${Prefs.checkAuthToken}',});
    var res = await json.decode(response.body);

    if(res['message'] == "Token expired."|| res['message'] == 'Your account has been suspended. Please contact admin.'){
      Prefs.setBool('is_logged_in_new', false);
      Prefs.setString('user_id_new', "");
      Prefs.setString('user_email_new', "");
      Prefs.setString('user_auth_token', "");
      Prefs.setString("user_name_new", "");
      Prefs.setString("mobile_no", "");
      Get.offAllNamed(Routes.login);
    }
    // Get.back();
    print("Api url ${ApiUrls.sentRequestsApiUrl}/${Prefs.checkUserId}");
    print("response ${response.body}");

    return sentRequestsResponseFromJson(response.body);
  }

  Future<PendingRequestResponse> pendingRequestResponse() async {

    final response = await http.get(Uri.parse("${ApiUrls.pendingRequestsApiUrl}/${Prefs.checkUserId}"), headers: {
      'token': '${Prefs.checkAuthToken}',});
    var res = await json.decode(response.body);

    if(res['message'] == "Token expired."|| res['message'] == 'Your account has been suspended. Please contact admin.'){
      Prefs.setBool('is_logged_in_new', false);
      Prefs.setString('user_id_new', "");
      Prefs.setString('user_email_new', "");
      Prefs.setString('user_auth_token', "");
      Prefs.setString("user_name_new", "");
      Prefs.setString("mobile_no", "");
      Get.offAllNamed(Routes.login);
    }
    Get.back();
    print("Api url ${ApiUrls.pendingRequestsApiUrl}/${Prefs.checkUserId}");
    print("response ${response.body}");

    return pendingRequestResponseFromJson(response.body);
  }

   handleRequest(String id,String status) async {
    final response = await http.post(Uri.parse("${ApiUrls.handleRequestApiUrl}?id=$id&status=$status"),
        headers: {'token': '${Prefs.checkAuthToken}',}
    );

    Get.back();

    print("Api url ${ApiUrls.sendRequestApiUrl}?id=$id&status=$status");
    print("response ${response.body}");


    if(response.statusCode == 200)
    {

      var res = await json.decode(response.body);

      EasyLoading.showToast("${res['message']}",
          dismissOnTap: true,
          duration: const Duration(seconds: 1),
          toastPosition: EasyLoadingToastPosition.center);
    }
    else
    {
      var res = await json.decode(response.body);

      EasyLoading.showToast("${res['message']}",
          dismissOnTap: true,
          duration: const Duration(seconds: 1),
          toastPosition: EasyLoadingToastPosition.center);
    }
  }

  Future<String> getAccessToken() async {
    // Load the service account credentials from the JSON file
    print("SERVICE_ACCOUNT ${dotenv.env['SERVICE_ACCOUNT']}");
    String serviceAccountJson = dotenv.env['SERVICE_ACCOUNT'] ?? '';
    print("a");
    final jsonContent = json.decode(serviceAccountJson);
    print("b");
    // Define the necessary scopes for FCM
    const scopes = ['https://www.googleapis.com/auth/firebase.messaging'];
    print("c");
    // Create the credentials
    final client = await clientViaServiceAccount(ServiceAccountCredentials.fromJson(jsonContent), scopes);
    print("d");
    // Get the access token
    final accessToken = client.credentials.accessToken.data;
    print("e");
    // Don't forget to close the client after use
    client.close();

    return accessToken;
  }

  Future<void> sendNotification(String fcmToken) async {
    String accessToken = await getAccessToken();
    print("f");
    String projectId = "piwot-b559b";
    var response = await http.post(
      Uri.parse('https://fcm.googleapis.com/v1/projects/$projectId/messages:send'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
      body: jsonEncode({
        "message": {
          "topic": fcmToken,
          "notification": {
            "title": "New Friend Request",
            "body": "You have a new friend request!"
          },
          "data": {
            "new_request": "NewRequest"}
        }
      }),
    );
    print("g");

    if(response.statusCode == 200){
      print("h");
      EasyLoading.showToast("Notification Send Successfully",
          dismissOnTap: true,
          duration: const Duration(seconds: 1),
          toastPosition: EasyLoadingToastPosition.center);
    }else{
      print("Notification response ${response.body}");
    }
  }
}

