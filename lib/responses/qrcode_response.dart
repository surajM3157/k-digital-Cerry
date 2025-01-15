import 'dart:convert';

QRCodeResponse qrcodeResponseFromJson(String str) => QRCodeResponse.fromJson(json.decode(str));

class QRCodeResponse {
  bool? status;
  QRCodeData? data;
  String? message;

  QRCodeResponse({this.status, this.data, this.message});

  factory QRCodeResponse.fromJson(Map<String, dynamic> json) {
    return QRCodeResponse(
      status: json['status'],
      data: json['data'] != null ? QRCodeData.fromJson(json['data']) : null,
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class QRCodeData {
  String? id;
  String? firstName;
  String? lastName;
  String? mobileNumber;
  String? otp;
  String? gender;
  String? companyName;
  String? designation;
  String? city;
  String? state;
  String? country;
  bool? alumniOfIit;
  String? iitName;
  int? batch;
  String? stream;
  String? emailId;
  String? guestFmcToken;
  String? countryCode;
  String? guestType;
  bool? status;
  String? attendanceStatus;
  String? inTime;
  String? deletedAt;
  String? registrationDate;
  String? createdAt;
  String? updatedAt;

  QRCodeData({
    this.id,
    this.firstName,
    this.lastName,
    this.mobileNumber,
    this.otp,
    this.gender,
    this.companyName,
    this.designation,
    this.city,
    this.state,
    this.country,
    this.alumniOfIit,
    this.iitName,
    this.batch,
    this.stream,
    this.emailId,
    this.guestFmcToken,
    this.countryCode,
    this.guestType,
    this.status,
    this.attendanceStatus,
    this.inTime,
    this.deletedAt,
    this.registrationDate,
    this.createdAt,
    this.updatedAt,
  });

  factory QRCodeData.fromJson(Map<String, dynamic> json) {
    return QRCodeData(
      id: json['_id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      mobileNumber: json['mobile_number'].toString(),
      otp: json['otp'],
      gender: json['gender'],
      companyName: json['company_name'],
      designation: json['designation'],
      city: json['city'],
      state: json['state'],
      country: json['country'],
      alumniOfIit: json['alumni_of_iit'],
      iitName: json['iit_name'],
      batch: json['batch'],
      stream: json['stream'],
      emailId: json['email_id'],
      guestFmcToken: json['guest_fmc_token'],
      countryCode: json['country_code'],
      guestType: json['guest_type'],
      status: json['status'],
      attendanceStatus: json['attendance_status'],
      inTime: json['in_time'],
      deletedAt: json['deleted_at'],
      registrationDate: json['registration_date'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['_id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['mobile_number'] = this.mobileNumber;
    data['otp'] = this.otp;
    data['gender'] = this.gender;
    data['company_name'] = this.companyName;
    data['designation'] = this.designation;
    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
    data['alumni_of_iit'] = this.alumniOfIit;
    data['iit_name'] = this.iitName;
    data['batch'] = this.batch;
    data['stream'] = this.stream;
    data['email_id'] = this.emailId;
    data['guest_fmc_token'] = this.guestFmcToken;
    data['country_code'] = this.countryCode;
    data['guest_type'] = this.guestType;
    data['status'] = this.status;
    data['attendance_status'] = this.attendanceStatus;
    data['in_time'] = this.inTime;
    data['deleted_at'] = this.deletedAt;
    data['registration_date'] = this.registrationDate;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
