import 'dart:convert';

PendingRequestResponse pendingRequestResponseFromJson(String str) => PendingRequestResponse.fromJson(json.decode(str));


class PendingRequestResponse {
  int? statusCode;
  bool? success;
  String? message;
  List<PendingRequestData>? data;

  PendingRequestResponse(
      {this.statusCode, this.success, this.message, this.data});

  PendingRequestResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <PendingRequestData>[];
      json['data'].forEach((v) {
        data!.add(new PendingRequestData.fromJson(v));
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

class PendingRequestData {
  String? sId;
  String? status;
  List<RequestSentUserDetails>? requestSentUserDetails;

  PendingRequestData({this.sId, this.status, this.requestSentUserDetails});

  PendingRequestData.fromJson(Map<String, dynamic> json) {
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
  String? firstName;
  String? lastName;
  int? mobileNumber;
  String? emailId;
  String? guestProfileImage;
  String? designation;
  String? companyName;

  RequestSentUserDetails(
      {this.firstName,
        this.lastName,
        this.mobileNumber,
        this.emailId,
        this.guestProfileImage,
        this.companyName,
        this.designation
      });

  RequestSentUserDetails.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    mobileNumber = json['mobile_number'];
    emailId = json['email_id'];
    guestProfileImage = json['guest_profile_image'];
    companyName = json['company_name'];
    designation = json['designation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['mobile_number'] = this.mobileNumber;
    data['email_id'] = this.emailId;
    data['guest_profile_image'] = this.guestProfileImage;
    data['company_name'] = this.companyName;
    data['designation'] = this.designation;
    return data;
  }
}
