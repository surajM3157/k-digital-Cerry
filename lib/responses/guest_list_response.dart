
import 'dart:convert';

GuestListResponse guestListResponseFromJson(String str) => GuestListResponse.fromJson(json.decode(str));


class GuestListResponse {
  int? statusCode;
  bool? success;
  String? message;
  List<GuestListData>? data;

  GuestListResponse({this.statusCode, this.success, this.message, this.data});

  GuestListResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <GuestListData>[];
      json['data'].forEach((v) {
        data!.add(new GuestListData.fromJson(v));
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

class GuestListData {
  String? sId;
  String? firstName;
  int? guestId;
  String? lastName;
  int? mobileNumber;
  String? otp;
  String? gender;
  String? companyName;
  String? designation;
  String? city;
  String? country;
  bool? alumniOfIit;
  String? iitName;
  int? batch;
  String? stream;
  String? emailId;
  bool? status;
  String? attendanceStatus;
  String? inTime;
  String? deletedAt;
  String? registrationDate;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? category;
  bool? alreadyLoggedIn;
  String? guestProfileImage;

  GuestListData(
      {this.sId,
        this.firstName,
        this.guestId,
        this.lastName,
        this.mobileNumber,
        this.otp,
        this.gender,
        this.companyName,
        this.designation,
        this.city,
        this.country,
        this.alumniOfIit,
        this.iitName,
        this.batch,
        this.stream,
        this.emailId,
        this.status,
        this.attendanceStatus,
        this.inTime,
        this.deletedAt,
        this.registrationDate,
        this.createdAt,
        this.updatedAt,
        this.iV,
        this.category,
        this.alreadyLoggedIn,
        this.guestProfileImage});

  GuestListData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    firstName = json['first_name'];
    guestId = json['guest_id'];
    lastName = json['last_name'];
    mobileNumber = json['mobile_number'];
    otp = json['otp'];
    gender = json['gender'];
    companyName = json['company_name'];
    designation = json['designation'];
    city = json['city'];
    country = json['country'];
    alumniOfIit = json['alumni_of_iit'];
    iitName = json['iit_name'];
    batch = json['batch'];
    stream = json['stream'];
    emailId = json['email_id'];
    status = json['status'];
    attendanceStatus = json['attendance_status'];
    inTime = json['in_time'];
    deletedAt = json['deleted_at'];
    registrationDate = json['registration_date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    iV = json['__v'];
    category = json['category'];
    alreadyLoggedIn = json['already_logged_in'];
    guestProfileImage = json['guest_profile_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['first_name'] = this.firstName;
    data['guest_id'] = this.guestId;
    data['last_name'] = this.lastName;
    data['mobile_number'] = this.mobileNumber;
    data['otp'] = this.otp;
    data['gender'] = this.gender;
    data['company_name'] = this.companyName;
    data['designation'] = this.designation;
    data['city'] = this.city;
    data['country'] = this.country;
    data['alumni_of_iit'] = this.alumniOfIit;
    data['iit_name'] = this.iitName;
    data['batch'] = this.batch;
    data['stream'] = this.stream;
    data['email_id'] = this.emailId;
    data['status'] = this.status;
    data['attendance_status'] = this.attendanceStatus;
    data['in_time'] = this.inTime;
    data['deleted_at'] = this.deletedAt;
    data['registration_date'] = this.registrationDate;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['__v'] = this.iV;
    data['category'] = this.category;
    data['already_logged_in'] = this.alreadyLoggedIn;
    data['guest_profile_image'] = this.guestProfileImage;
    return data;
  }
}
