
import 'dart:convert';

SponsorResponse sponsorResponseFromJson(String str) => SponsorResponse.fromJson(json.decode(str));


class SponsorResponse {
  int? statusCode;
  bool? success;
  String? message;
  List<SponsorData>? data;

  SponsorResponse({this.statusCode, this.success, this.message, this.data});

  SponsorResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <SponsorData>[];
      json['data'].forEach((v) {
        data!.add(new SponsorData.fromJson(v));
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

class SponsorData {
  String? sId;
  String? sponsorName;
  String? sponsorImage;
  bool? status;
  String? insertedBy;
  String? updatedBy;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;
  int? iV;

  SponsorData(
      {this.sId,
        this.sponsorName,
        this.sponsorImage,
        this.status,
        this.insertedBy,
        this.updatedBy,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
        this.iV});

  SponsorData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    sponsorName = json['sponsor_name'];
    sponsorImage = json['sponsor_image'];
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
    data['sponsor_name'] = this.sponsorName;
    data['sponsor_image'] = this.sponsorImage;
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