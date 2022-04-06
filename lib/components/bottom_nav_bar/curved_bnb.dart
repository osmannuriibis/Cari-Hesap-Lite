
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:cari_hesapp_lite/constants/constants.dart';
import 'package:flutter/material.dart';
class MyCurvedBotNavBar extends StatefulWidget {
  final List<Widget>? items;
  final ValueChanged<int>? onPageSelected;

  final int index;

  const MyCurvedBotNavBar({
    Key? key,
    this.onPageSelected,
    this.items = const <Widget>[
      Icon(Icons.home, size: 30),
      Icon(Icons.favorite_border, size: 30),
      Icon(Icons.supervised_user_circle, size: 30),
      Icon(Icons.notifications_active, size: 30),
      Icon(Icons.more_vert, size: 30),
    ],
    this.index = 0,
  }) : super(key: key);

  @override
  _MyCurvedBotNavBarState createState() => _MyCurvedBotNavBarState();
}

class _MyCurvedBotNavBarState extends State<MyCurvedBotNavBar> {
  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      letIndexChange: (value) {
        return true;
      },
      key: widget.key,
      index: widget.index,
      height: kBottomNavigationBarHeight,
      items: widget.items!,

      color: kPrimaryColor,
      buttonBackgroundColor: kPrimaryLightColor,
      backgroundColor: kPrimaryLightColor,
      //   animationCurve: Curves.linear,
      // animationDuration: Duration(milliseconds: 500),
      onTap: widget.onPageSelected,
    );
  }
}