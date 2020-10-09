import 'package:flutter/material.dart';

import 'grpc/krk-stops.pbgrpc.dart';


class EditStopsPage extends StatefulWidget {
  static const routeName = '/departures';
  final KrkStopsClient stub;
  EditStopsPage(this.stub);
  @override
  _EditStopsState createState() => _EditStopsState(this.stub);
}

class _EditStopsState extends State<EditStopsPage> {
  KrkStopsClient stub;
  _EditStopsState(this.stub);

  @override
  Widget build(BuildContext context) {
    var scaf = Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("KrkStops"),
      ),);
  return scaf;
  }
}
