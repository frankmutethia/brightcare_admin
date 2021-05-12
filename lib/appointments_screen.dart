import 'dart:core';

import 'package:brightcare_admin/appointments.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:cloud_firestore/cloud_firestore.dart';

class AppointmentsScreen extends StatefulWidget {
  static final String id = "Appointments";
  AppointmentsScreen({Key key}) : super(key: key);
  _AppointmentsScreenState createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
  List<charts.Series<Appointments, String>> _seriesBarData;
  List<Appointments> mydata;
  _generateData(mydata) {
    _seriesBarData = <charts.Series<Appointments, String>>[];
    _seriesBarData.add(
      charts.Series(
        domainFn: (Appointments appointments, _) => appointments.name,
        measureFn: (Appointments appointments, _) =>
            appointments.appointmentsVal,
        colorFn: (Appointments appointments, _) =>
            charts.ColorUtil.fromDartColor(
                Color(int.parse(appointments.colorVal))),
        id: 'Appointments',
        data: mydata,
        labelAccessorFn: (Appointments row, _) => "${row.appointmentsYear}",
      ),
    );
  }
  // List<charts.Series<Appointments, String>> _seriesBarData;
  // List<Appointments> myData;
  // _generateData(myData) {
  //   _seriesBarData.add(charts.Series(
  //       domainFn: (Appointments appointments, _) =>
  //           appointments.appointmentsYear.toString(),
  //       measureFn: (Appointments appointments, _) =>
  //           appointments.appointmentsVal,
  //       colorFn: (Appointments appointments, _) =>
  //           charts.ColorUtil.fromDartColor(
  //               Color(int.parse(appointments.colorVal))),
  //       id: 'Appointments',
  //       data: myData,
  //       labelAccessorFn: (Appointments row, _) => "${row.appointmentsYear}"));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Appointments'),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('appointments').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return LinearProgressIndicator();
        } else {
          List<Appointments> appointments = snapshot.data.documents
              .map((documentSnapshot) =>
                  Appointments.fromMap(documentSnapshot.data))
              .toList();
          return _buildChart(context, appointments);
        }
      },
    );
  }

  Widget _buildChart(BuildContext context, List<Appointments> appointments) {
    mydata = appointments; // my data creates the data used to build the charts
    _generateData(mydata);
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(
          child: Center(
              child: Column(
        children: <Widget>[
          Text(
            'Appointments',
            style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10.0),
          Expanded(
              child: charts.BarChart(_seriesBarData,
                  animate: true,
                  animationDuration: Duration(seconds: 5),
                  behaviors: [
                charts.DatumLegend(
                  entryTextStyle: charts.TextStyleSpec(
                    color: charts.MaterialPalette.purple.shadeDefault,
                    fontFamily: 'Georgia',
                    fontSize: 24,
                  ),
                )
              ]))
        ],
      ))),
    );
  }
}
