import 'package:cari_hesapp_lite/constants/constants.dart';
import 'package:cari_hesapp_lite/models/sirket_model.dart';
import 'package:cari_hesapp_lite/models/user_model.dart';
import 'package:cari_hesapp_lite/services/firebase/database/utils/database_utils.dart';
import 'package:cari_hesapp_lite/utils/extensions.dart';
import 'package:cari_hesapp_lite/views/profile_view/profile_view.dart';
import 'package:cari_hesapp_lite/views/profile_view/profile_view_model.dart';
import 'package:cari_hesapp_lite/views/sirket/sirket_add/add_sirket_view.dart';
import 'package:cari_hesapp_lite/views/sirket/sirket_add/add_sirket_view.model.dart';
import 'package:cari_hesapp_lite/views/welcome_screen/login_view/login_view.dart';
import 'package:cari_hesapp_lite/views/welcome_screen/login_view/login_view_model.dart';
import 'package:cari_hesapp_lite/views/welcome_screen/splash/splash.dart';
import 'package:kartal/kartal.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../components/cp_indicators/cp_indicator.dart';
import '../../../../services/firebase/auth/service/auth_service.dart';
import '../../../../utils/print.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/user_provider.dart';
import '../../home_view/home_page.dart';
import '../../home_view/home_view_model.dart';
import '../onboarding/onboarding_view.dart';
import '../onboarding/onboarding_view_model.dart';
import '../verify_view/verify_view.dart';
import '../verify_view/verify_view_model.dart';

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool?>(
        future: getShared(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const SplashView();
          }

          if (snapshot.data ?? true) {
            getShared(true);

            return ChangeNotifierProvider(
              create: (context) => OnBoardingViewModel(),
              child: const OnBoardingView(),
            );
          } else {
            return StreamBuilder<User?>(
              stream: AuthService().authStateChanges(),
              builder: (context, snapshot) {
                var user = snapshot.data;
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: SplashView());
                }

                if (user == null) {
                  return ChangeNotifierProvider(
                    create: (context) => LoginViewModel(),
                    child: const LoginView(),
                  );
                }

                // ignore: dead_code
                if (!user.emailVerified) {
                  return ChangeNotifierProvider(
                    create: (context) => VerifyViewModel(),
                    child: VerifyView(),
                  );
                }

                return FutureBuilder<MapEntry<UserModel?, SirketModel?>>(
                  future: UserProvider().fetchUserAndSirket(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState != ConnectionState.done) {
                      return const Center(child: SplashView());
                    }
                    var user = snapshot.data?.key;
                    var sirket = snapshot.data?.value;
                    bas("user?.id");
                    bas(user?.id);
                    if (user?.id == null) {
                      return ChangeNotifierProvider(
                        create: (context) => ProfileViewModel(
                            AuthService().currentUserId!,
                            editing: true,
                            verify: true),
                        child: ProfileView(),
                      );
                    }

                    if (sirket?.id == null) {
                      return ChangeNotifierProvider(
                        create: (context) => SirketAddViewModel.addNew(),
                        child: const SirketAddView(),
                      );
                    } else {
                      writeVersion();
                      return ChangeNotifierProvider(
                          create: (context) => HomeViewModel(),
                          child: HomeView());
                    }
                  },
                ); /* */
              },
            );
          }
        });
  }
}

Future<bool?> getShared([bool set = false]) async {
  var instance = SharedPreferences.getInstance();

  return instance.then((value) {
    if (set) {
      value.setBool("isFirst", false);
      return null;
    }

    return value.getBool("isFirst");
  });
}

Future<void> writeVersion() async {
  await DeviceUtility.instance.initPackageInfo();
  DBUtils()
      .getModelReference<UserModel>(AuthService().currentUserId!)
      .update({"version": kVersion});
}
