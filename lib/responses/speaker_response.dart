import 'dart:convert';

SpeakerResponse speakerResponseFromJson(String str) => SpeakerResponse.fromJson(json.decode(str));


class SpeakerResponse {
  int? statusCode;
  bool? success;
  String? message;
  List<SpeakerData>? data;

  SpeakerResponse({this.statusCode, this.success, this.message, this.data});

  SpeakerResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <SpeakerData>[];
      json['data'].forEach((v) {
        data!.add(new SpeakerData.fromJson(v));
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

class SpeakerData {
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

  SpeakerData(
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

  SpeakerData.fromJson(Map<String, dynamic> json) {
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