import 'package:flutter/material.dart';

class DrawerItem extends StatelessWidget {
  final  String? label;
  final IconData icon;
  final VoidCallback? onTap;

  final bool showBadge;

  const DrawerItem(
      {Key? key,
      @required this.label,
      @required this.onTap,
      this.icon = Icons.info,
      this.showBadge = false})
      : super(key: key);

/*  */

  @override
  Widget build(BuildContext context) {
     TextStyle tStyle = const TextStyle(color: Colors.black, fontSize: 16.0);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
          child: Row(
            children: [
              Icon(
                icon,
                color: Colors.grey[850],
              ),
              const SizedBox(width: 10.0),
              Text(
                label!,
                style: tStyle,
              ),
              const Spacer(),
              if (showBadge)
                Material(
                  color: Colors.deepOrange,
                  elevation: 5.0,
                  shadowColor: Colors.red,
                  borderRadius: BorderRadius.circular(5.0),
                  child: Container(
                    width: 25,
                    height: 25,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.deepOrange,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: const Text(
                      "10+",
                      style:  TextStyle(
                          color: Colors.white,
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
    /*return  Column(
      children: [
        GestureDetector(
          child: Container(
              margin: EdgeInsets.all(3),
              width: double.infinity,
              //   color: Colors.amber[100],
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(label),
              )),
          onTap: onPressed,
        ),
        Divider()
      ],
    ); */
  }
}
