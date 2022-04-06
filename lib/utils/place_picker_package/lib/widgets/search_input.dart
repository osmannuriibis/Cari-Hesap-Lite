import 'dart:async';

import 'package:cari_hesapp_lite/constants/constants.dart';
import 'package:cari_hesapp_lite/utils/print.dart';
import 'package:flutter/material.dart';

/// Custom Search input field, showing the search and clear icons.
class SearchInput extends StatefulWidget {
  final ValueChanged<String> onSearchInput;

  String? initialSearchWord;
  String hintText;

  VoidCallback? leadIconPressed;
  IconData leadIcon;

  SearchInput(this.onSearchInput,
      {this.initialSearchWord,
      this.hintText = "Arayınız..",
      this.leadIconPressed,
      this.leadIcon = Icons.search});

  @override
  State<StatefulWidget> createState() => SearchInputState();
}

class SearchInputState extends State<SearchInput> {
  TextEditingController editController = TextEditingController();

  Timer? debouncer;

  bool hasSearchEntry = false;

  String? get stringComes => widget.initialSearchWord;

  SearchInputState();

  @override
  void initState() {
    super.initState();
    this.editController.addListener(this.onSearchInputChange);
    bas("stringComes");
    bas(stringComes);
    if (stringComes != null) editController.text = stringComes!;
  }

  @override
  void dispose() {
    this.editController.removeListener(this.onSearchInputChange);
    this.editController.dispose();

    super.dispose();
  }

  void onSearchInputChange() {
    if (this.editController.text.isEmpty) {
      this.debouncer?.cancel();
      widget.onSearchInput(this.editController.text);
      return;
    }

    if (this.debouncer?.isActive ?? false) {
      this.debouncer?.cancel();
    }

    this.debouncer = Timer(Duration(milliseconds: 500), () {
      widget.onSearchInput(this.editController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kToolbarHeight * 0.85,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: <Widget>[
          GestureDetector(
            onTap: widget.leadIconPressed,
            child: Icon(widget.leadIcon,
                color: Theme.of(context).textTheme.bodyText1!.color),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                  hintText: widget.hintText, border: InputBorder.none),
              controller: this.editController,
              onChanged: (value) {
                setState(() {
                  this.hasSearchEntry = value.isNotEmpty;
                });
              },
            ),
          ),
          const SizedBox(width: 8),
          if (this.hasSearchEntry)
            GestureDetector(
              child: const Icon(Icons.clear),
              onTap: () {
                this.editController.clear();
                setState(() {
                  this.hasSearchEntry = false;
                });
              },
            ),
        ],
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: kPrimaryLightColor),
        color: Theme.of(context).canvasColor,
      ),
    );
  }
}
