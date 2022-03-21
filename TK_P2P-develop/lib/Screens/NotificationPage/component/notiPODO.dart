class NotiPodo {
  String modelErrors;
  List<NotiResultObject> resultObject;
  int statusCode;
  bool isSuccess;
  String commonErrors;

  NotiPodo(
      {this.modelErrors,
      this.resultObject,
      this.statusCode,
      this.isSuccess,
      this.commonErrors});

  NotiPodo.fromJson(Map<String, dynamic> json) {
    modelErrors = json['ModelErrors'];
    if (json['ResultObject'] != null) {
      resultObject = <NotiResultObject>[];
      json['ResultObject'].forEach((v) {
        resultObject.add(new NotiResultObject.fromJson(v));
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

class NotiResultObject {
  int p2PTypeId;
  int appID;
  String appNo;
  String appDate;
  String title;
  int businessUnitId;
  String businessUnitName;
  String totalAmount;
  String appStatus;
  String appType;
  String currencyName;
  int approverId;
  int levelId;
  int createdBy;

  NotiResultObject(
      {this.p2PTypeId,
      this.appID,
      this.appNo,
      this.appDate,
      this.title,
      this.businessUnitId,
      this.businessUnitName,
      this.totalAmount,
      this.appStatus,
      this.appType,
      this.currencyName,
      this.approverId,
      this.levelId,
      this.createdBy});

  NotiResultObject.fromJson(Map<String, dynamic> json) {
    p2PTypeId = json['P2PTypeId'];
    appID = json['AppID'];
    appNo = json['AppNo'];
    appDate = json['AppDate'];
    title = json['Title'];
    businessUnitId = json['BusinessUnitId'];
    businessUnitName = json['BusinessUnitName'];
    totalAmount = json['TotalAmount'];
    appStatus = json['AppStatus'];
    appType = json['AppType'];
    currencyName = json['CurrencyName'];
    approverId = json['ApproverId'];
    levelId = json['LevelId'];
    createdBy = json['CreatedBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['P2PTypeId'] = this.p2PTypeId;
    data['AppID'] = this.appID;
    data['AppNo'] = this.appNo;
    data['AppDate'] = this.appDate;
    data['Title'] = this.title;
    data['BusinessUnitId'] = this.businessUnitId;
    data['BusinessUnitName'] = this.businessUnitName;
    data['TotalAmount'] = this.totalAmount;
    data['AppStatus'] = this.appStatus;
    data['AppType'] = this.appType;
    data['CurrencyName'] = this.currencyName;
    data['ApproverId'] = this.approverId;
    data['LevelId'] = this.levelId;
    data['CreatedBy'] = this.createdBy;
    return data;
  }
}
