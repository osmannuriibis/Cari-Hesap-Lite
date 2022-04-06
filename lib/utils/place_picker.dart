import 'package:cari_hesapp_lite/utils/place_picker_package/lib/entities/localization_item.dart';
import 'package:flutter/material.dart';

import 'api_keys.dart';
import 'konum_service/konum_service.dart';
import 'place_picker_package/lib/widgets/place_picker.dart';

PlacePicker showPlacePicker({String initialSearchWord = ""}) {
  return PlacePicker(
    ApiKeys.googleMapApiKey,
    initialSearchWord: initialSearchWord,
    localizationItem: LocalizationItem(
      languageCode: "tr",
      findingPlace: "Yer Aranıyor...",
      nearBy: "Yakın Sonuçlar",
      noResultsFound: "Sonuç Bulunamadı",
      tapToSelectLocation: "Seçmek için dokununuz",
      unnamedLocation: "Belirtilmemiş yer",
    ),
    displayLocation: KonumService().lastLocation != null
        ? KonumService().lastLocation.getLatLng
        : null,
  );
}
