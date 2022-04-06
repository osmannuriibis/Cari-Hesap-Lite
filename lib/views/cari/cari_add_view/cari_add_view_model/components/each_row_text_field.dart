import 'package:cari_hesapp_lite/components/text_fields/base_bordered_text_field.dart';
import 'package:cari_hesapp_lite/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RowTextFieldWithEndIcon extends StatelessWidget {
  final String? labelText;

  final TextEditingController? controller;

  final String? hintText;

  final TextInputType? keyboardType;

  final VoidCallback? onTap;

  final bool readOnly, divider;

  final void Function(String?)? onChanged;

  final List<TextInputFormatter>? inputFormatters;

  final Widget? endIcon;

  final VoidCallback? endIconPressed;

  final Color endIconColor;

  final String? Function(String?)? validator;

  final bool selectTextWithTap;

  RowTextFieldWithEndIcon(
      {this.labelText,
      this.controller,
      this.hintText,
      this.keyboardType,
      this.onTap,
      this.readOnly = false,
      this.onChanged,
      this.inputFormatters,
      this.endIcon,
      this.endIconPressed,
      this.validator,
      this.selectTextWithTap = false,
      this.endIconColor = Colors.black54,
      this.divider = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: BaseBorderedTextField(
                labelText: labelText,
                controller: controller,
                hintText: hintText,
                keyboardType: keyboardType,
                onTap: onTap,
                readOnly: readOnly,
                selectTextWithTap: selectTextWithTap,
                onChanged: onChanged,
                inputFormatters: inputFormatters,
                validator: validator,
                divider: endIcon == null,
              ),
            ),
            (endIcon != null)
                ? IconButton(
                    padding:
                        EdgeInsets.only(top: 5, bottom: 5, left: 7, right: 20),
                    icon: endIcon!,
                    onPressed: endIconPressed,
                    color: endIconColor)
                : SizedBox.shrink(),
          ],
        ),
        endIcon != null ? Divider() : SizedBox.shrink()
      ],
    );
  }
}
