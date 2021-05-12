// import 'package:msafiri_admin/models/warehouse_chart.dart';
import 'package:brightcare_admin/models/warehouse_chart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class ChartHome extends StatefulWidget {
  static final String id = "Chart";
  @override
  _ChartHomeState createState() => _ChartHomeState();
}

class _ChartHomeState extends State<ChartHome> {
  List<charts.Series<Warehouse, String>> _seriesBarData;
  List<Warehouse> mydata;
  _generateData(mydata) {
    _seriesBarData = <charts.Series<Warehouse, String>>[];
    _seriesBarData.add(
      charts.Series(
        domainFn: (Warehouse warehouse, _) => warehouse.warehouseName,
        measureFn: (Warehouse warehouse, _) => warehouse.warehouseVal,
        colorFn: (Warehouse warehouse, _) => charts.ColorUtil.fromDartColor(
            Color(int.parse(warehouse.colorVal))),
        id: 'Warehouse',
        data: mydata,
        labelAccessorFn: (Warehouse row, _) => "${row.saleYear}",
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Report')),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('bookings').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return LinearProgressIndicator();
        } else {
          List<Warehouse> warehouse = snapshot.data.documents
              .map((documentSnapshot) =>
                  Warehouse.fromMap(documentSnapshot.data))
              .toList();
          return _buildChart(context, warehouse);
        }
      },
    );
  }

  Widget _buildChart(BuildContext context, List<Warehouse> warehousedata) {
    mydata = warehousedata;
    _generateData(mydata);
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              Text(
                'Number of Bookings',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10.0,
              ),
              Expanded(
                child: charts.BarChart(
                  _seriesBarData,
                  animate: true,
                  animationDuration: Duration(seconds: 5),
                  behaviors: [
                    new charts.DatumLegend(
                      entryTextStyle: charts.TextStyleSpec(
                          color: charts.MaterialPalette.purple.shadeDefault,
                          fontFamily: 'Georgia',
                          fontSize: 18),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
