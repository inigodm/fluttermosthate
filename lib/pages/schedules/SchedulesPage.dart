import 'package:flutter/material.dart';

import 'ScheduleList.dart';
import 'SchedulesForm.dart';
import 'listener/SchedulesSubscriber.dart';

class SchedulesPage extends StatefulWidget {
  SchedulesPage({super.key});

  @override
  State<StatefulWidget> createState() => _SchedulesPage();
}

class _SchedulesPage extends State<SchedulesPage> {
  late SchedulesForm form;
  late SchedulesList list;
  SchedulesSubscriber subscriber= SchedulesSubscriber();

  _SchedulesPage(){
    form = SchedulesForm(subscriber);
    list = SchedulesList(subscriber);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          form,
          Expanded(
            child: list
          )
        ]
    );
  }
}
