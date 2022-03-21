import 'package:flutter/material.dart';
import 'package:p2p/Screens/Account/account.dart';
import 'package:p2p/Screens/Approval/ApprovalDetails/approval-details.dart';
import 'package:p2p/Screens/Approval/approval.dart';
import 'package:p2p/Screens/CashFlow/BalSummary/bal-summary.dart';
import 'package:p2p/Screens/CashFlow/CFCompare/cf-compare.dart';
import 'package:p2p/Screens/CashFlow/CFTrend/cf-trend.dart';
import 'package:p2p/Screens/CashFlow/cashFlow.dart';
import 'package:p2p/Screens/ChangePAssword/changePassword.dart';
import 'package:p2p/Screens/Dashboard/dashboard-page.dart';
import 'package:p2p/Screens/HomePage/homePage.dart';
import 'package:p2p/Screens/Login/login-page.dart';
import 'package:p2p/Screens/NotificationPage/notification-page.dart';
import 'package:p2p/landing.dart';
import 'package:p2p/routes/route_names.dart';

class CustomRouter {
  static Route<dynamic> generatedRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeRoute:
        return MaterialPageRoute(builder: (_) => HomePage(currentIndex: 0));
      case landingRoute:
        return MaterialPageRoute(builder: (_) => Landing());
      case accountRoute:
        return MaterialPageRoute(builder: (_) => Account());
      case approvalRoute:
        return MaterialPageRoute(builder: (_) => Approval());
      case cashflowRoute:
        return MaterialPageRoute(builder: (_) => CashFlow());
      case cfBalSummaryRoute:
        return MaterialPageRoute(builder: (_) => BalSummary());
      case cfCompareRoute:
        return MaterialPageRoute(builder: (_) => CFCompare());
      case cfTrendRoute:
        return MaterialPageRoute(builder: (_) => CFTrend());
      case dashboardRoute:
        return MaterialPageRoute(builder: (_) => Dashboard());
      case loginRoute:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case notificationRoute:
        return MaterialPageRoute(builder: (_) => NotificationPage());
      case approvalDetailsRoute:
        return MaterialPageRoute(builder: (_) => ApprovalDetails());
      case changePasswordRoute:
        return MaterialPageRoute(builder: (_) => ChangePassword());
    }
    return MaterialPageRoute(builder: (_) => Landing());
  }
}
