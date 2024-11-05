import 'dart:convert';

import 'package:flutter/cupertino.dart';

GlobalSurveyResponse globalSurveyResponseFromJson(String str) => GlobalSurveyResponse.fromJson(json.decode(str));


class GlobalSurveyResponse {
  int? statusCode;
  bool? success;
  String? message;
  List<GlobalSurveyData>? data;

  GlobalSurveyResponse(
      {this.statusCode, this.success, this.message, this.data});

  GlobalSurveyResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <GlobalSurveyData>[];
      json['data'].forEach((v) {
        data!.add(new GlobalSurveyData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GlobalSurveyData {
  String? sId;
  String? surveyName;
  String? eventName;
  String? roomId;
  String? sessionId;
  List<Questions>? questions;
  bool? status;
  bool? isGlobal;
  String? insertedBy;
  String? updatedBy;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;
  int? iV;

  GlobalSurveyData(
      {this.sId,
        this.surveyName,
        this.eventName,
        this.roomId,
        this.sessionId,
        this.questions,
        this.status,
        this.isGlobal,
        this.insertedBy,
        this.updatedBy,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
        this.iV});

  GlobalSurveyData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    surveyName = json['survey_name'];
    eventName = json['event_name'];
    roomId = json['room_id'];
    sessionId = json['session_id'];
    if (json['questions'] != null) {
      questions = <Questions>[];
      json['questions'].forEach((v) {
        questions!.add(new Questions.fromJson(v));
      });
    }
    status = json['status'];
    isGlobal = json['is_global'];
    insertedBy = json['inserted_by'];
    updatedBy = json['updated_by'];
    deletedAt = json['deleted_at'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['survey_name'] = this.surveyName;
    data['event_name'] = this.eventName;
    data['room_id'] = this.roomId;
    data['session_id'] = this.sessionId;
    if (this.questions != null) {
      data['questions'] = this.questions!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    data['is_global'] = this.isGlobal;
    data['inserted_by'] = this.insertedBy;
    data['updated_by'] = this.updatedBy;
    data['deleted_at'] = this.deletedAt;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class Questions {
  String? sId;
  String? question;
  String? typeOf;
  List<String>? options;
  bool? status;
  String? insertedBy;
  String? updatedBy;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? selectedRadioOption;
  int selectedStarOption = 0;
  String multiLineAnswer = "";
  var multiLineController = TextEditingController();
  List<bool> selectedCheckboxOptions = [];

  Questions(
      {this.sId,
        this.question,
        this.typeOf,
        this.options,
        this.status,
        this.insertedBy,
        this.updatedBy,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
        this.iV});

  Questions.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    question = json['question'];
    typeOf = json['typeOf'];
    options = json['options'].cast<String>();
    status = json['status'];
    insertedBy = json['inserted_by'];
    updatedBy = json['updated_by'];
    deletedAt = json['deleted_at'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['question'] = this.question;
    data['typeOf'] = this.typeOf;
    data['options'] = this.options;
    data['status'] = this.status;
    data['inserted_by'] = this.insertedBy;
    data['updated_by'] = this.updatedBy;
    data['deleted_at'] = this.deletedAt;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
