import 'package:flutter/services.dart';

import '../../constants/constants.dart';
import 'package:flutter/material.dart';

class MyRoundedTextField extends StatelessWidget {
  final bool filled;
  final String? label;
  final void Function(String)? onChanged;
  final Function()? onTap;
  final Widget? prefixIcon, suffixIcon;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final bool obscureText;

  final bool  enableSuggestions;

  final bool autocorrect;

  const MyRoundedTextField(
      {Key? key,
      this.filled = false,
      this.enableSuggestions = true,
      this.obscureText = false,
      this.autocorrect = false,
      this.label,
      this.onChanged,
      this.onTap,
      this.prefixIcon,
      this.suffixIcon,
      this.controller,
      this.keyboardType,
      this.validator,
      this.inputFormatters})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: SizedBox(
        width: widthButton(context),
        child: TextFormField(
          key: key,
          controller: controller,
          onChanged: onChanged,
          onTap: onTap,
          obscureText: obscureText,
          autocorrect: autocorrect,
          enableSuggestions: enableSuggestions,
          inputFormatters: inputFormatters,
          validator: validator,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(left: 20),
            filled: filled,
            fillColor: kPrimaryLightColor,
            labelText: label,
            prefixIcon: prefixIcon,
            
           suffixIcon: suffixIcon,
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(29)),
            ),
          ),
        ),
      ),
    );
  }
}
