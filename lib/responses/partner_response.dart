
import 'dart:convert';

PartnerResponse partnerResponseFromJson(String str) => PartnerResponse.fromJson(json.decode(str));


class PartnerResponse {
  int? statusCode;
  bool? success;
  String? message;
  List<PartnerData>? data;

  PartnerResponse({this.statusCode, this.success, this.message, this.data});

  PartnerResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <PartnerData>[];
      json['data'].forEach((v) {
        data!.add(new PartnerData.fromJson(v));
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

class PartnerData {
  String? sId;
  String? partnerName;
  String? partnerImage;
  bool? status;
  String? insertedBy;
  String? updatedBy;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;
  int? iV;

  PartnerData(
      {this.sId,
        this.partnerName,
        this.partnerImage,
        this.status,
        this.insertedBy,
        this.updatedBy,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
        this.iV});

  PartnerData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    partnerName = json['partner_name'];
    partnerImage = json['partner_image'];
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
    data['partner_name'] = this.partnerName;
    data['partner_image'] = this.partnerImage;
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