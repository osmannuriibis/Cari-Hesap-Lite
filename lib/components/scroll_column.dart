import 'package:flutter/material.dart';

class MyColumn extends StatelessWidget {
  final ScrollPhysics? physics;
  final EdgeInsetsGeometry? padding;
  final List<Widget> children;
  final MainAxisSize mainAxisSize; //= MainAxisSize.max;
  final CrossAxisAlignment crossAxisAlignment; // ;
  final MainAxisAlignment mainAxisAlignment;

  final bool isSeperator; //;

  final Widget seperator = const Divider();

  const MyColumn({
    Key? key,
    this.physics = const BouncingScrollPhysics(),
    this.padding,
    this.children = const <Widget>[],
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.isSeperator = false,
    this.mainAxisSize = MainAxisSize.min,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: physics,
      padding: padding,
      child: Column(
        children: isSeperator
            ? ([
                for (var item in children)
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [item, if (item != children.last) seperator],
                  )
              ])
            : children,
        mainAxisSize: mainAxisSize,
        crossAxisAlignment: crossAxisAlignment,
        mainAxisAlignment: mainAxisAlignment,
      ),
    );
  }
}
