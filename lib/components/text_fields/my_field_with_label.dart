import 'package:cari_hesapp_lite/constants/constants.dart';
import 'package:cari_hesapp_lite/utils/num_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'base_form_field.dart';
class EachRowField extends StatelessWidget {
  final String textLabel;
  final String? hintText, initialText;
  final bool readOnly, absorbing;
  final void Function()? onTap;
  final void Function(String?)? onChange;
  final void Function(String?)? onSaved;
  final String? Function(String?)? onFieldSubmitted;
  final void Function()? onEditingComplete;
  final String? Function(String?)? validator;
  final TextEditingController? controller;

  final TextInputFormatter? inputFormatters;
  final FocusNode? focusNode;
  final String? suffixText;
  final int fieldRatio ;

  final defaultInputFormatters = [
    FilteringTextInputFormatter.digitsOnly,
    FilteringTextInputFormatter.allow(".")
  ];

  EachRowField({
    Key? key,
    required this.textLabel,
    this.hintText,
    this.initialText,
    this.readOnly = false,
    this.onTap,
    this.onChange,
    this.controller,
    this.onSaved,
    this.onFieldSubmitted,
    this.inputFormatters,
    this.onEditingComplete,
    this.focusNode,
    this.validator,
    this.fieldRatio =20,
    this.suffixText,
    this.absorbing = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: absorbing,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Column(
          children: [
            Flex(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              direction: Axis.horizontal,
              children: [
                Flexible(
                  flex: 10,
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      textLabel + ":",
                      style: const TextStyle(
                        fontSize: 17,
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: fieldRatio,
                  child: SizedBox(
                    width: width(context) / 2,
                    child: BaseFormField(
                      inputFormatters: [
                        //FilteringTextInputFormatter(RegExp(r'[0-9.]'),      allow: true),
                        DecimalTextInputFormatter()
                      ],
                      keyboardType: TextInputType.phone,
                      onFieldSubmitted: onFieldSubmitted,
                      onSaved: onSaved,
                      validator: validator,
                      focusNode: focusNode,
                      onEditingComplete: onEditingComplete,
                      textAlign: TextAlign.right,
                      selectionControls: materialTextSelectionControls,
                      controller: controller,
                      hintText: hintText,
                      initialValue: initialText,
                      onChanged: onChange,
                      onTap: onTap,
                      suffixText: suffixText,
                      readOnly: readOnly,
                      key: key,
                    ),
                  ),
                ),
              ],
            ),
            const Divider(
              height: 5,
            )
          ],
        ),
      ),
    );
  }
}