
import 'dart:convert';

AgendaResponse agendaResponseFromJson(String str) => AgendaResponse.fromJson(json.decode(str));


class AgendaResponse {
  int? statusCode;
  bool? success;
  String? message;
  List<AgendaData>? data;

  AgendaResponse({this.statusCode, this.success, this.message, this.data});

  AgendaResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <AgendaData>[];
      json['data'].forEach((v) {
        data!.add(new AgendaData.fromJson(v));
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

class AgendaData {
  String? sId;
  String? agendaDate;
  String? time;
  String? title;
  List<String>? activities;
  bool? status;
  String? insertedBy;
  String? updatedBy;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? roomId;

  AgendaData(
      {this.sId,
        this.agendaDate,
        this.time,
        this.title,
        this.activities,
        this.status,
        this.insertedBy,
        this.updatedBy,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
        this.iV,
        this.roomId});

  AgendaData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    agendaDate = json['agenda_date'];
    time = json['time'];
    title = json['title'];
    activities = json['activities'].cast<String>();
    status = json['status'];
    insertedBy = json['inserted_by'];
    updatedBy = json['updated_by'];
    deletedAt = json['deleted_at'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    roomId = json['room_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['agenda_date'] = this.agendaDate;
    data['time'] = this.time;
    data['title'] = this.title;
    data['activities'] = this.activities;
    data['status'] = this.status;
    data['inserted_by'] = this.insertedBy;
    data['updated_by'] = this.updatedBy;
    data['deleted_at'] = this.deletedAt;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['room_id'] = this.roomId;
    return data;
  }
}


