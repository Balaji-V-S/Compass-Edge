import 'package:latlong2/latlong.dart';
import 'package:Compass_Edge/main.dart';

LatLng getLatLngfromSharedPreferences() {
  return LatLng(
    sharedPreferences.getDouble('lati')!,
    sharedPreferences.getDouble('longi')!,
  );
}
