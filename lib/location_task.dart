import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import 'main.dart';

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

void startBackgroundTask() {
  FlutterForegroundTask.startService(
    notificationTitle: 'Foreground Task',
    notificationText: 'Running...',
    callback: backgroundTask,
  );
}

Timer? _timer;

Future<Response> informBackground(double latitude, double longitude) {
  print("Lat: ${latitude}, Lng: ${longitude}");
  final url = Uri.parse("${Preferences.baseUrl}/geolocation");
  try {
    return http.put(url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': Preferences.bearer,
        },
        body: jsonEncode(<String, String>{
          "userId": Preferences.userId,
          "latitude": latitude.toString(),
          "longitude": longitude.toString(),
        }));
  } catch(exception) {
    print("cannot save location $exception");
    return Future.error(exception);
  }
}

void backgroundTask() async {
  // Aquí va tu lógica, por ejemplo:
    _timer?.cancel();
    WidgetsFlutterBinding.ensureInitialized();
    _timer = Timer.periodic(Duration(seconds: 5), (timer) async {
      // Lógica de tu tarea aquí
      try {
        bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

        if (!serviceEnabled) {
          return;
        }

        LocationPermission permission = await Geolocator.checkPermission();
        if (permission == LocationPermission.denied) {
          permission = await Geolocator.requestPermission();
          if (permission == LocationPermission.denied) {
            return;
          }
        }

        if (permission == LocationPermission.deniedForever) {
          return;
        }

        Position position = await Geolocator.getCurrentPosition(
            locationSettings: locationSettings
        );

        var f = await informBackground(position.latitude, position.longitude);
      } catch (e) {
        print("Error al verificar los servicios de ubicación: $e");
      }
    });
}
