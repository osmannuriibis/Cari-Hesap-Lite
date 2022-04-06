import '../../constants/constants.dart';
import 'package:flutter/material.dart';

class MyCard extends StatelessWidget {
  final Widget? child;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final BorderSide borderSide;
  final double borderRadius;
  final EdgeInsetsGeometry padding, margin;
  final double? aspectRatio;
  final double? height, width;
  final Widget? title;

  final AlignmentGeometry alignment;

  const MyCard({
    Key? key,
     this.child,
    this.onTap,
    this.margin = const EdgeInsets.all(0),
    this.borderSide = BorderSide.none,
    this.borderRadius = 4,
    this.backgroundColor,
    this.padding = const EdgeInsets.all(8.0),
    this.aspectRatio,
    this.title,
    this.height,
    this.width,
    this.alignment = Alignment.center,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (child == null) {
      return const SizedBox.shrink();
    }
    return Container(
      margin: margin,
      child: Column(
        children: [
          Visibility(
              visible: title != null, child: title ?? const SizedBox.shrink()),
          aspectRatio != null
              ? AspectRatio(
                  aspectRatio: aspectRatio!,
                  child: _Card(
                      height: height,
                      onTap: onTap,
                      width_: width,
                      padding: padding,
                      backgroundColor: backgroundColor,
                      borderRadius: borderRadius,
                      borderSide: borderSide,
                      alignment: alignment,
                      child: child),
                )
              : _Card(
                  height: height,
                  onTap: onTap,
                  width_: width,
                  padding: padding,
                  backgroundColor: backgroundColor,
                  borderRadius: borderRadius,
                  borderSide: borderSide,
                  alignment: alignment,
                  child: child),
        ],
      ),
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({
    Key? key,
    required this.height,
    required this.onTap,
    required this.padding,
    this.width_,
    required this.backgroundColor,
    required this.borderRadius,
    required this.borderSide,
    required this.alignment,
    required this.child,
  }) : super(key: key);

  final double? height, width_;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;
  final Color? backgroundColor;
  final double borderRadius;
  final BorderSide borderSide;
  final AlignmentGeometry alignment;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width_ ?? width(context),
      height: height,
      child: GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: padding,
          child: Card(
              color: backgroundColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusDirectional.circular(borderRadius),
                  side: borderSide),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(alignment: alignment, child: child),
              )),
        ),
      ),
    );
  }
}
