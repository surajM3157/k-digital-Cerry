
import 'dart:convert';

import 'package:flutter/cupertino.dart';

SessionSurveysResponse sessionSurveysResponseFromJson(String str) => SessionSurveysResponse.fromJson(json.decode(str));


class SessionSurveysResponse {
  int? statusCode;
  bool? success;
  String? message;
  List<SessionSurveysData>? data;

  SessionSurveysResponse(
      {this.statusCode, this.success, this.message, this.data});

  SessionSurveysResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <SessionSurveysData>[];
      json['data'].forEach((v) {
        data!.add(new SessionSurveysData.fromJson(v));
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

class SessionSurveysData {
  String? sId;
  String? surveyName;
  String? eventName;
  String? roomId;
  String? sessionId;
  List<String>? questions;
  bool? status;
  String? insertedBy;
  String? updatedBy;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;
  int? iV;
  RoomDetails? roomDetails;
  SessionDetails? sessionDetails;
  List<QuestionsDetails>? questionsDetails;
  bool? isGlobal;


  SessionSurveysData(
      {this.sId,
        this.surveyName,
        this.eventName,
        this.roomId,
        this.sessionId,
        this.questions,
        this.status,
        this.insertedBy,
        this.updatedBy,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
        this.iV,
        this.roomDetails,
        this.sessionDetails,
        this.questionsDetails,this.isGlobal});

  SessionSurveysData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    surveyName = json['survey_name'];
    eventName = json['event_name'];
    roomId = json['room_id'];
    sessionId = json['session_id'];
    questions = json['questions'].cast<String>();
    status = json['status'];
    insertedBy = json['inserted_by'];
    updatedBy = json['updated_by'];
    deletedAt = json['deleted_at'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    isGlobal = json['is_global'];
    roomDetails = json['roomDetails'] != null
        ? new RoomDetails.fromJson(json['roomDetails'])
        : null;
    sessionDetails = json['sessionDetails'] != null
        ? new SessionDetails.fromJson(json['sessionDetails'])
        : null;
    if (json['questionsDetails'] != null) {
      questionsDetails = <QuestionsDetails>[];
      json['questionsDetails'].forEach((v) {
        questionsDetails!.add(new QuestionsDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['survey_name'] = this.surveyName;
    data['event_name'] = this.eventName;
    data['room_id'] = this.roomId;
    data['session_id'] = this.sessionId;
    data['questions'] = this.questions;
    data['status'] = this.status;
    data['inserted_by'] = this.insertedBy;
    data['updated_by'] = this.updatedBy;
    data['deleted_at'] = this.deletedAt;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['is_global'] = this.isGlobal;
    data['__v'] = this.iV;
    if (this.roomDetails != null) {
      data['roomDetails'] = this.roomDetails!.toJson();
    }
    if (this.sessionDetails != null) {
      data['sessionDetails'] = this.sessionDetails!.toJson();
    }
    if (this.questionsDetails != null) {
      data['questionsDetails'] =
          this.questionsDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RoomDetails {
  String? sId;
  String? roomNo;
  bool? status;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;
  int? iV;

  RoomDetails(
      {this.sId,
        this.roomNo,
        this.status,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
        this.iV});

  RoomDetails.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    roomNo = json['room_no'];
    status = json['status'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['room_no'] = this.roomNo;
    data['status'] = this.status;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class SessionDetails {
  String? sId;
  String? sessionImage;
  String? sessionName;
  String? sessionDescription;
  String? roomId;
  List<String>? speaker;
  String? category;
  String? time;
  String? date;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;
  int? iV;

  SessionDetails(
      {this.sId,
        this.sessionImage,
        this.sessionName,
        this.sessionDescription,
        this.roomId,
        this.speaker,
        this.category,
        this.time,
        this.date,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
        this.iV});

  SessionDetails.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    sessionImage = json['session_image'];
    sessionName = json['session_name'];
    sessionDescription = json['session_description'];
    roomId = json['room_id'];
    speaker = json['speaker'].cast<String>();
    category = json['category'];
    time = json['time'];
    date = json['date'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['session_image'] = this.sessionImage;
    data['session_name'] = this.sessionName;
    data['session_description'] = this.sessionDescription;
    data['room_id'] = this.roomId;
    data['speaker'] = this.speaker;
    data['category'] = this.category;
    data['time'] = this.time;
    data['date'] = this.date;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class QuestionsDetails {
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

  QuestionsDetails(
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

  QuestionsDetails.fromJson(Map<String, dynamic> json) {
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
