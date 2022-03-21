class DashboardDataPODO {
  String modelErrors;
  ResultObject resultObject;
  int statusCode;
  bool isSuccess;
  String commonErrors;

  DashboardDataPODO(
      {this.modelErrors,
      this.resultObject,
      this.statusCode,
      this.isSuccess,
      this.commonErrors});

  DashboardDataPODO.fromJson(Map<String, dynamic> json) {
    modelErrors = json['ModelErrors'];
    resultObject = json['ResultObject'] != null
        ? new ResultObject.fromJson(json['ResultObject'])
        : null;
    statusCode = json['StatusCode'];
    isSuccess = json['IsSuccess'];
    commonErrors = json['CommonErrors'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ModelErrors'] = this.modelErrors;
    if (this.resultObject != null) {
      data['ResultObject'] = this.resultObject.toJson();
    }
    data['StatusCode'] = this.statusCode;
    data['IsSuccess'] = this.isSuccess;
    data['CommonErrors'] = this.commonErrors;
    return data;
  }
}

class ResultObject {
  String buyBaht;
  String buyUsd;
  String sellBaht;
  String sellUsd;
  String pOTotalBudget;
  String pOOutStanding;
  String nonPOTotalBudget;
  String nonPOExpense;
  String pendingNumber;

  ResultObject(
      {this.buyBaht,
      this.buyUsd,
      this.sellBaht,
      this.sellUsd,
      this.pOTotalBudget,
      this.pOOutStanding,
      this.nonPOTotalBudget,
      this.nonPOExpense,
      this.pendingNumber});

  ResultObject.fromJson(Map<String, dynamic> json) {
    buyBaht = json['BuyBaht'];
    buyUsd = json['BuyUsd'];
    sellBaht = json['SellBaht'];
    sellUsd = json['SellUsd'];
    pOTotalBudget = json['POTotalBudget'];
    pOOutStanding = json['POOutStanding'];
    nonPOTotalBudget = json['NonPOTotalBudget'];
    nonPOExpense = json['NonPOExpense'];
    pendingNumber = json['PendingNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['BuyBaht'] = this.buyBaht;
    data['BuyUsd'] = this.buyUsd;
    data['SellBaht'] = this.sellBaht;
    data['SellUsd'] = this.sellUsd;
    data['POTotalBudget'] = this.pOTotalBudget;
    data['POOutStanding'] = this.pOOutStanding;
    data['NonPOTotalBudget'] = this.nonPOTotalBudget;
    data['NonPOExpense'] = this.nonPOExpense;
    data['PendingNumber'] = this.pendingNumber;
    return data;
  }
}
