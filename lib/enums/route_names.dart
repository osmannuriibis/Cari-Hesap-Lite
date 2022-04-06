
//import 'package:eldeki_hesap/views/zzz_deneme/deneme_view.dart';

import 'package:cari_hesapp_lite/views/welcome_screen/auth_wrapper/auth_wrapper_view.dart';

import 'package:flutter/cupertino.dart';

enum RouteNames { AuthWrapper, Deneme }

extension Route on RouteNames {
 
 

  String get route {
    switch (this) {
      case RouteNames.AuthWrapper:
        return "/";
      case RouteNames.Deneme:
        return "/deneme";

      default:
        throw Exception("There is no View Route: " + toString());

    }
  }

  Widget get view {
    switch (this) {
      case RouteNames.AuthWrapper:
        return const AuthenticationWrapper();
  

      default:
        throw Exception("There is no View Under: " + toString());
    }
  }
}
