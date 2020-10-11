import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';

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
  var _airlyIdController = TextEditingController();
  _EditStopsState() {
    model = getIt.get<AppModel>();
    _airlyIdController.text = "${model.installation.id}";
  }

  updateInstallation(Installation instalation) {
    setState(() {
      this.model.installation = instalation;
    });
  }

  Function() showAirlyDialog(BuildContext context) {
    return () {
      showDialog(
          context: context,
          builder: (context) {
            _airlyIdController.value =
                TextEditingValue(text: "${this.model.installation.id}");
            airlyError = null;
            return StatefulBuilder(builder: (context, setState) {
              return AlertDialog(
                title: Text("Edit installation"),
                actions: [
                  OutlineButton(
                      onPressed: () {
                        requestPermission().then((permisions) {
                          getCurrentPosition(
                                  desiredAccuracy: LocationAccuracy.medium)
                              .then((location) {
                            this
                                .model
                                .stub
                                .getAirlyInstallation(InstallationLocation()
                                  ..latitude = location.latitude
                                  ..longitude = location.longitude)
                                .then((installation) {
                              updateInstallation(installation);
                              this.model.saveInstallation();
                              Navigator.of(context).pop();
                            });
                          });
                        });
                      },
                      child: Text("FIND NEAREST")),
                  OutlineButton(
                      onPressed: () {
                        final installation = Installation()
                          ..id = int.tryParse(_airlyIdController.value.text);
                        this.model.fetchAirly(installation).then((airly) {
                          updateInstallation(installation);
                          this.model.airly = airly;
                          this.model.saveInstallation();
                          this.model.airlyUpdatedCallback();
                          Navigator.of(context).pop();
                        }, onError: (error) {
                          setState(() {
                            airlyError = "Bad installation id";
                          });
                        });
                      },
                      child: Text("ACCEPT")),
                ],
                content: TextField(
                  keyboardType: TextInputType.number,
                  controller: _airlyIdController,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                      errorStyle: TextStyle(), errorText: airlyError),
                ),
              );
            });
          });
    };
  }

  @override
  Widget build(BuildContext context) {
    var scaf = Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text("KrkStops"),
        ),
        body: Container(
            padding: EdgeInsets.all(4),
            child: Column(children: [
              Card(
                  elevation: 2,
                  child: Row(children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(12),
                        child: Text(
                          "Airly Installation: ${this.model.installation.id}",
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                    ),
                    IconButton(
                        icon: Icon(Icons.edit),
                        tooltip: 'Edit installation',
                        onPressed: showAirlyDialog(context)),
                  ])), // Expanded()
              Expanded(
                  child: Card(
                      elevation: 2,
                      child: ReorderableListView(
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
                              final Stop removed =
                                  model.savedStops.removeAt(oldIndex);
                              model.savedStops.insert(newIndex, removed);
                            });
                            model.saveStops(this.model.savedStops);
                            model.stopsUpdatedCallback();
                          })))
            ])));
    return scaf;
  }
}
