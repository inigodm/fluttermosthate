import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _MapPage();
}

class _MapPage extends State<MapPage> {
  _MapPage(){  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(title: Text('Mapa de OpenStreetMap')),
        body: FlutterMap(
          options: MapOptions(
            center: LatLng(40.7128, -74.0060), // Ajusta las coordenadas según tus necesidades
            zoom: 13.0,
          ),
          children: [
            TileLayer(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: ['a', 'b', 'c'],
            ),
            MarkerLayer(
              markers: [
                Marker(
                  width: 80.0,
                  height: 80.0,
                  point: LatLng(40.7128, -74.0060), // Inserta aquí tu latitud y longitud
                  builder: (ctx) => Container(
                    child: Icon(Icons.location_on, color: Colors.red, size: 40),
                  ),
                ),
                // Añade más marcadores si lo necesitas
              ],
            ),
          ],
        ),
      );
  }
}
