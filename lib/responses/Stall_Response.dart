class StallListResponse {
  int? statusCode;
  bool? success;
  String? message;
  List<Data>? data;

  StallListResponse({this.statusCode, this.success, this.message, this.data});

  StallListResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
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

class Data {
  String? sId;
  String? stallNo;
  String? stallName;
  String? remarks;  // Updated to String?
  bool? status;
  String? insertedBy;
  String? updatedBy;  // Updated to String?
  String? deletedAt;  // Updated to String?
  int? iV;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.sId,
        this.stallNo,
        this.stallName,
        this.remarks,
        this.status,
        this.insertedBy,
        this.updatedBy,
        this.deletedAt,
        this.iV,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    stallNo = json['stall_no'];
    stallName = json['stall_name'];
    remarks = json['remarks'];  // It can be null, but will be of type String?
    status = json['status'];
    insertedBy = json['inserted_by'];
    updatedBy = json['updated_by'];  // Can be null, but will be of type String?
    deletedAt = json['deleted_at'];  // Can be null, but will be of type String?
    iV = json['__v'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = this.sId;
    data['stall_no'] = this.stallNo;
    data['stall_name'] = this.stallName;
    data['remarks'] = this.remarks;
    data['status'] = this.status;
    data['inserted_by'] = this.insertedBy;
    data['updated_by'] = this.updatedBy;
    data['deleted_at'] = this.deletedAt;
    data['__v'] = this.iV;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}