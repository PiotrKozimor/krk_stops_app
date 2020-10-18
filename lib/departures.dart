import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:krk_stops_frontend_flutter/src/departures_list.dart';

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
  List<Departure> departuresTemp = [];
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
    this.departuresTemp = [];
    this.model.departuresCompleter = Completer<List<Departure>>();
    this.model.stub.getDepartures(this.stop).listen((stop) {
      this.departuresTemp.add(stop);
    }, onError: (error) {
      this.completeFetchedDepartures();
      this.model.departuresCompleter.completeError("Could not fetch departures: ${error.message}");
    }, onDone: () {
      setState(() {
        this.model.departures = this.departuresTemp;
        if (!model.departuresCompleter.isCompleted) {
          this.model.departuresCompleter.complete(this.model.departures);
          this.completeFetchedDepartures();
        }
      });
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
    this.model.stopsUpdatedCallback();
  }

  void addToSaved() {
    this.model.savedStops.add(this.stop);
    this.model.saveStops(this.model.savedStops);
    setState(() {
      this.isSaved = true;
    });
    this.model.stopsUpdatedCallback();
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
          child: DeparturesList(this.model.departuresCompleter)
        ));

    return scaf;
  }
}
