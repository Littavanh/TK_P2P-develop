class LoginResponse {
  String modelErrors;
  List<ResultObject> resultObject;
  int statusCode;
  bool isSuccess;
  String commonErrors;

  LoginResponse(
      {this.modelErrors,
      this.resultObject,
      this.statusCode,
      this.isSuccess,
      this.commonErrors});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    modelErrors = json['ModelErrors'];
    if (json['ResultObject'] != null) {
      resultObject = new List<ResultObject>();
      json['ResultObject'].forEach((v) {
        resultObject.add(new ResultObject.fromJson(v));
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

class ResultObject {
  int userId;
  String firstName;
  String lastName;
  String mobile;
  String email;
  String photoPath;
  int userTypeId;
  int employeeId;
  int departmentId;
  String departmentName;
  int businessUnitId;
  String businessUnitName;
  String tokenKey;
  String tokenDevice;

  ResultObject(
      {this.userId,
      this.firstName,
      this.lastName,
      this.mobile,
      this.email,
      this.photoPath,
      this.userTypeId,
      this.employeeId,
      this.departmentId,
      this.departmentName,
      this.businessUnitId,
      this.businessUnitName,
      this.tokenKey,
      this.tokenDevice});

  ResultObject.fromJson(Map<String, dynamic> json) {
    userId = json['UserId'];
    firstName = json['FirstName'];
    lastName = json['LastName'];
    mobile = json['Mobile'];
    email = json['Email'];
    photoPath = json['PhotoPath'];
    userTypeId = json['UserTypeId'];
    employeeId = json['EmployeeId'];
    departmentId = json['DepartmentId'];
    departmentName = json['DepartmentName'];
    businessUnitId = json['BusinessUnitId'];
    businessUnitName = json['BusinessUnitName'];
    tokenKey = json['TokenKey'];
    tokenDevice = json['TokenDevice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['UserId'] = this.userId;
    data['FirstName'] = this.firstName;
    data['LastName'] = this.lastName;
    data['Mobile'] = this.mobile;
    data['Email'] = this.email;
    data['PhotoPath'] = this.photoPath;
    data['UserTypeId'] = this.userTypeId;
    data['EmployeeId'] = this.employeeId;
    data['DepartmentId'] = this.departmentId;
    data['DepartmentName'] = this.departmentName;
    data['BusinessUnitId'] = this.businessUnitId;
    data['BusinessUnitName'] = this.businessUnitName;
    data['TokenKey'] = this.tokenKey;
    data['TokenDevice'] = this.tokenDevice;
    return data;
  }
}
