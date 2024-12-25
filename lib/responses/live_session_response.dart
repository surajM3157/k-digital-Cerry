import 'dart:convert';

LiveSessionResponse liveSessionResponseFromJson(String str) =>
    LiveSessionResponse.fromJson(json.decode(str));

class LiveSessionResponse {
  int? statusCode;
  bool? success;
  String? message;
  List<LiveSessionData>? data;

  LiveSessionResponse({this.statusCode, this.success, this.message, this.data});

  LiveSessionResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <LiveSessionData>[];
      json['data'].forEach((v) {
        data!.add(new LiveSessionData.fromJson(v));
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

class LiveSessionData {
  String? sId;
  String? link;
  String? description;
  String? title;
  String? eventDate;
  bool? status;
  String? insertedBy;
  String? updatedBy;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;
  int? iV;

  LiveSessionData(
      {this.sId,
      this.link,
      this.description,
      this.title,
      this.eventDate,
      this.status,
      this.insertedBy,
      this.updatedBy,
      this.deletedAt,
      this.createdAt,
      this.updatedAt,
      this.iV});

  LiveSessionData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    link = json['link'];
    description = json['description'];
    title = json['title'];
    title = json['title'];
    eventDate = json['event_date'];
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
    data['link'] = this.link;
    data['description'] = this.description;
    data['title'] = this.title;
    data['event_date'] = this.eventDate;
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
