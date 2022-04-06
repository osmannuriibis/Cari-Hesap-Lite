import 'package:flutter/material.dart';

class BaseBorderedDropdownBtnFormField<T> extends StatelessWidget {
  final T? value;

  final ValueChanged<T?>? onChanged;

  final List<DropdownMenuItem<T>>? items;

  final FormFieldValidator<T>? validator;

  final String? hintText;

  final EdgeInsets padding;

  const BaseBorderedDropdownBtnFormField({
    Key? key,
    this.value,
    this.onChanged,
    this.items,
    this.validator,
    this.hintText, this.padding=const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: DropdownButtonFormField<T>(
        validator: validator,
        hint: hintText != null ? Text(hintText!) : null,
        onTap: () {},
        isDense: true,
        isExpanded: true,
        value: value,
        onChanged: onChanged,
        items: items,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(13),
          disabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
          enabledBorder: OutlineInputBorder(
              //borderSide: BorderSide(color: Colors.amber[900])
              ),
          border: OutlineInputBorder(),
        ),
        /* 
        labelText: "Depo Adı",
        readOnly: true,
        controller: viewModelUnlistened.controllerMain, */
        style: Theme.of(context).textTheme.subtitle1!.copyWith(),
      ),
    );
  }
}
