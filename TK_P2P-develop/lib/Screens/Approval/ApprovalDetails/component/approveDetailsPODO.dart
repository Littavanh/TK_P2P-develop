// class ApproveDetails {
//   String modelErrors;
//   List<ResultObjectAprvDetls> resultObject;
//   int statusCode;
//   bool isSuccess;
//   String commonErrors;

//   ApproveDetails(
//       {this.modelErrors,
//       this.resultObject,
//       this.statusCode,
//       this.isSuccess,
//       this.commonErrors});

//   ApproveDetails.fromJson(Map<String, dynamic> json) {
//     modelErrors = json['ModelErrors'];
//     if (json['ResultObject'] != null) {
//       resultObject = new List<ResultObjectAprvDetls>();
//       json['ResultObject'].forEach((v) {
//         resultObject.add(new ResultObjectAprvDetls.fromJson(v));
//       });
//     }
//     statusCode = json['StatusCode'];
//     isSuccess = json['IsSuccess'];
//     commonErrors = json['CommonErrors'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['ModelErrors'] = this.modelErrors;
//     if (this.resultObject != null) {
//       data['ResultObject'] = this.resultObject.map((v) => v.toJson()).toList();
//     }
//     data['StatusCode'] = this.statusCode;
//     data['IsSuccess'] = this.isSuccess;
//     data['CommonErrors'] = this.commonErrors;
//     return data;
//   }
// }

// class ResultObjectAprvDetls {
//   int appID;
//   String appNo;
//   String appDate;
//   String budgetType;
//   String businessUnitName;
//   String currencyName;
//   String description;
//   String payTo;
//   List<OrderItems> orderItems;
//   String netTotal;
//   String appStatus;
//   String appType;
//   List<AttacheFile> attacheFile;
//   String tokenKey;

//   ResultObjectAprvDetls(
//       {this.appID,
//       this.appNo,
//       this.appDate,
//       this.budgetType,
//       this.businessUnitName,
//       this.currencyName,
//       this.description,
//       this.payTo,
//       this.orderItems,
//       this.netTotal,
//       this.appStatus,
//       this.appType,
//       this.attacheFile,
//       this.tokenKey});

//   ResultObjectAprvDetls.fromJson(Map<String, dynamic> json) {
//     appID = json['AppID'];
//     appNo = json['AppNo'];
//     appDate = json['AppDate'];
//     budgetType = json['BudgetType'];
//     businessUnitName = json['BusinessUnitName'];
//     currencyName = json['CurrencyName'];
//     description = json['Description'];
//     payTo = json['PayTo'];
//     if (json['OrderItems'] != null) {
//       orderItems = <OrderItems>[];
//       json['OrderItems'].forEach((v) {
//         orderItems.add(new OrderItems.fromJson(v));
//       });
//     }
//     netTotal = json['NetTotal'];
//     appStatus = json['AppStatus'];
//     appType = json['AppType'];
//     if (json['AttacheFile'] != null) {
//       attacheFile = new List<AttacheFile>();
//       json['AttacheFile'].forEach((v) {
//         attacheFile.add(new AttacheFile.fromJson(v));
//       });
//     }
//     tokenKey = json['TokenKey'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['AppID'] = this.appID;
//     data['AppNo'] = this.appNo;
//     data['AppDate'] = this.appDate;
//     data['BudgetType'] = this.budgetType;
//     data['BusinessUnitName'] = this.businessUnitName;
//     data['CurrencyName'] = this.currencyName;
//     data['Description'] = this.description;
//     data['PayTo'] = this.payTo;
//     if (this.orderItems != null) {
//       data['OrderItems'] = this.orderItems.map((v) => v.toJson()).toList();
//     }
//     data['NetTotal'] = this.netTotal;
//     data['AppStatus'] = this.appStatus;
//     data['AppType'] = this.appType;
//     if (this.attacheFile != null) {
//       data['AttacheFile'] = this.attacheFile.map((v) => v.toJson()).toList();
//     }
//     data['TokenKey'] = this.tokenKey;
//     return data;
//   }
// }

// class OrderItems {
//   String title;
//   String price;
//   double qty;
//   String total;
//   double discount;
//   double tax;
//   String freight;
//   String subTotal;

//   OrderItems(
//       {this.title,
//       this.price,
//       this.qty,
//       this.total,
//       this.discount,
//       this.tax,
//       this.freight,
//       this.subTotal});

//   OrderItems.fromJson(Map<String, dynamic> json) {
//     title = json['Title'];
//     price = json['Price'];
//     qty = json['Qty'];
//     total = json['Total'];
//     discount = json['Discount'];
//     tax = json['Tax'];
//     freight = json['Freight'];
//     subTotal = json['SubTotal'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['Title'] = this.title;
//     data['Price'] = this.price;
//     data['Qty'] = this.qty;
//     data['Total'] = this.total;
//     data['Discount'] = this.discount;
//     data['Tax'] = this.tax;
//     data['Freight'] = this.freight;
//     data['SubTotal'] = this.subTotal;
//     return data;
//   }
// }

// class AttacheFile {
//   String fileName;
//   String fileType;

//   AttacheFile({this.fileName, this.fileType});

//   AttacheFile.fromJson(Map<String, dynamic> json) {
//     fileName = json['FileName'];
//     fileType = json['FileType'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['FileName'] = this.fileName;
//     data['FileType'] = this.fileType;
//     return data;
//   }
// }

class ApproveDetails {
  String modelErrors;
  List<ResultObjectAprvDetls> resultObject;
  int statusCode;
  bool isSuccess;
  String commonErrors;

  ApproveDetails(
      {this.modelErrors,
      this.resultObject,
      this.statusCode,
      this.isSuccess,
      this.commonErrors});

  ApproveDetails.fromJson(Map<String, dynamic> json) {
    modelErrors = json['ModelErrors'];
    if (json['ResultObject'] != null) {
      resultObject = <ResultObjectAprvDetls>[];
      json['ResultObject'].forEach((v) {
        resultObject.add(new ResultObjectAprvDetls.fromJson(v));
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

class ResultObjectAprvDetls {
  int appID;
  String appNo;
  String appDate;
  String budgetType;
  String businessUnitName;
  String currencyName;
  String description;
  String payTo;
  List<OrderItems> orderItems;
  String netTotal;
  String appStatus;
  String appType;
  List<AttacheFile> attacheFile;
  String tokenKey;
  bool isApprove;
  bool isReject;
  bool isHold;
  String requestBy;

  ResultObjectAprvDetls(
      {this.appID,
      this.appNo,
      this.appDate,
      this.budgetType,
      this.businessUnitName,
      this.currencyName,
      this.description,
      this.payTo,
      this.orderItems,
      this.netTotal,
      this.appStatus,
      this.appType,
      this.attacheFile,
      this.tokenKey,
      this.isApprove,
      this.isReject,
      this.isHold,
      this.requestBy});

  ResultObjectAprvDetls.fromJson(Map<String, dynamic> json) {
    appID = json['AppID'];
    appNo = json['AppNo'];
    appDate = json['AppDate'];
    budgetType = json['BudgetType'];
    businessUnitName = json['BusinessUnitName'];
    currencyName = json['CurrencyName'];
    description = json['Description'];
    payTo = json['PayTo'];
    if (json['OrderItems'] != null) {
      orderItems = new List<OrderItems>();
      json['OrderItems'].forEach((v) {
        orderItems.add(new OrderItems.fromJson(v));
      });
    }
    netTotal = json['NetTotal'];
    appStatus = json['AppStatus'];
    appType = json['AppType'];
    if (json['AttacheFile'] != null) {
      attacheFile = new List<AttacheFile>();
      json['AttacheFile'].forEach((v) {
        attacheFile.add(new AttacheFile.fromJson(v));
      });
    }
    tokenKey = json['TokenKey'];
    isApprove = json['isApprove'];
    isReject = json['isReject'];
    isHold = json['isHold'];
    requestBy = json['RequestBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['AppID'] = this.appID;
    data['AppNo'] = this.appNo;
    data['AppDate'] = this.appDate;
    data['BudgetType'] = this.budgetType;
    data['BusinessUnitName'] = this.businessUnitName;
    data['CurrencyName'] = this.currencyName;
    data['Description'] = this.description;
    data['PayTo'] = this.payTo;
    if (this.orderItems != null) {
      data['OrderItems'] = this.orderItems.map((v) => v.toJson()).toList();
    }
    data['NetTotal'] = this.netTotal;
    data['AppStatus'] = this.appStatus;
    data['AppType'] = this.appType;
    if (this.attacheFile != null) {
      data['AttacheFile'] = this.attacheFile.map((v) => v.toJson()).toList();
    }
    data['TokenKey'] = this.tokenKey;
    data['isApprove'] = this.isApprove;
    data['isReject'] = this.isReject;
    data['isHold'] = this.isHold;
    data['RequestBy'] = this.requestBy;
    return data;
  }
}

class OrderItems {
  String title;
  String price;
  double qty;
  String total;
  double discount;
  double tax;
  String freight;
  String subTotal;

  OrderItems(
      {this.title,
      this.price,
      this.qty,
      this.total,
      this.discount,
      this.tax,
      this.freight,
      this.subTotal});

  OrderItems.fromJson(Map<String, dynamic> json) {
    title = json['Title'];
    price = json['Price'];
    qty = json['Qty'];
    total = json['Total'];
    discount = json['Discount'];
    tax = json['Tax'];
    freight = json['Freight'];
    subTotal = json['SubTotal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Title'] = this.title;
    data['Price'] = this.price;
    data['Qty'] = this.qty;
    data['Total'] = this.total;
    data['Discount'] = this.discount;
    data['Tax'] = this.tax;
    data['Freight'] = this.freight;
    data['SubTotal'] = this.subTotal;
    return data;
  }
}

class AttacheFile {
  String fileName;
  String fileType;

  AttacheFile({this.fileName, this.fileType});

  AttacheFile.fromJson(Map<String, dynamic> json) {
    fileName = json['FileName'];
    fileType = json['FileType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['FileName'] = this.fileName;
    data['FileType'] = this.fileType;
    return data;
  }
}
