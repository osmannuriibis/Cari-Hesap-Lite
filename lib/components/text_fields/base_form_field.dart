import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BaseFormField extends StatelessWidget {
  final String? initialValue, labelText, hintText;
  final bool? enabled;
  final bool readOnly;
  final int? maxLength;
  final void Function()? onTap;
  final void Function(String?)? onChanged;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator, onFieldSubmitted;
  final void Function()? onEditingComplete;
  final TextEditingController? controller;
  final InputBorder? border;
  final TextSelectionControls? selectionControls;
  final TextAlign textAlign;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final FocusNode? focusNode;
  final Widget? suffix;
  final Widget? suffixIcon;
  final Widget? icon;
  final String? suffixText;

  final EdgeInsetsGeometry padding;

  final TextStyle? style;

  const BaseFormField(
      {Key? key,
      this.initialValue,
      this.labelText,
      this.hintText,
      this.readOnly = false,
      this.onTap,
      this.controller,
      this.onChanged,
      this.border = const OutlineInputBorder(),
      this.selectionControls,
      this.textAlign = TextAlign.left,
      this.onSaved,
      this.validator,
      this.onFieldSubmitted,
      this.inputFormatters,
      this.keyboardType,
      this.onEditingComplete,
      this.focusNode,
      this.enabled,
      this.padding = const EdgeInsets.all(8.0),
      this.maxLength,
      this.suffix,
      this.suffixIcon,
      this.suffixText,
      this.style,
      this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: TextFormField(
        focusNode: focusNode,
        style: style,
        maxLength: maxLength,
        onEditingComplete: onEditingComplete,
        inputFormatters: inputFormatters,
        selectionControls: selectionControls,
        textAlign: textAlign,
        onChanged: onChanged,
        onSaved: onSaved,
        enabled: enabled,
        keyboardType: keyboardType,
        controller: controller,
        onFieldSubmitted: onFieldSubmitted,
        onTap: onTap,
        validator: validator,
        readOnly: readOnly,
        initialValue: initialValue,
        decoration: InputDecoration(
            border: border,
            isDense: true,
           
            suffixIcon: suffixIcon,
            icon: icon,
            suffix: suffix,
            suffixText: suffixText,
            //   suffixIconConstraints: BoxConstraints.loose(Size.square(48)),
            labelText: labelText,
            hintText: hintText),
      ),
    );
  }
}
