import 'package:cari_hesapp_lite/utils/user_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'theme/theme_data.dart';
import 'utils/konum_service/konum_service.dart';
import 'utils/print.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'enums/route_names.dart';
import 'services/firebase/auth/service/auth_service.dart';
import 'views/welcome_screen/auth_wrapper/auth_wrapper_view.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  (await Firebase.initializeApp());
  KonumService();
  bas("main");

   FirebaseFirestore.instance.settings = const Settings(
    
    cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED
  );

  Provider.debugCheckInvalidValueType = null; //TODO what is it?
  runApp(Phoenix(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {



    return MultiProvider(
      providers: [
        Provider<AuthService>(create: (_) => AuthService()),
      /*   StreamProvider<User?>(
          initialData: null,
          create: (context) => AuthService().authStateChanges(),
        ), */
        ChangeNotifierProvider<UserProvider>(
            create: (context) => UserProvider(), lazy: false)

        /*  ChangeNotifierProvider(
          create: (context) => UserProvider(), 
        )*/
      ],
      child: MaterialApp(
        // localizationsDelegates: [GlobalMaterialLocalizations.delegates,],
        localizationsDelegates: const [
          // location_picker.S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        // ignore: prefer_const_literals_to_create_immutables
        supportedLocales: [
          const Locale('tr', 'TR'), // Turkish turkish

          const Locale('en', 'US'), // American English
          // ...
        ],
        routes: /* RouteNames.values.map<Map>((e) => null) */ {
          RouteNames.AuthWrapper.route: (context) =>
              const AuthenticationWrapper(),
          RouteNames.Deneme.route: (context) => RouteNames.Deneme.view,
        },
        initialRoute: RouteNames.AuthWrapper.route,
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',

        theme: MyThemeData(context).themeLight(),
        darkTheme: MyThemeData(context).themeDark(),
        themeMode: ThemeMode.light,
        /*  home:
            /* ChangeNotifierProvider(
            create: (context) => SirketAddViewModel(), child: SirketAddView()), */
            AuthenticationWrapper(), */
      ),
    );

    /* ; */
  }
}
