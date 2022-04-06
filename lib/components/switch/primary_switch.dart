import '../../constants/constants.dart';
import 'package:flutter/material.dart';

class PrimarySwitch extends StatelessWidget {
  final void Function(bool) onChanged;
  final bool value;

  const PrimarySwitch({
    Key? key,
    required this.onChanged,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Switch(
        inactiveThumbColor: kPrimaryColor,
        activeTrackColor: kPrimaryLightColor,
        activeColor: kPrimaryColor,
        inactiveTrackColor: kPrimaryLightColor,
        value: value,
        onChanged: onChanged,
      ),
    );
  }
}
