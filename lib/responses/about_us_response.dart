import 'dart:convert';

AboutUsResponse aboutUsResponseFromJson(String str) => AboutUsResponse.fromJson(json.decode(str));


class AboutUsResponse {
  int? statusCode;
  bool? success;
  String? message;
  List<AboutUsData>? data;

  AboutUsResponse({this.statusCode, this.success, this.message, this.data});

  AboutUsResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <AboutUsData>[];
      json['data'].forEach((v) {
        data!.add(new AboutUsData.fromJson(v));
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

class AboutUsData {
  String? sId;
  String? aboutEvent;
  String? aboutPanIit;
  String? logo;
  List<OfficialBearers>? officialBearers;
  List<OrganisingTeam>? organisingTeam;
  String? insertedBy;
  String? updatedBy;
  String? deletedAt;
  bool? status;
  String? createdAt;
  String? updatedAt;
  int? iV;

  AboutUsData(
      {this.sId,
        this.aboutEvent,
        this.aboutPanIit,
        this.logo,
        this.officialBearers,
        this.organisingTeam,
        this.insertedBy,
        this.updatedBy,
        this.deletedAt,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.iV});

  AboutUsData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    aboutEvent = json['about_event'];
    aboutPanIit = json['about_pan_iit'];
    logo = json['logo'];
    if (json['official_bearers'] != null) {
      officialBearers = <OfficialBearers>[];
      json['official_bearers'].forEach((v) {
        officialBearers!.add(new OfficialBearers.fromJson(v));
      });
    }
    if (json['organising_team'] != null) {
      organisingTeam = <OrganisingTeam>[];
      json['organising_team'].forEach((v) {
        organisingTeam!.add(new OrganisingTeam.fromJson(v));
      });
    }
    insertedBy = json['inserted_by'];
    updatedBy = json['updated_by'];
    deletedAt = json['deleted_at'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['about_event'] = this.aboutEvent;
    data['about_pan_iit'] = this.aboutPanIit;
    data['logo'] = this.logo;
    if (this.officialBearers != null) {
      data['official_bearers'] =
          this.officialBearers!.map((v) => v.toJson()).toList();
    }
    if (this.organisingTeam != null) {
      data['organising_team'] =
          this.organisingTeam!.map((v) => v.toJson()).toList();
    }
    data['inserted_by'] = this.insertedBy;
    data['updated_by'] = this.updatedBy;
    data['deleted_at'] = this.deletedAt;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class OfficialBearers {
  String? bearerImage;
  String? bearerName;
  String? designation;
  String? sId;

  OfficialBearers(
      {this.bearerImage, this.bearerName, this.designation, this.sId});

  OfficialBearers.fromJson(Map<String, dynamic> json) {
    bearerImage = json['bearer_image'];
    bearerName = json['bearer_name'];
    designation = json['designation'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bearer_image'] = this.bearerImage;
    data['bearer_name'] = this.bearerName;
    data['designation'] = this.designation;
    data['_id'] = this.sId;
    return data;
  }
}

class OrganisingTeam {
  String? organiserImage;
  String? organiserName;
  String? designation;
  String? sId;

  OrganisingTeam(
      {this.organiserImage, this.organiserName, this.designation, this.sId});

  OrganisingTeam.fromJson(Map<String, dynamic> json) {
    organiserImage = json['organiser_image'];
    organiserName = json['organiser_name'];
    designation = json['designation'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['organiser_image'] = this.organiserImage;
    data['organiser_name'] = this.organiserName;
    data['designation'] = this.designation;
    data['_id'] = this.sId;
    return data;
  }
}
