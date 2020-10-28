import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';
import 'package:url_launcher/url_launcher.dart';

import 'grpc/krk-stops.pbgrpc.dart';
import 'model.dart';

class EditStopsPage extends StatefulWidget {
  EditStopsPage();
  @override
  _EditStopsState createState() => _EditStopsState();
}

class _EditStopsState extends State<EditStopsPage> {
  final getIt = GetIt.instance;
  AppModel model;
  String airlyError;
  _EditStopsState() {
    model = getIt.get<AppModel>();
  }

  @override
  Widget build(BuildContext context) {
    var scaf = Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text("KrkStops"),
        ),
        body: ReorderableListView(
            children: model.savedStops
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
                final Stop removed = model.savedStops.removeAt(oldIndex);
                model.savedStops.insert(newIndex, removed);
              });
              model.saveStops(this.model.savedStops);
            }));
    return scaf;
  }
}
