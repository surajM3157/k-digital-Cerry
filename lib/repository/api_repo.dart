import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:http_parser/http_parser.dart';


class ApiRepo
{


  // loginResponse(var params, BuildContext context) async {
  //   final response = await http.post(Uri.parse("${ApiUrls.loginApiUrl}"),
  //     body: params,
  //   );
  //
  //   Navigator.pop(context);
  //
  //   print("params ${params}");
  //   print("Api url ${ApiUrls.loginApiUrl}");
  //   print("response ${response.body}");
  //
  //
  //   if(response.statusCode == 200)
  //   {
  //     var mobel = loginResponseFromJson(response.body);
  //
  //     replaceRoute(context, HomeScreen(mobel.data?.reset_password_status??""));
  //     Prefs.setBool('is_logged_in_new', true);
  //     Prefs.setString('user_id_new', "${mobel.data?.id ?? ""}");
  //     Prefs.setString('user_email_new', "${mobel.data?.email ?? ""}");
  //     Prefs.setString('user_auth_token', "${mobel.data?.accessToken ?? ""}");
  //     Prefs.setString("user_name_new", "${mobel.data?.firstName ?? ""} ${mobel.data?.lastName ?? ""}");
  //     Prefs.loadData();
  //     Prefs.load();
  //
  //   }
  //   else
  //   {
  //     var res = await json.decode(response.body);
  //
  //     EasyLoading.showToast("${res['responseMessage']}",
  //         dismissOnTap: true,
  //         duration: const Duration(seconds: 1),
  //         toastPosition: EasyLoadingToastPosition.center);
  //   }
  // }


}

