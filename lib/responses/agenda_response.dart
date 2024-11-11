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
        data!.add(AgendaData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AgendaData {
  String? sId;
  String? agendaDate;
  List<Agendas>? agendas;
  bool? status;
  RoomId? roomId;
  String? insertedBy;
  String? updatedBy;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;
  int? iV;

  AgendaData(
      {this.sId,
        this.agendaDate,
        this.agendas,
        this.status,
        this.roomId,
        this.insertedBy,
        this.updatedBy,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
        this.iV});

  AgendaData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    agendaDate = json['agenda_date'];
    if (json['agendas'] != null) {
      agendas = <Agendas>[];
      json['agendas'].forEach((v) {
        agendas!.add(Agendas.fromJson(v));
      });
    }
    status = json['status'];
    roomId =
    json['room_id'] != null ? RoomId.fromJson(json['room_id']) : null;
    insertedBy = json['inserted_by'];
    updatedBy = json['updated_by'];
    deletedAt = json['deleted_at'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['agenda_date'] = agendaDate;
    if (agendas != null) {
      data['agendas'] = agendas!.map((v) => v.toJson()).toList();
    }
    data['status'] = status;
    if (roomId != null) {
      data['room_id'] = roomId!.toJson();
    }
    data['inserted_by'] = insertedBy;
    data['updated_by'] = updatedBy;
    data['deleted_at'] = deletedAt;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class Agendas {
  String? time;
  String? title;
  List<String>? activities;
  String? sId;

  Agendas({this.time, this.title, this.activities, this.sId});

  Agendas.fromJson(Map<String, dynamic> json) {
    time = json['time'];
    title = json['title'];
    activities = json['activities'].cast<String>();
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['time'] = time;
    data['title'] = title;
    data['activities'] = activities;
    data['_id'] = sId;
    return data;
  }
}

class RoomId {
  String? sId;
  String? roomNo;
  bool? status;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;
  int? iV;

  RoomId(
      {this.sId,
        this.roomNo,
        this.status,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
        this.iV});

  RoomId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    roomNo = json['room_no'];
    status = json['status'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['room_no'] = roomNo;
    data['status'] = status;
    data['deleted_at'] = deletedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}
