import 'package:cari_hesapp_lite/constants/constants.dart';
import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final List<Widget>? actions;
  late final String titleText;
  final PreferredSizeWidget? bottom;
  final bool? centerTitle;
  final double? toolbarHeight;
  final Widget? title;
  final bool automaticallyImplyLeading;

  @override
  final Size preferredSize;

  MyAppBar({
    Key? key,
    this.automaticallyImplyLeading = true,
    this.actions,
    this.titleText = "",
    this.bottom,
    this.toolbarHeight,
    this.centerTitle,
    this.title,
  })  : assert(true),
        preferredSize = Size.fromHeight(toolbarHeight ??
            kToolbarHeight * 1.3 +
                ((bottom != null) ? bottom.preferredSize.height : 0.0)),
        super(key: key);

  @override
  PreferredSize build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: SafeArea(
        child: Container(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: AppBar(
              automaticallyImplyLeading: automaticallyImplyLeading,
              centerTitle: centerTitle,
              toolbarHeight: toolbarHeight,
              backgroundColor: Colors.amber[50],
              iconTheme:
                  Theme.of(context).iconTheme.copyWith(color: kAccentColor),
              titleTextStyle: const TextStyle(
                color: kAccentColor,
              ) /* Theme.of(context)
                  .textTheme
                  .headline6
                  .copyWith() */
              ,
              elevation: 0,
              actions: actions,
              // ignore: prefer_if_null_operators
              title: title == null
                  ? Text(
                      titleText,
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(color: kAccentColor, fontSize: 17),
                    )
                  : title,
              bottom: bottom,
              shape: const RoundedRectangleBorder(
                  side: BorderSide(width: 1.5, color: kPrimaryColor),
                  borderRadius: BorderRadius.all(Radius.circular(10))), /**/
            ),
          ),
        ),
      ),
    );
  }
}
