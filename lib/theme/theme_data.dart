import 'package:cari_hesapp_lite/constants/constants.dart';
import 'package:flutter/material.dart';

class MyThemeData /*  extends ThemeData  */ {
  late BuildContext context;
  MyThemeData(this.context);

  ThemeData themeLight() {
    return ThemeData(
      cardTheme: Theme.of(context).cardTheme.copyWith(elevation: 5),
      primaryColor: kPrimaryColor,
      primaryColorLight: kPrimaryLightColor,

      //accentColor: kAccentColor,
      scaffoldBackgroundColor: Colors.grey.shade50,
      fontFamily: "Comfortaa",

      textButtonTheme:
          TextButtonThemeData(style: Theme.of(context).textButtonTheme.style),

      dialogTheme: Theme.of(context).dialogTheme.copyWith(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
      appBarTheme: Theme.of(context).appBarTheme.copyWith(),
    );
  }

  ThemeData themeDark() {
    return ThemeData.dark().copyWith(
      primaryColor: kPrimaryColor,
    );
  }
}
