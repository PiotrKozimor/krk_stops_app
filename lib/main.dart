import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:krk_stops_app/cubit/airly_cubit.dart';
import 'package:krk_stops_app/cubit/stops_cubit.dart';
import 'package:krk_stops_app/departures.dart';
import 'package:krk_stops_app/edit_stops.dart';
import 'package:krk_stops_app/model.dart';
import 'package:krk_stops_app/repository/firebase_repository.dart';
import 'package:krk_stops_app/repository/krk_stops_repository.dart';
import 'package:krk_stops_app/search_stops.dart';
import 'package:krk_stops_app/settings.dart';
import 'package:krk_stops_app/src/stops_list.dart';
import 'package:krk_stops_app/view/airly_view.dart';
import 'package:krk_stops_app/view/stops_view.dart';
import 'grpc/krk-stops.pb.dart';
import 'grpc/krk-stops.pbgrpc.dart';
import 'observer.dart';

void main() {
  Bloc.observer = Observer();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(KrkStopsApp(
    krkStopsRepository: KrkStopsRepository(),
    firebaseRepository: FirebaseRepository(),
  ));
}

class KrkStopsApp extends StatelessWidget {
  final KrkStopsRepository krkStopsRepository;
  final FirebaseRepository firebaseRepository;
  const KrkStopsApp({
    Key key,
    @required this.krkStopsRepository,
    @required this.firebaseRepository,
  })  : assert(krkStopsRepository != null),
        assert(firebaseRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: KrkStopsRepository,
      child: MultiBlocProvider(
          providers: [
            BlocProvider<AirlyCubit>(
                create: (_) => AirlyCubit(krkStopsRepository)),
            BlocProvider<StopsCubit>(
                create: (_) => StopsCubit(krkStopsRepository)),
          ],
          child: MaterialApp(
            title: 'KrkStops',
            theme: ThemeData(
                primarySwatch: Colors.indigo,
                primaryColor: Colors.indigo[200],
                primaryColorBrightness: Brightness.light,
                brightness: Brightness.light,
                typography: Typography.material2018()),
            home: HomePage(title: 'KrkStops'),
          )),
    );
  }
}

class HomePage extends StatelessWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;
  @override
  Widget build(BuildContext context) {
    var scaf = Scaffold(
        appBar: AppBar(
          title: Text(title),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.search),
                onPressed: () async {
                  var stopSearched = await showSearch<Stop>(
                      context: context, delegate: SearchStops());
                  if (stopSearched != null) {
                    // this.model.departures = [];
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => DeparturesPage(stopSearched)));
                  }
                }),
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => SettingsPage()));
              },
            )
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
        body: ListView(
          children: [
            BlocBuilder<AirlyCubit, Airly>(
                builder: (context, airly) => AirlyView(airly),
                cubit: context.bloc<AirlyCubit>()),
            Divider(
              height: 7,
              thickness: 1,
            ),
            BlocBuilder<StopsCubit, List<Stop>>(
                builder: (context, stops) => StopsView(stops),
                cubit: context.bloc<StopsCubit>())
          ],
        ));
    return scaf;
  }
}
