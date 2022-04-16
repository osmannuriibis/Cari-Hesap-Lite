import 'dart:async';

import 'package:cari_hesapp_lite/constants/constants.dart';
import 'package:flutter/material.dart';

/// Custom Search input field, showing the search and clear icons.
class SearchInput extends StatefulWidget {
  final ValueChanged<String> onSearchInput;

  String? initialSearchWord;
  String hintText;

  VoidCallback? leadIconPressed;
  IconData leadIcon;

  final Widget hasSearchEntryIcon;

  SearchInput(this.onSearchInput,
      {Key? key,
      this.initialSearchWord,
      this.hintText = "Arayınız..",
      this.leadIconPressed,
      this.leadIcon = Icons.search,
      this.hasSearchEntryIcon = const Icon(Icons.clear)})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => SearchInputState();
}

class SearchInputState extends State<SearchInput> {
  TextEditingController editController = TextEditingController();

  Timer? debouncer;

  bool hasSearchEntry = false;

  Widget get hasSearchEntryIcon => widget.hasSearchEntryIcon;

  String? get stringComes => widget.initialSearchWord;

  SearchInputState();

  @override
  void initState() {
    super.initState();
    editController.addListener(onSearchInputChange);
    if (stringComes != null) editController.text = stringComes!;
  }

  @override
  void dispose() {
    editController.removeListener(onSearchInputChange);
    editController.dispose();

    super.dispose();
  }

  void onSearchInputChange() {
    if (editController.text.isEmpty) {
      debouncer?.cancel();
      widget.onSearchInput(editController.text);
      return;
    }

    if (debouncer?.isActive ?? false) {
      debouncer?.cancel();
    }

    debouncer = Timer(const Duration(milliseconds: 500), () {
      widget.onSearchInput(editController.text);
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
              controller: editController,
              onChanged: (value) {
                setState(() {
                  hasSearchEntry = value.isNotEmpty;
                });
              },
            ),
          ),
          const SizedBox(width: 8),
          if (hasSearchEntry)
            GestureDetector(
              child: hasSearchEntryIcon,
              onTap: () {
                editController.clear();
                setState(() {
                  hasSearchEntry = false;
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
