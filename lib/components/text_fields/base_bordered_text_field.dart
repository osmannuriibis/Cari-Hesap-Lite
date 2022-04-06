
import '../../utils/general.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BaseBorderedTextField extends StatelessWidget {
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final String? labelText, hintText, initialValue;
  final IconData? icon;
  final Widget? endIcon;
  final VoidCallback? onTap, endIconPressed;

  /// [selectTextWithTap] should be used with controller.
  ///
  /// if [selectTextWithTap] is true then [controller] is not must be null.
  final bool selectTextWithTap;
  final bool divider;
  final bool readOnly;
  final bool? enable;
  final bool isCollapsed;
  final Color? endIconColor;
  final TextAlign? textAling;
  final TextStyle? labelStyle, style;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final int minLines, maxLines;

  final TextEditingController? controller;
  final bool border;

  final EdgeInsetsGeometry contentPadding;

  const BaseBorderedTextField(
      {Key? key,
      this.onChanged,
      this.labelText,
      this.hintText,
      this.border = true,
      this.icon,
      this.onTap,
      this.readOnly = false,
      this.endIcon,
      this.endIconPressed,
      this.controller,
      this.onSaved,
      this.initialValue,
      this.enable,
      this.validator,
      this.endIconColor,
      this.textAling = TextAlign.start,
      this.labelStyle,
      this.inputFormatters,
      this.keyboardType,
      this.selectTextWithTap = false,
      this.contentPadding =
          const EdgeInsets.symmetric(horizontal: 10, vertical: 19),
      this.isCollapsed = true,
      this.style,
      this.divider = true,
      this.minLines = 1,
      this.maxLines = 4})
      : assert(selectTextWithTap ? (controller == null ? false : true) : true),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          child: TextFormField(
            inputFormatters: inputFormatters,
            controller: controller,

            readOnly: readOnly,
            // expands: true,
            onTap: () {
              // ignore: unnecessary_statements
              selectTextWithTap ? selectTextInField(controller!) : 1 + 1;

              onTap != null ? onTap!.call() : 1 + 1;
            },
            textAlign: textAling!,
            onChanged: onChanged,
            minLines: minLines,
            maxLines: maxLines,
            onSaved: onSaved,

            initialValue: initialValue,
            enabled: enable,
            keyboardType: keyboardType,
            validator: validator,
            decoration: InputDecoration(
              contentPadding: contentPadding,
              isCollapsed: isCollapsed,
              labelStyle: labelStyle,
              hintMaxLines: 1,

              labelText: labelText,
              disabledBorder: border
                  ? const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey))
                  : null,
              hintText: hintText,
              enabledBorder: border
                  ? OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.amber.shade900))
                  : null,
              border: border ? const OutlineInputBorder() : null,
              prefixIcon: (icon != null) ? Icon(icon) : null,
              suffixIcon: (endIcon != null)
                  ? IconButton(
                      icon: endIcon!,
                      color: endIconColor,
                      onPressed: endIconPressed,
                    )
                  : null,
            ),
            style: style,
          ),
        ),
        (divider) ? const Divider() : const SizedBox.shrink(),
      ],
    );
  }
}
