import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:krk_stops_frontend_flutter/departures.dart';
import 'package:krk_stops_frontend_flutter/edit_stops.dart';
import 'package:krk_stops_frontend_flutter/model.dart';
import 'package:krk_stops_frontend_flutter/search_stops.dart';
import 'package:krk_stops_frontend_flutter/src/stops_list.dart';
import 'grpc/krk-stops.pb.dart';
import 'grpc/krk-stops.pbgrpc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KrkStops',
      theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.indigo,
          primaryColor: Colors.indigo[200],
          primaryColorBrightness: Brightness.light,
          // accentColor: Colors.amber[500],
          // accentColorBrightness: Brightness.light,
          brightness: Brightness.light,
          typography: Typography.material2018()),
      home: MyHomePage(title: 'KrkStops'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final model = AppModel();
  List<Container> stopContainers;
  final getIt = GetIt.instance;

  _MyHomePageState() {
    getIt.registerSingleton<AppModel>(model);
    model.stopsUpdatedCallback = () {
      setState(() {});
    };
    model.airlyUpdatedCallback = () {
      setState(() {
        
      });
    };
  }

  @override
  void initState() {
    super.initState();
    fetchAirly();
  }

  fetchAirly() {
    model.fetchAirly(this.model.installation).then((airly) {
      setState(() {
        this.model.airly = airly;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    var airlyContainer = Container(
        height: 52,
        child: Card(
            elevation: 2,
            child: Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Icon(
                    Icons.brightness_1,
                    color: Color(int.parse(
                            this.model.airly.color.substring(1, 7),
                            radix: 16) +
                        0xFF000000),
                    // color: Color(0xFF999999),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    "CAQI: ${this.model.airly.caqi}",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    '${this.model.airly.humidity}%',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      '${this.model.airly.temperature.toStringAsFixed(1)}°C',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                ),
                IconButton(
                    icon: Icon(Icons.refresh),
                    tooltip: 'Search stops',
                    onPressed: fetchAirly),
              ],
            )));
    var scaf = Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.search),
                onPressed: () async {
                  var stopSearched = await showSearch<Stop>(
                      context: context, delegate: SearchStops());
                  if (stopSearched != null) {
                    this.model.departures = [];
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                DeparturesPage(stopSearched)));
                  }
                }),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.edit),
          tooltip: 'Edit',
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => EditStopsPage()));
          },
        ),
        body: Container(
          padding: EdgeInsets.all(4),
          child: Column(
            children: [
              airlyContainer,
              Expanded(
                  child: Card(
                      elevation: 2, child: StopsList(model.stopsCompleter)))
            ],
          ),
        ));

    return scaf;
  }
}
