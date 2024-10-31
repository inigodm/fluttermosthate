import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> requestPermissions(BuildContext context) async {
  Map<Permission, PermissionStatus> statuses = await [
    Permission.locationAlways,
    Permission.locationWhenInUse,
    Permission.storage,
    Permission.location,
    Permission.backgroundRefresh
  ].request();
  if (statuses[Permission.location] == PermissionStatus.permanentlyDenied ||
      statuses[Permission.locationWhenInUse] == PermissionStatus.permanentlyDenied ||
      statuses[Permission.locationAlways] == PermissionStatus.permanentlyDenied ||
      //statuses[Permission.backgroundRefresh] == PermissionStatus.permanentlyDenied ||
      //statuses[Permission.storage] == PermissionStatus.permanentlyDenied ||
      statuses[Permission.location] == PermissionStatus.denied ||
      statuses[Permission.locationWhenInUse] == PermissionStatus.denied ||
      //statuses[Permission.storage] == PermissionStatus.denied  ||
      //statuses[Permission.backgroundRefresh] == PermissionStatus.denied ||
      statuses[Permission.locationAlways] == PermissionStatus.denied) {
    _showAlertDialog(context);
  }
}

void _showAlertDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Permissions"),
        content: Text("Location and storage permissions are needed"),
        actions: <Widget>[
          TextButton(
            child: Text("Cancelar"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text("Aceptar"),
            onPressed: () {
              Navigator.of(context).pop();
              openAppSettings();
            },
          ),
        ],
      );
    },
  );
}