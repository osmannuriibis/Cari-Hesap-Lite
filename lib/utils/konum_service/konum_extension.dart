import 'package:cari_hesapp_lite/models/konum.dart';
import 'package:geolocator/geolocator.dart';

extension KonumExtension on Position {
  Konum get asKonum {
    return Konum(
      latitude: this.latitude,
      longitude: this.longitude,
      isCertain:false
    );
  }
}
