import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> requestPermissions(BuildContext context) async {
  Map<Permission, PermissionStatus> statuses = await [
    Permission.locationAlways,
    Permission.storage,
  ].request();
  if (statuses[Permission.location] == PermissionStatus.permanentlyDenied ||
      statuses[Permission.storage] == PermissionStatus.permanentlyDenied) {
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