import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

Future<String> scanBarcode() async {
  return FlutterBarcodeScanner.scanBarcode(
      "#FFA444", "İptal", true, ScanMode.BARCODE);
}
