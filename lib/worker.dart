import 'package:geolocator/geolocator.dart';
import 'package:workmanager/workmanager.dart';
/*
var locationSettings = AndroidSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: 100,
    forceLocationManager: true,
    intervalDuration: const Duration(seconds: 60),
    foregroundNotificationConfig: const ForegroundNotificationConfig(
      notificationText:
      "Thermostat app will continue to receive your location even when you aren't using it",
      notificationTitle: "Running in Background",
      enableWakeLock: true,
    )
);

@pragma('vm:entry-point')
void geolocation() {
  Workmanager().executeTask((task, inputData) async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition(
      locationSettings: locationSettings
    );

    print("Lat: ${position.latitude}, Lng: ${position.longitude}");


    return Future.value(true);
  });
}*/