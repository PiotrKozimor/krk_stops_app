import 'dart:async';

import 'package:flutter/material.dart';

import 'grpc/krk-stops.pb.dart';
import 'grpc/krk-stops.pbgrpc.dart';

class DeparturesPage extends StatefulWidget {
  final Stop stop;
  final KrkStopsClient stub;
  final List<Stop> savedStops;
  final void Function(List<Stop>) stopsEditedCallback;
  DeparturesPage(
      this.stop, this.stub, this.savedStops, this.stopsEditedCallback);
  @override
  _DeparturesPageState createState() => _DeparturesPageState(
      this.stop, this.stub, this.savedStops, this.stopsEditedCallback);
}

class _DeparturesPageState extends State<DeparturesPage> {
  KrkStopsClient stub;
  Stop stop;
  List<Stop> savedStops;
  int departuresIndex = 0;
  bool isSaved;
  Completer fetchedDepartures = new Completer();
  final void Function(List<Stop>) stopsEditedCallback;

  _DeparturesPageState(
      this.stop, this.stub, this.savedStops, this.stopsEditedCallback);
  List<Departure> departures = [];
  @override
  void initState() {
    super.initState();
    this.fetchDepartures();
    isSaved = this.stopSavedIndex() != -1;
  }

  void fetchDepartures() {
    this.departuresIndex = 0;
    this.stub.getDepartures(this.stop).listen((stop) {
      if (departuresIndex >= this.departures.length) {
        setState(() {
          this.departures.add(stop);
        });
      } else {
        setState(() {
          this.departures[departuresIndex] = stop;
        });
      }
      setState(() {});
      departuresIndex++;
    }, onError: (error) {
      this.completeFetchedDepartures();
    }, onDone: () {
      if (this.departures.length > departuresIndex) {
        setState(() {
          this.departures.removeRange(departuresIndex, this.departures.length);
        });
      }
      this.completeFetchedDepartures();
    });
  }

  void completeFetchedDepartures() {
    var _ =
        Timer(Duration(milliseconds: 500), () => this.fetchedDepartures.complete());
  }

  void removeFromSaved() {
    var toRemove = stopSavedIndex();
    this.savedStops.removeAt(toRemove);
    this.stopsEditedCallback(this.savedStops);
    setState(() {
      this.isSaved = false;
    });
  }

  void addToSaved(){
    this.savedStops.add(this.stop);
    this.stopsEditedCallback(this.savedStops);
    setState(() {
      this.isSaved = true;
    });
  }

  int stopSavedIndex() {
    return this.savedStops.lastIndexWhere((element) {
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
                  icon: Icon(Icons.favorite), tooltip: 'Remove from saved',
                  onPressed: removeFromSaved,),
              visible: isSaved,
            ),
            Visibility(
              child: IconButton(
                  icon: Icon(Icons.favorite_outline), tooltip: 'Add to saved',
                  onPressed: addToSaved,),
              visible: !isSaved,
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.edit),
          tooltip: 'Edit',
          // onPressed: () {
          //   Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //           builder: (context) => EditDeparturesPage(this.stub)));
          // },
        ),
        body: RefreshIndicator(
          onRefresh: () {
            this.fetchedDepartures = new Completer();
            this.fetchDepartures();
            return this.fetchedDepartures.future;
          },
          child: ListView.builder(
            itemCount: this.departures.length,
            itemBuilder: (context, index) {
              Departure departure = this.departures[index];
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
                height: 36,
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
