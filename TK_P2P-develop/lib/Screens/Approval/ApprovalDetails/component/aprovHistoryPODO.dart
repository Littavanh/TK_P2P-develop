class ApproveHistory {
  String modelErrors;
  List<HistResultObject> resultObject;
  int statusCode;
  bool isSuccess;
  String commonErrors;

  ApproveHistory(
      {this.modelErrors,
      this.resultObject,
      this.statusCode,
      this.isSuccess,
      this.commonErrors});

  ApproveHistory.fromJson(Map<String, dynamic> json) {
    modelErrors = json['ModelErrors'];
    if (json['ResultObject'] != null) {
      resultObject = new List<HistResultObject>();
      json['ResultObject'].forEach((v) {
        resultObject.add(new HistResultObject.fromJson(v));
      });
    }
    statusCode = json['StatusCode'];
    isSuccess = json['IsSuccess'];
    commonErrors = json['CommonErrors'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ModelErrors'] = this.modelErrors;
    if (this.resultObject != null) {
      data['ResultObject'] = this.resultObject.map((v) => v.toJson()).toList();
    }
    data['StatusCode'] = this.statusCode;
    data['IsSuccess'] = this.isSuccess;
    data['CommonErrors'] = this.commonErrors;
    return data;
  }
}

class HistResultObject {
  int appID;
  String appNo;
  String appDateTime;
  String approverName;
  String remarks;

  HistResultObject(
      {this.appID,
      this.appNo,
      this.appDateTime,
      this.approverName,
      this.remarks});

  HistResultObject.fromJson(Map<String, dynamic> json) {
    appID = json['AppID'];
    appNo = json['AppNo'];
    appDateTime = json['AppDateTime'];
    approverName = json['ApproverName'];
    remarks = json['Remarks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['AppID'] = this.appID;
    data['AppNo'] = this.appNo;
    data['AppDateTime'] = this.appDateTime;
    data['ApproverName'] = this.approverName;
    data['Remarks'] = this.remarks;
    return data;
  }
}
