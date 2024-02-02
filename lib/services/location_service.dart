import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  Future<Placemark?> getLocationName(Position? position) async {
    if (position != null) {
      try {
        final placeMarks = await placemarkFromCoordinates(
            position.latitude, position.longitude);
            if(placeMarks.isNotEmpty){
              return placeMarks[0];
            }
      } catch (e) {
        "error";
      }
    }
    return null;
  }

}
