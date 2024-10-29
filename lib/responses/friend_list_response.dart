import 'dart:convert';

FriendListResponse friendListResponseFromJson(String str) => FriendListResponse.fromJson(json.decode(str));


class FriendListResponse {
  int? statusCode;
  bool? success;
  String? message;
  List<FriendListData>? data;

  FriendListResponse({this.statusCode, this.success, this.message, this.data});

  FriendListResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <FriendListData>[];
      json['data'].forEach((v) {
        data!.add(new FriendListData.fromJson(v));
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

class FriendListData {
  String? sId;
  String? guestId;
  List<String>? friends;
  String? updatedAt;
  List<AllFriends>? allFriends;

  FriendListData({this.sId, this.guestId, this.friends, this.updatedAt, this.allFriends});

  FriendListData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    guestId = json['guest_id'];
    friends = json['friends'].cast<String>();
    updatedAt = json['updatedAt'];
    if (json['allFriends'] != null) {
      allFriends = <AllFriends>[];
      json['allFriends'].forEach((v) {
        allFriends!.add(new AllFriends.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['guest_id'] = this.guestId;
    data['friends'] = this.friends;
    data['updatedAt'] = this.updatedAt;
    if (this.allFriends != null) {
      data['allFriends'] = this.allFriends!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AllFriends {
  String? sId;
  String? firstName;
  String? guestProfileImage;
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
  bool? alreadyLoggedIn;
  String? attendanceStatus;
  String? inTime;
  String? deletedAt;
  String? registrationDate;
  String? createdAt;
  String? updatedAt;
  int? iV;

  AllFriends(
      {this.sId,
        this.firstName,
        this.guestProfileImage,
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
        this.alreadyLoggedIn,
        this.attendanceStatus,
        this.inTime,
        this.deletedAt,
        this.registrationDate,
        this.createdAt,
        this.updatedAt,
        this.iV});

  AllFriends.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    firstName = json['first_name'];
    guestProfileImage = json['guest_profile_image'];
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
    alreadyLoggedIn = json['already_logged_in'];
    attendanceStatus = json['attendance_status'];
    inTime = json['in_time'];
    deletedAt = json['deleted_at'];
    registrationDate = json['registration_date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['first_name'] = this.firstName;
    data['guest_profile_image'] = this.guestProfileImage;
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
    data['already_logged_in'] = this.alreadyLoggedIn;
    data['attendance_status'] = this.attendanceStatus;
    data['in_time'] = this.inTime;
    data['deleted_at'] = this.deletedAt;
    data['registration_date'] = this.registrationDate;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

