class FilterData {
  String modelErrors;
  List<FilterResultObject> resultObject;
  int statusCode;
  bool isSuccess;
  String commonErrors;

  FilterData(
      {this.modelErrors,
      this.resultObject,
      this.statusCode,
      this.isSuccess,
      this.commonErrors});

  FilterData.fromJson(Map<String, dynamic> json) {
    modelErrors = json['ModelErrors'];
    if (json['ResultObject'] != null) {
      resultObject = <FilterResultObject>[];
      json['ResultObject'].forEach((v) {
        resultObject.add(new FilterResultObject.fromJson(v));
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

class FilterResultObject {
  List<P2PType> p2PType;
  List<BusinessUnit> businessUnit;

  FilterResultObject({this.p2PType, this.businessUnit});

  FilterResultObject.fromJson(Map<String, dynamic> json) {
    if (json['P2PType'] != null) {
      p2PType = <P2PType>[];
      json['P2PType'].forEach((v) {
        p2PType.add(new P2PType.fromJson(v));
      });
    }
    if (json['BusinessUnit'] != null) {
      businessUnit = <BusinessUnit>[];
      json['BusinessUnit'].forEach((v) {
        businessUnit.add(new BusinessUnit.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.p2PType != null) {
      data['P2PType'] = this.p2PType.map((v) => v.toJson()).toList();
    }
    if (this.businessUnit != null) {
      data['BusinessUnit'] = this.businessUnit.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class P2PType {
  int typeId;
  String typeName;

  P2PType({this.typeId, this.typeName});

  P2PType.fromJson(Map<String, dynamic> json) {
    typeId = json['TypeId'];
    typeName = json['TypeName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TypeId'] = this.typeId;
    data['TypeName'] = this.typeName;
    return data;
  }
}

class BusinessUnit {
  int businessUnitId;
  String businessUnitName;

  BusinessUnit({this.businessUnitId, this.businessUnitName});

  BusinessUnit.fromJson(Map<String, dynamic> json) {
    businessUnitId = json['BusinessUnitId'];
    businessUnitName = json['BusinessUnitName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['BusinessUnitId'] = this.businessUnitId;
    data['BusinessUnitName'] = this.businessUnitName;
    return data;
  }
}
