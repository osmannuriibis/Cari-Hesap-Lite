import 'package:cari_hesapp_lite/components/card/custom_card.dart';
import 'package:flutter/material.dart';

class AccountListTile extends StatelessWidget {
  final int? index;

  final Color color;
  final String? hesapAdi;
  final num? bakiye;
  final Function()? onTap;

  const AccountListTile(
      {Key? key,
      this.index,
      this.color = Colors.cyan,
      this.hesapAdi,
      this.bakiye,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyCard(
      aspectRatio: 3,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
      borderRadius: 20,
      onTap: onTap,
      backgroundColor: color,
      child: Stack(
        children: [
          Positioned(
              child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: const AssetImage("assets/images/login_bottom.png"),
                    colorFilter: ColorFilter.mode(color, BlendMode.colorBurn),
                    fit: BoxFit.fill,
                    alignment: Alignment.centerRight)),
          )),
          Center(
            child: Text(hesapAdi ?? "",
                style: Theme.of(context).textTheme.headline5),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: bakiye != null
                  ? Text("Bakiye: ${bakiye?.toStringAsFixed(2)} ",
                      style: Theme.of(context).textTheme.bodyText2)
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}
