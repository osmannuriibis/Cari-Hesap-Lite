import 'dart:math';

import 'package:cari_hesapp_lite/models/konum.dart';

num getDistance(Konum main, Konum other) {
  var latDif = main.latitude ?? 0 - (other.latitude ?? 0);
  var lonDif = (main.longitude ?? 0)- (other.longitude ?? 0);
  return sqrt( pow(latDif, 2) + pow(lonDif, 2)  );
}
