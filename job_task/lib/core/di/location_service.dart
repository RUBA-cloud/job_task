

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {

  Future<Map<String, dynamic>> getCurrentLocation() async {

    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      throw Exception("Location service disabled");
    }


    LocationPermission permission =
    await Geolocator.checkPermission();


    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }


    if (permission == LocationPermission.deniedForever) {
      throw Exception("Location permission denied");
    }


    final position = await Geolocator.getCurrentPosition();


    final placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );


    final place = placemarks.first;


    return {
      "latitude": position.latitude,
      "longitude": position.longitude,
      "country": place.country ?? "",
      "city": place.locality ?? "",
    };
  }
}