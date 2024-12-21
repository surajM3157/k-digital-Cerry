import 'dart:convert';

FloorPlanResponse floorPlanResponseFromJson(String str) => FloorPlanResponse.fromJson(json.decode(str));


class FloorPlanResponse {
  int? statusCode;
  bool? success;
  String? message;
  List<FloorPlanData>? data;

  FloorPlanResponse({this.statusCode, this.success, this.message, this.data});

  FloorPlanResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <FloorPlanData>[];
      json['data'].forEach((v) {
        data!.add(new FloorPlanData.fromJson(v));
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

class FloorPlanData {
  String? sId;
  String? floorName;
  List<String>? floorPlanImage; // List of images
  bool? status;
  String? insertedBy;
  String? updatedBy;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;
  int? iV;

  FloorPlanData({
    this.sId,
    this.floorName,
    this.floorPlanImage,
    this.status,
    this.insertedBy,
    this.updatedBy,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  FloorPlanData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    floorName = json['floor_name'];
    if (json['floor_plan_image'] != null) {
      floorPlanImage = List<String>.from(json['floor_plan_image']);
    }
    status = json['status'];
    insertedBy = json['inserted_by'];
    updatedBy = json['updated_by'];
    deletedAt = json['deleted_at'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['_id'] = this.sId;
    data['floor_name'] = this.floorName;
    data['floor_plan_image'] = this.floorPlanImage;
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