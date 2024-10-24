import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;
import 'package:piwotapp/responses/agenda_response.dart';
import 'package:piwotapp/responses/banner_response.dart';
import 'package:piwotapp/responses/floor_plan_response.dart';
import 'package:piwotapp/responses/otp_response.dart';
import 'package:piwotapp/responses/partner_response.dart';
import 'package:piwotapp/responses/session_list_response.dart';
import 'package:piwotapp/responses/speaker_response.dart';
import 'package:piwotapp/responses/sponsor_response.dart';
import 'package:http_parser/http_parser.dart';
import '../constants/api_urls.dart';
import '../route/route_names.dart';
import '../shared prefs/pref_manager.dart';


class ApiRepo
{

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;



  loginResponse(var params) async {
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

      EasyLoading.showToast("${res['message']}",
          dismissOnTap: true,
          duration: const Duration(seconds: 1),
          toastPosition: EasyLoadingToastPosition.center);
      Get.toNamed(Routes.otp,arguments: {"data":res['data']});

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

      Prefs.loadData();
      Prefs.load();



      _firestore.collection("users").doc("${model.data?.guestDetails?.sId?? ""}").set(
          {
            "uid":"${model.data?.guestDetails?.sId?? ""}",
            "name":"${model.data?.guestDetails?.firstName ?? ""} ${model.data?.guestDetails?.lastName ?? ""}",
          }, SetOptions(merge: true)
      );
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

    if(isHome){}else
      {
     Get.back();}
    print("Api url ${ApiUrls.speakerApiUrl}?search=$search");
    print("response ${response.body}");

    return speakerResponseFromJson(response.body);
  }

  Future<SponsorResponse> getSponsorResponse(bool isHome) async {

    final response = await http.get(Uri.parse("${ApiUrls.sponsorApiUrl}"), headers: {'token': '${Prefs.checkAuthToken}',});

    if(isHome){}else
    {
      Get.back();}
    print("Api url ${ApiUrls.sponsorApiUrl}");
    print("response ${response.body}");

    return sponsorResponseFromJson(response.body);
  }

  Future<PartnerResponse> getPartnerResponse() async {

    final response = await http.get(Uri.parse("${ApiUrls.partnerApiUrl}"), headers: {'token': '${Prefs.checkAuthToken}',});

    Get.back();
    print("Api url ${ApiUrls.partnerApiUrl}");
    print("response ${response.body}");

    return partnerResponseFromJson(response.body);
  }

  Future<BannerResponse> getBannerResponse() async {

    final response = await http.get(Uri.parse("${ApiUrls.bannerApiUrl}"), headers: {'token': '${Prefs.checkAuthToken}',});

    Get.back();
    print("Api url ${ApiUrls.bannerApiUrl}");
    print("response ${response.body}");

    return bannerResponseFromJson(response.body);
  }

  Future<AgendaResponse> getAgendaResponse(String date) async {

    final response = await http.get(Uri.parse("${ApiUrls.agendaApiUrl}?date=$date"), headers: {'token': '${Prefs.checkAuthToken}',});

    Get.back();
    print("Api url ${ApiUrls.agendaApiUrl}?date=$date");
    print("response ${response.body}");

    return agendaResponseFromJson(response.body);
  }

  Future<SessionListResponse> getSessionListResponse(String date) async {

    final response = await http.get(Uri.parse("${ApiUrls.sessionListApiUrl}?date=$date"), headers: {'token': '${Prefs.checkAuthToken}',});

    Get.back();
    print("Api url ${ApiUrls.sessionListApiUrl}?date=$date");
    print("response ${response.body}");

    return sessionResponseFromJson(response.body);
  }

  Future<FloorPlanResponse> getFloorPlanResponse() async {

    final response = await http.get(Uri.parse("${ApiUrls.floorPlanApiUrl}"), headers: {'token': '${Prefs.checkAuthToken}',});

    Get.back();
    print("Api url ${ApiUrls.floorPlanApiUrl}");
    print("response ${response.body}");

    return floorPlanResponseFromJson(response.body);
  }



  updateProfile(var params, {File? image}) async {

    var uri = Uri.parse("${ApiUrls.updateProfileApiUrl}/${Prefs.checkUserId}");
    var request = http.MultipartRequest('POST', uri);
    request.fields.addAll(params);
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




}

