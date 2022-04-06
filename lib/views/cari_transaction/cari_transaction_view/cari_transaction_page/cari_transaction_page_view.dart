import '../../../../models/cari_islem.dart';
import 'package:flutter/material.dart';

class CariIslemHomeView extends StatelessWidget {
  final CariIslemModel _model;

  CariIslemHomeView(this._model);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_model.cariUnvani ?? "null"),
      ),
      body: Container(),
    );
  }
}
