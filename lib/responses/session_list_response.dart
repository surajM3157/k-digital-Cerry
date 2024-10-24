
import 'dart:convert';

SessionListResponse sessionResponseFromJson(String str) => SessionListResponse.fromJson(json.decode(str));


class SessionListResponse {
  int? statusCode;
  bool? success;
  String? message;
  List<SessionListData>? data;

  SessionListResponse({this.statusCode, this.success, this.message, this.data});

  SessionListResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <SessionListData>[];
      json['data'].forEach((v) {
        data!.add(new SessionListData.fromJson(v));
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

class SessionListData {
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
  RoomDetails? roomDetails;
  List<SpeakerDetails>? speakerDetails;

  SessionListData(
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
        this.iV,
        this.roomDetails,
        this.speakerDetails});

  SessionListData.fromJson(Map<String, dynamic> json) {
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
    roomDetails = json['roomDetails'] != null
        ? new RoomDetails.fromJson(json['roomDetails'])
        : null;
    if (json['speakerDetails'] != null) {
      speakerDetails = <SpeakerDetails>[];
      json['speakerDetails'].forEach((v) {
        speakerDetails!.add(new SpeakerDetails.fromJson(v));
      });
    }
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
    if (this.roomDetails != null) {
      data['roomDetails'] = this.roomDetails!.toJson();
    }
    if (this.speakerDetails != null) {
      data['speakerDetails'] =
          this.speakerDetails!.map((v) => v.toJson()).toList();
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

class SpeakerDetails {
  String? sId;
  String? speakerName;
  String? speakerImage;
  String? companyName;
  String? designation;
  String? bio;
  bool? status;
  String? insertedBy;
  String? updatedBy;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;
  int? iV;

  SpeakerDetails(
      {this.sId,
        this.speakerName,
        this.speakerImage,
        this.companyName,
        this.designation,
        this.bio,
        this.status,
        this.insertedBy,
        this.updatedBy,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
        this.iV});

  SpeakerDetails.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    speakerName = json['speaker_name'];
    speakerImage = json['speaker_image'];
    companyName = json['company_name'];
    designation = json['designation'];
    bio = json['bio'];
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
    data['speaker_name'] = this.speakerName;
    data['speaker_image'] = this.speakerImage;
    data['company_name'] = this.companyName;
    data['designation'] = this.designation;
    data['bio'] = this.bio;
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

