class ChangePasswordPODO {
  String modelErrors;
  String resultObject;
  int statusCode;
  bool isSuccess;
  String commonErrors;

  ChangePasswordPODO(
      {this.modelErrors,
      this.resultObject,
      this.statusCode,
      this.isSuccess,
      this.commonErrors});

  ChangePasswordPODO.fromJson(Map<String, dynamic> json) {
    modelErrors = json['ModelErrors'];
    resultObject = json['ResultObject'];
    statusCode = json['StatusCode'];
    isSuccess = json['IsSuccess'];
    commonErrors = json['CommonErrors'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ModelErrors'] = this.modelErrors;
    data['ResultObject'] = this.resultObject;
    data['StatusCode'] = this.statusCode;
    data['IsSuccess'] = this.isSuccess;
    data['CommonErrors'] = this.commonErrors;
    return data;
  }
}
