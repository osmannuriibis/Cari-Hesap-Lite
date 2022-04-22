import 'dart:math';

import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

String? get kVersion =>  DeviceUtility.instance.packageInfo?.version;

const kPrimaryColor = Color(0xFFFFA444); //(0xFF6F35A5);
const kPrimaryLightColor = Color(0xFFFFE0B2);

const kAccentColor = Color.fromARGB(255, 255, 94, 0);
const kSecondaryLightColor = Color(0xFFFC6161);

double widthSqrt(BuildContext context) =>
    sqrt(MediaQuery.of(context).size.width);
double width(BuildContext context) => (MediaQuery.of(context).size.width);

double heightSqrt(BuildContext context) =>
    sqrt(MediaQuery.of(context).size.height);
double height(BuildContext context) => (MediaQuery.of(context).size.height);

widthButton(BuildContext context) =>
    (sqrt(MediaQuery.of(context).size.width) * 15 > 300.0)
        ? 300.0
        : sqrt(MediaQuery.of(context).size.width) * 15;

AssetImage get defaultImage =>
    const AssetImage("assets/images/user_default_avatar.png");
