import 'package:flutter/material.dart';

class WrapCards extends StatelessWidget {
  final List<Widget> children;
  final Function()? onTap;
  final Axis direction;
  final BorderSide borderSide;
  final double borderRadius;
  final WrapAlignment alignment, runAlignment;
  final WrapCrossAlignment crossAxisAlignment;

  const WrapCards(
      {Key? key,
      required this.children,
      this.onTap,
      this.direction = Axis.vertical,
      this.borderSide = BorderSide.none,
      this.borderRadius = 4,
      this.alignment = WrapAlignment.start,
      this.runAlignment = WrapAlignment.center,
      this.crossAxisAlignment =WrapCrossAlignment.center})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusDirectional.circular(4),
            side: borderSide),
        child: (children.isNotEmpty) //liste boşsa bir görüntü çizmesin, aksi halde boş kutu çiziyor
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Wrap(
                  
                  crossAxisAlignment: crossAxisAlignment,
                  alignment: alignment,
                  runAlignment: runAlignment,
                  direction: direction,
                  children: children,
                ),
              )
            : null,
      ),
    );
  }
}
