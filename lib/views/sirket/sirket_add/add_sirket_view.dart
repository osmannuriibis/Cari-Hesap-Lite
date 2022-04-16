import '../../../components/appbar/my_app_bar.dart';
import '../../../components/buttons/rounded_button.dart';
import '../../../components/text_fields/base_bordered_text_field.dart';
import '../../../utils/validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'add_sirket_view.model.dart';

class SirketAddView extends StatelessWidget with Validator {
  const SirketAddView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _viewModel = Provider.of<SirketAddViewModel>(context);
    var _viewModelUnlistened =
        Provider.of<SirketAddViewModel>(context, listen: false);
    return Scaffold(
      appBar: MyAppBar(
        titleText: "Şirket Bilgileri",
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              _viewModel.basbas();
            },
          )
        ],
      ),
      body: Form(
        key: _viewModel.formKey,
        child: _buildBody(context, _viewModel, _viewModelUnlistened),
      ),
    );
  }

  Widget _buildBody(BuildContext context, SirketAddViewModel viewModel,
      SirketAddViewModel viewModelUnlistened) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          const Divider(),
          BaseBorderedTextField(
            controller: viewModel.controllerUnvani,
            labelText: "Unvanı",
            hintText: "Şirketinizin Unvanı",
            onChanged: (veri) {
              viewModel.formKey.currentState!.validate();
            },
            validator: cokKisaOldu,
          ),
          BaseBorderedTextField(
            controller: viewModel.controllerTicariAdi,
            labelText: "Ticari Adı",
            hintText: "Son Durak Paz Ltd Şti...",
          ),
          BaseBorderedTextField(
            controller: viewModel.controllerTel,
            endIcon: const Icon(Icons.add),
            endIconColor: Colors.black87,
            //   endIconPressed: addNewPhoneFiled,
            labelText: "Telefon",
            hintText: "05..",
          ),
          /*    ...getExtraPhoneField ??
              [
                SizedBox(
                  height: 1,
                )
              ], */
          BaseBorderedTextField(
            controller: viewModel.controllerEmail,
            labelText: "Email",
            hintText: "ornek@firma.com.tr",
          ),
          BaseBorderedTextField(
            controller: viewModel.controllerAdres,
            labelText: "Adres",
            hintText: "",
          ),
          BaseBorderedTextField(
            controller: viewModel.controllerSehir,
            labelText: "Şehir",
            hintText: "İstanbul",
          ),
          BaseBorderedTextField(
            controller: viewModel.controllerIlce,
            labelText: "İlçe",
            hintText: "Bayrampaşa",
          ),
          BaseBorderedTextField(
            controller: viewModel.controllerVDairesi,
            labelText: "Vergi Dairesi",
            hintText: "Sapanca VD..",
          ),
          BaseBorderedTextField(
            controller: viewModel.controllerVNo,
            labelText: "Vergi Numarası",
            hintText: "123456..",
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RoundedButton(
              "Kaydet",
              onPressed: () {
                save(context, viewModelUnlistened);
              },
            ),
          ),
        ],
      ),
    );
  }

  void save(BuildContext context, SirketAddViewModel viewModelUnlistened) {
    viewModelUnlistened.save().then((value) {
      Navigator.of(context).popAndPushNamed(
        "/",
        result: value,
      );
    });
  }

  /* addNewPhoneFiled() {
    setState(() {
      getExtraPhoneField.add(BaseBorderedTextField(
        labelText: ("Telefon " + (getExtraPhoneField.length + 2).toString()),
        onSaved:  _viewModel.onSavedTelNo,
      ));
    });
  } */
}
