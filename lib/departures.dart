import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'edit_departures.dart';
import 'grpc/krk-stops.pb.dart';
import 'grpc/krk-stops.pbgrpc.dart';
import 'model.dart';

class DeparturesPage extends StatefulWidget {
  final getIt = GetIt.instance;
  AppModel model;
  final Stop stop;
  DeparturesPage(this.stop);
  @override
  _DeparturesPageState createState() => _DeparturesPageState(this.stop);
}

class _DeparturesPageState extends State<DeparturesPage> {
  final getIt = GetIt.instance;
  AppModel model;
  Stop stop;
  int departuresIndex = 0;
  bool isSaved;
  Completer fetchedDepartures = new Completer();
  _DeparturesPageState(this.stop) {
    model = getIt.get<AppModel>();
    model.departuresUpdatedCallback = () {
      setState(() {});
    };
  }
  @override
  void initState() {
    super.initState();
    this.fetchDepartures();
    isSaved = this.stopSavedIndex() != -1;
  }

  void fetchDepartures() {
    this.departuresIndex = 0;
    this.model.stub.getDepartures(this.stop).listen((stop) {
      if (departuresIndex >= this.model.departures.length) {
        setState(() {
          this.model.departures.add(stop);
        });
      } else {
        setState(() {
          this.model.departures[departuresIndex] = stop;
        });
      }
      setState(() {});
      departuresIndex++;
    }, onError: (error) {
      this.completeFetchedDepartures();
    }, onDone: () {
      if (this.model.departures.length > departuresIndex) {
        setState(() {
          this
              .model
              .departures
              .removeRange(departuresIndex, this.model.departures.length);
        });
      }
      this.completeFetchedDepartures();
    });
  }

  void completeFetchedDepartures() {
    var _ = Timer(
        Duration(milliseconds: 500), () => this.fetchedDepartures.complete());
  }

  void removeFromSaved() {
    var toRemove = stopSavedIndex();
    this.model.savedStops.removeAt(toRemove);
    this.model.saveStops(this.model.savedStops);
    setState(() {
      this.isSaved = false;
    });
  }

  void addToSaved() {
    this.model.savedStops.add(this.stop);
    this.model.saveStops(this.model.savedStops);
    setState(() {
      this.isSaved = true;
    });
  }

  int stopSavedIndex() {
    return this.model.savedStops.lastIndexWhere((element) {
      return element.shortName == this.stop.shortName;
    });
  }

  @override
  Widget build(BuildContext context) {
    var scaf = Scaffold(
        appBar: AppBar(
          title: Text(this.stop.name),
          actions: <Widget>[
            Visibility(
              child: IconButton(
                icon: Icon(Icons.favorite),
                tooltip: 'Remove from saved',
                onPressed: removeFromSaved,
              ),
              visible: isSaved,
            ),
            Visibility(
              child: IconButton(
                icon: Icon(Icons.favorite_outline),
                tooltip: 'Add to saved',
                onPressed: addToSaved,
              ),
              visible: !isSaved,
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.edit),
          tooltip: 'Edit',
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => EditDeparturesPage(this.stop)));
          },
        ),
        body: RefreshIndicator(
          onRefresh: () {
            this.fetchedDepartures = new Completer();
            this.fetchDepartures();
            return this.fetchedDepartures.future;
          },
          child: ListView.builder(
            itemCount: this.model.departures.length,
            itemBuilder: (context, index) {
              Departure departure = this.model.departures[index];
              String relativeTime;
              if (departure.relativeTime == 0) {
                relativeTime = "";
              } else if (departure.relativeTime ~/ 60 < 1) {
                relativeTime = "${departure.relativeTime}s";
              } else {
                var minutes = departure.relativeTime ~/ 60;
                relativeTime = "${minutes}m";
              }
              return Container(
                color: model.findDepartureColor(departure),
                height: 40,
                child: Row(
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.all(8),
                        child: ConstrainedBox(
                          child: Text(departure.patternText),
                          constraints: BoxConstraints(minWidth: 24),
                        )),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(departure.direction),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.all(8), child: Text(relativeTime)),
                    Padding(
                        padding: EdgeInsets.all(8),
                        child: ConstrainedBox(
                          child: Text(departure.plannedTime),
                          constraints: BoxConstraints(minWidth: 24),
                        )),
                  ],
                ),
              );
            },
          ),
        ));

    return scaf;
  }
}
