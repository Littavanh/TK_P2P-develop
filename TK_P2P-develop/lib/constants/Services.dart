class Services {
//static final String BASE_URL = "http://52.172.206.238/LMSIO/api/"; //old UAT
  // static final String BASE_URL = "http://103.151.76.45:8084/api/";
   static final String BASE_URL = "http://103.151.76.45:44388/api/";
  // static final String BASE_URL = "http://hrm.tkgroup.la:44375/api/"; //new UAT
  static final String LOGIN = BASE_URL + 'User/Login';
  static final String ApprovalList = BASE_URL + 'Approve/ApproveList';
  static final String ApprovalHistory = BASE_URL + 'Approve/ApprovalHistory';
  static final String ApprovalStatus = BASE_URL + 'Approve/Approval';
  static final String ApprovalDetails = BASE_URL + 'Approve/ApprovalListDetail';
  static final String FilterData = BASE_URL + 'Approve/getDataFilter';
  static final String NotificationList = BASE_URL + 'Approve/NotificationList';
  static final String ChangePassword = BASE_URL + 'Values/ChangePassword';
  static final String DashboardData = BASE_URL + 'Values/HomeData';
}
