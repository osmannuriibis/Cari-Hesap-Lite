import 'package:cari_hesapp_lite/models/sirket_model.dart';
import 'package:cari_hesapp_lite/models/user_model.dart';
import 'package:cari_hesapp_lite/utils/view_route_util.dart';
import 'package:cari_hesapp_lite/views/profile_view/profile_view.dart';
import 'package:cari_hesapp_lite/views/profile_view/profile_view_model.dart';
import 'package:cari_hesapp_lite/views/sirket/sirket_add/add_sirket_view.dart';
import 'package:cari_hesapp_lite/views/sirket/sirket_add/add_sirket_view.model.dart';
import 'package:cari_hesapp_lite/views/stok/stok_add_view/view_model/stok_add_view_model.dart';

import '../../../../components/cp_indicators/cp_indicator.dart';
import '../../../../services/firebase/auth/service/auth_service.dart';
import '../../../../utils/print.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/user_provider.dart';
import '../../home_view/home_page.dart';
import '../../home_view/home_view_model.dart';
import '../verify_view/verify_view.dart';
import '../verify_view/verify_view_model.dart';
import '../welcome_view/welcome_view.dart';

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: AuthService().authStateChanges(),
      builder: (context, snapshot) {
        var user = snapshot.data;
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CPIndicator());
        }

        if (user == null) return WelcomeScreen();

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
              return const Center(child: CPIndicator());
            }
            var user = snapshot.data?.key;
            var sirket = snapshot.data?.value;

            if (user?.id == null) {
              return ChangeNotifierProvider(
                create: (context) => ProfileViewModel(
                    AuthService().currentUserId!,
                    editing: true,
                    verify: true
                    ),
                child: ProfileView(),
              );
            }

            if (sirket?.id == null) {
              return ChangeNotifierProvider(
                create: (context) => SirketAddViewModel.addNew(),
                child: SirketAddView(),
              );
            } else {
              return ChangeNotifierProvider(
                  create: (context) => HomeViewModel(), child: HomeView());
            }
          },
        ); /* */
      },
    );

    /* 
    final currentUser = Provider.of<User?>(
        context); //AuthService().currentUser ?? context.watch<User>();

    if (currentUser != null) {
      bas("AuthWrapper içinde User State dinlendi");
      bas(currentUser.email);
    } else {
      return WelcomeScreen();
    }
    return StreamBuilder<User?>(
      stream: AuthService().authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          var sirketId =
              Provider.of<UserProvider>(context).fetchAndSetSirketAsFuture();
bas("user--------------");
            bas(snapshot.data);
          if (snapshot.data != null) {
            
            return FutureBuilder<bool>(
              future: sirketId,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  bas("snapshot.data");
                  bas(snapshot.data);
                  if (snapshot.data ?? false) {
                    return ChangeNotifierProvider(
                      create: (context) => HomeViewModel(),
                      child: HomeView(),
                    );
                  } else {
                    return ChangeNotifierProvider(
                      create: (context) => SirketAddViewModel.addNew(),
                      child: SirketAddView(),
                    );
                  }
                } else {
                  return const Scaffold(body: Center(child: CPIndicator()));
                }
              },
            );
          } else {
            return WelcomeScreen();
          }
        } else {
          return const Scaffold(body: Center(child: CPIndicator()));
        }
      },
    ); */
  }
}

/*   */

/*   return StreamBuilder<String?>(
              stream: UserProvider().sirketIdAsStream(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  bas("SIRKET ID");
                  bas(snapshot.data);

                  Stre



                  if (snapshot.data.isNotNullOrEmpty) {
                    return ChangeNotifierProvider(
                      create: (context) => HomeViewModel(),
                      child: HomeView(),
                    );
                  } else {
                    return ChangeNotifierProvider(
                      create: (context) => SirketListViewModel(),
                      child: SirketListView(),
                    );
                  }
                } else {
                  return const Scaffold(body: Center(child: CPIndicator()));
                }
              }); */