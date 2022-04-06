import '../../../services/firebase/auth/service/auth_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashViewModel {
  AuthService _authService = AuthService();

  control(BuildContext context) async {
    // await SharedPreferencesManeger.prefrencesInit();
    // await UserProvider().initFuture();

    await Future.delayed(const Duration(seconds: 3));

    
  }

 /*  navigate() async {
    bool? isOpen = SharedPreferencesManeger.instance.getBoolValue(EnumPreferencesKeys.ISFIRSTOPEN);

    if (isOpen == null || isOpen == false) {
      SharedPreferencesManeger.instance.setBoolValue(EnumPreferencesKeys.ISFIRSTOPEN, true);
      NavigationServices.instance.navigateToReset(path: E_Navigation.ONBOARD);
    } else {
      if (AuthService().user != null) {
        //
        goToWiewPush(path: E_Navigation.MY_FIRS_VIEW); //TODO: bu bölüm silinecek
      } else //
        goToWiewPop(path: E_Navigation.LOGIN, args: LoginViewModel());
      //  path: E_Navigation.MY_FIRS_VIEW,

    }
  } */
}
