import 'dart:convert';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:piwotapp/responses/agenda_response.dart';
import 'package:piwotapp/responses/banner_response.dart';
import 'package:piwotapp/responses/otp_response.dart';
import 'package:piwotapp/responses/partner_response.dart';
import 'package:piwotapp/responses/speaker_response.dart';
import 'package:piwotapp/responses/sponsor_response.dart';

import '../constants/api_urls.dart';
import '../route/route_names.dart';
import '../shared prefs/pref_manager.dart';


class ApiRepo
{


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

      var model = otpResponseFromJson(response.body);

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
      Get.offAllNamed(Routes.home);

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

  Future<SpeakerResponse> getSpeakerResponse() async {

    final response = await http.get(Uri.parse("${ApiUrls.speakerApiUrl}"), headers: {'token': '${Prefs.checkAuthToken}',});

    Get.back();
    print("Api url ${ApiUrls.speakerApiUrl}");
    print("response ${response.body}");

    return speakerResponseFromJson(response.body);
  }

  Future<SponsorResponse> getSponsorResponse() async {

    final response = await http.get(Uri.parse("${ApiUrls.sponsorApiUrl}"), headers: {'token': '${Prefs.checkAuthToken}',});

    Get.back();
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

  Future<AgendaResponse> getAgendaResponse() async {

    final response = await http.get(Uri.parse("${ApiUrls.agendaApiUrl}"), headers: {'token': '${Prefs.checkAuthToken}',});

    Get.back();
    print("Api url ${ApiUrls.agendaApiUrl}");
    print("response ${response.body}");

    return agendaResponseFromJson(response.body);
  }





}

