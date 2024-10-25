
import 'dart:convert';

FaqResponse faqResponseFromJson(String str) => FaqResponse.fromJson(json.decode(str));


class FaqResponse {
  int? statusCode;
  bool? success;
  String? message;
  List<FaqData>? data;

  FaqResponse({this.statusCode, this.success, this.message, this.data});

  FaqResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <FaqData>[];
      json['data'].forEach((v) {
        data!.add(new FaqData.fromJson(v));
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

class FaqData {
  String? sId;
  String? question;
  String? answer;
  bool? status;
  String? insertedBy;
  String? updatedBy;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;
  int? iV;

  FaqData(
      {this.sId,
        this.question,
        this.answer,
        this.status,
        this.insertedBy,
        this.updatedBy,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
        this.iV});

  FaqData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    question = json['question'];
    answer = json['answer'];
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
    data['answer'] = this.answer;
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
