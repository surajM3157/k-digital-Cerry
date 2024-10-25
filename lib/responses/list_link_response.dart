
import 'dart:convert';

ListLinkResponse listLinkResponseFromJson(String str) => ListLinkResponse.fromJson(json.decode(str));


class ListLinkResponse {
  int? statusCode;
  bool? success;
  String? message;
  List<ListLinkData>? data;

  ListLinkResponse({this.statusCode, this.success, this.message, this.data});

  ListLinkResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ListLinkData>[];
      json['data'].forEach((v) {
        data!.add(new ListLinkData.fromJson(v));
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

class ListLinkData {
  String? sId;
  String? privacyPolicyLink;
  String? termsAndConditionsLink;
  String? instagramLink;
  String? linkedinLink;
  String? youtubeLink;
  String? twitterLink;
  String? facebookLink;
  bool? status;
  String? insertedBy;
  String? updatedBy;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;
  int? iV;

  ListLinkData(
      {this.sId,
        this.privacyPolicyLink,
        this.termsAndConditionsLink,
        this.instagramLink,
        this.linkedinLink,
        this.youtubeLink,
        this.twitterLink,
        this.facebookLink,
        this.status,
        this.insertedBy,
        this.updatedBy,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
        this.iV});

  ListLinkData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    privacyPolicyLink = json['privacy_policy_link'];
    termsAndConditionsLink = json['terms_and_conditions_link'];
    instagramLink = json['instagram_link'];
    linkedinLink = json['linkedin_link'];
    youtubeLink = json['youtube_link'];
    twitterLink = json['twitter_link'];
    facebookLink = json['facebook_link'];
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
    data['privacy_policy_link'] = this.privacyPolicyLink;
    data['terms_and_conditions_link'] = this.termsAndConditionsLink;
    data['instagram_link'] = this.instagramLink;
    data['linkedin_link'] = this.linkedinLink;
    data['youtube_link'] = this.youtubeLink;
    data['twitter_link'] = this.twitterLink;
    data['facebook_link'] = this.facebookLink;
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
