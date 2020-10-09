import 'package:flutter/material.dart';
import 'package:grpc/grpc.dart';
import 'package:krk_stops_frontend_flutter/departures.dart';
import 'package:krk_stops_frontend_flutter/edit_stops.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
        primarySwatch: Colors.grey,
      ),
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
  Airly airly = new Airly();
  String stops = 'stops';
  KrkStopsClient stub;
  List<Stop> savedStops;
  SharedPreferences prefs;
  List<Container> stopContainers;

  final channel = ClientChannel('krk-stops.pl',
      port: 8080,
      options:
          const ChannelOptions(credentials: ChannelCredentials.insecure()));

  @override
  void initState() {
    super.initState();
    this.airly.color = "#AAAAAA";
    this.stub = KrkStopsClient(this.channel,
        options: CallOptions(timeout: Duration(seconds: 30)));
    SharedPreferences.getInstance().then((value) {
      this.prefs = value;
      loadStops();
    });
    fetchAirly();
  }

  void loadStops() {
    this.prefs.remove(this.stops);
    var stopsRaw = this.prefs.getStringList(this.stops);
    if (stopsRaw == null) {
      this.savedStops = [
        Stop()
          ..name = 'Rondo Mogilskie'
          ..shortName = '125',
        Stop()
          ..name = 'Rondo Matecznego'
          ..shortName = '610'
      ];
      saveStops();
    } else {
      for (final stopRaw in stopsRaw) {
        this.savedStops.add(Stop.fromJson(stopRaw));
      }
    }
    setState(() {});
  }

  void saveStops() {
    List<String> rawStops;
    for (final stop in rawStops){
      rawStops.add(stop.toString());
    }
    this.prefs.setStringList(this.stops, rawStops);
  }

  void fetchAirly() {
    final installation = Installation()..id = 9914;
    final airly = stub.getAirly(installation);
    airly.then((airly) {
      this.airly = airly;
      setState(() {});
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
        height: 50,
        child: Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(8),
              child: Icon(
                Icons.brightness_1,
                color: Color(
                    int.parse(this.airly.color.substring(1, 7), radix: 16) +
                        0xFF000000),
                // color: Color(0xFF999999),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text("CAQI: ${this.airly.caqi}"),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text('${this.airly.humidity}%'),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Text('${this.airly.temperature.toStringAsFixed(1)}°C'),
              ),
            ),
            IconButton(
                icon: Icon(Icons.refresh),
                tooltip: 'Search stops',
                onPressed: fetchAirly),
          ],
        ));
    var stopCount = 1;
    if (this.savedStops != null) {
      stopCount = this.savedStops.length + 1;
    }
    var scaf = Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.edit),
            tooltip: 'Edit',
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => EditStopsPage(this.stub)));
            },
          ),
          IconButton(icon: Icon(Icons.search), tooltip: 'Search stops'),
        ],
      ),
      body: ListView.builder(
        itemCount: stopCount,
        itemBuilder: (context, index) {
          if (index == 0) {
            return airlyContainer;
          } else {
            Stop stop = this.savedStops[index - 1];
            return InkWell(
              child: Container(
                  height: 50,
                  child: Align(
                    child: Text(stop.name),
                    alignment: AlignmentDirectional.centerStart,
                  )),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => DeparturesPage(stop, stub)));
              },
            );
          }
        },
        padding: const EdgeInsets.all(8),
      ),
    );
    return scaf;
  }
}
