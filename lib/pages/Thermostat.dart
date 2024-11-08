import 'dart:async';
import 'dart:convert';
import 'package:fluthermostat/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Thermostat extends StatefulWidget {

  Thermostat({super.key});

  @override
  State<StatefulWidget> createState() => _ThermostatPage();

}

class _ThermostatPage  extends State<Thermostat>{
  int targetTemp = 10;
  String externalTemp = "0.00";
  String roomTemp = "0.00";
  Timer? timer;

  _ThermostatPage(){
    getDesiredValue();
    refreshThermostateStatus();
  }


  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 5), (Timer t) => refreshThermostateStatus());
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void getDesiredValue() async {
    final url = Uri.parse("${Preferences.baseUrl}/temperature");
    final response = await http.get(url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': Preferences.bearer,
        });
    setState(() {
      if (response.statusCode == 200) {
        targetTemp = (jsonDecode(response.body)['value']['temp']/100).round();
      }
    });
  }

  void increase() async {
    final url = Uri.parse("${Preferences.baseUrl}/temperature/increment");
    final response = await http.put(url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': Preferences.bearer,
        },
        body: jsonEncode(<String, int> {
          "temperature": 100,
        }));
    if (response.statusCode == 200) {
      getDesiredValue();
      setState(() {
        targetTemp++;
      });
    }
  }

  void decrease() async {
    final url = Uri.parse("${Preferences.baseUrl}/temperature/decrement");
    final response = await http.put(url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': Preferences.bearer,
        },
        body: jsonEncode(<String, int> {
          "temperature": 100,
        }));
    if (response.statusCode == 200) {
      getDesiredValue();
      setState(() {
        targetTemp--;
      });
    }
  }

  void refreshThermostateStatus() async {
    final url = Uri.parse("${Preferences.baseUrl}/status");
    final response = await http.get(url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': Preferences.bearer,
        });
    setState(() {
      if (response.statusCode == 200) {
        String tempStr = jsonDecode(response.body)['value']['roomTemperature']['temp'].toString();
        roomTemp = "${tempStr.substring(0, tempStr.length - 2)}.${tempStr.substring(tempStr.length - 2)}";
        targetTemp = (jsonDecode(response.body)['value']['targetTemperature']['temp'] / 100).toInt();
        externalTemp = jsonDecode(response.body)['value']['externalTemperature']['temp'].toString();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(10),
          child: Text("Temp: ${roomTemp}C",
            style: const TextStyle(color: Colors.black, fontFamily: 'Digital'),),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Text("External temp: ${externalTemp}C",
            style: const TextStyle(color: Colors.black, fontFamily: 'Digital'),),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              onPressed: increase,
              child: const Text(
                '+',
                style: TextStyle(color: Colors.black, fontFamily: 'Digital', fontSize: 200),
              ),
            ),
            Text(
                "$targetTemp",
                key: const Key("textKey"),
                style: const TextStyle(color: Colors.black, fontFamily: 'Digital', fontSize: 200)),
            TextButton(
              onPressed: decrease,
              child: const Text(
                '-',
                style: TextStyle(color: Colors.black, fontFamily: 'Digital', fontSize: 200),
              ),
            ),
          ],
        )
      ],
    );
  }
}