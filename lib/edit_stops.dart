import 'package:flutter/material.dart';

import 'grpc/krk-stops.pbgrpc.dart';

class EditStopsPage extends StatefulWidget {
  final KrkStopsClient stub;
  final List<Stop> stops;
  final void Function(List<Stop>) stopsEditedCallback;
  EditStopsPage(this.stub, this.stops, this.stopsEditedCallback);
  @override
  _EditStopsState createState() => _EditStopsState(stub, stops, stopsEditedCallback);
}

class _EditStopsState extends State<EditStopsPage> {
  KrkStopsClient stub;
  List<Stop> stops;
  final Function(List<Stop>) stopsEditedCallback;
  _EditStopsState(this.stub, this.stops, this.stopsEditedCallback);

  @override
  Widget build(BuildContext context) {
    var scaf = Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text("KrkStops"),
        ),
        body: ReorderableListView(
            children: stops
                .map((e) => ListTile(
                      key: Key("${e.shortName}"),
                      title: Text("${e.name}"),
                      trailing: Icon(Icons.menu),
                    ))
                .toList(),
            onReorder: (int oldIndex, int newIndex) {
              if (oldIndex < newIndex) {
                newIndex -= 1;
              }
              setState(() {
                final Stop removed = stops.removeAt(oldIndex);
                stops.insert(newIndex, removed);
              });
              this.stopsEditedCallback(stops);
            }));
    return scaf;
  }
}
