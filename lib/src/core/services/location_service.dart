import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class LocationData {
  final double latitude;
  final double longitude;
  final String address;

  LocationData({
    required this.latitude,
    required this.longitude,
    required this.address,
  });

  @override
  String toString() => 'LocationData(lat: $latitude, lon: $longitude, address: $address)';
}

class LocationService {
  /// Internal helper to check and request permissions
  Future<bool> _handlePermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the 
      // App to enable the location services.
      return false;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale 
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return false;
      }
    }
    
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately. 
      return false;
    } 

    return true;
  }

  /// Get current coordinates
  Future<Position?> getCurrentPosition() async {
    try {
      final hasPermission = await _handlePermission();
      if (!hasPermission) {
        print('Location permission denied.');
        return null;
      }

      return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: const Duration(seconds: 15),
      );
    } catch (e) {
      print('Error getting current position: $e');
      return null;
    }
  }

  /// Get reverse geocoded address
  Future<String> getAddressFromLatLng(double lat, double lng) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        
        // Construct a readable address
        final addressParts = [
          if (place.name != null && place.name != place.subLocality) place.name,
          if (place.subLocality != null && place.subLocality!.isNotEmpty) place.subLocality,
          if (place.locality != null && place.locality!.isNotEmpty) place.locality,
          if (place.administrativeArea != null && place.administrativeArea!.isNotEmpty) place.administrativeArea,
          if (place.country != null && place.country!.isNotEmpty) place.country,
        ];
        
        return addressParts.where((s) => s != null).join(', ');
      }
    } catch (e) {
      print('Error getting address from coordinates ($lat, $lng): $e');
    }
    return "Unknown Address";
  }

  /// Get both coordinates and address in one call
  Future<LocationData?> getLocationData() async {
    final position = await getCurrentPosition();
    if (position == null) return null;

    final address = await getAddressFromLatLng(position.latitude, position.longitude);
    
    return LocationData(
      latitude: position.latitude,
      longitude: position.longitude,
      address: address,
    );
  }
}
