
import 'package:currency_textfield/currency_textfield.dart';

class MyCurrencyTextController extends CurrencyTextFieldController {
  String? decimalSymbl;

  String rightSymbol;

  String? thousandSymbl;
  var _asd = CurrencyTextFieldController();
  MyCurrencyTextController(
      {this.decimalSymbl, this.thousandSymbl, required this.rightSymbol})
      : super(
          decimalSymbol: decimalSymbl ?? '.',
          thousandSymbol: thousandSymbl ?? '\'',
          rightSymbol: rightSymbol,
        );
}
