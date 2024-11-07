
import 'dart:convert';

SentRequestsResponse sentRequestsResponseFromJson(String str) => SentRequestsResponse.fromJson(json.decode(str));


class SentRequestsResponse {
  int? statusCode;
  bool? success;
  String? message;
  List<SentRequestsData>? data;

  SentRequestsResponse(
      {this.statusCode, this.success, this.message, this.data});

  SentRequestsResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <SentRequestsData>[];
      json['data'].forEach((v) {
        data!.add(new SentRequestsData.fromJson(v));
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

class SentRequestsData {
  String? sId;
  String? status;
  List<RequestSentUserDetails>? requestSentUserDetails;

  SentRequestsData({this.sId, this.status, this.requestSentUserDetails});

  SentRequestsData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    status = json['status'];
    if (json['request_sent_user_details'] != null) {
      requestSentUserDetails = <RequestSentUserDetails>[];
      json['request_sent_user_details'].forEach((v) {
        requestSentUserDetails!.add(new RequestSentUserDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['status'] = this.status;
    if (this.requestSentUserDetails != null) {
      data['request_sent_user_details'] =
          this.requestSentUserDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RequestSentUserDetails {
  String? sId;
  String? firstName;
  String? guestProfileImage;
  String? lastName;
  int? mobileNumber;
  String? emailId;

  RequestSentUserDetails(
      {this.sId,
        this.firstName,
        this.guestProfileImage,
        this.lastName,
        this.mobileNumber,
        this.emailId});

  RequestSentUserDetails.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    firstName = json['first_name'];
    guestProfileImage = json['guest_profile_image'];
    lastName = json['last_name'];
    mobileNumber = json['mobile_number'];
    emailId = json['email_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['first_name'] = this.firstName;
    data['guest_profile_image'] = this.guestProfileImage;
    data['last_name'] = this.lastName;
    data['mobile_number'] = this.mobileNumber;
    data['email_id'] = this.emailId;
    return data;
  }
}
