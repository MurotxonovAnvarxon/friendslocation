import 'app_lat_long.dart';

abstract class AppLocation {
  Future<AppLatLong> getCurrentLocation();

  Future<AppLatLong> getFriendsLocations();

  Future<bool> requestPermission();

  Future<bool> checkPermission();
}