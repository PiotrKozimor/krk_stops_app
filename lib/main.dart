import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krk_stops_app/cubit/departures_cubit.dart';
import 'package:krk_stops_app/cubit/stops_cubit.dart';
import 'package:krk_stops_app/l10n/app_localizations.dart';
import 'package:krk_stops_app/last_stop.dart';
import 'package:krk_stops_app/page/home.dart';
import 'package:krk_stops_app/repository/http_krk_stops_repository.dart';
import 'package:krk_stops_app/repository/local_repository.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(KrkStopsApp(
    httpKrkStopsRepository: HttpKrkStopsRepository(),
    localRepository: LocalRepository(),
  ));
}

class KrkStopsApp extends StatelessWidget {
  final HttpKrkStopsRepository httpKrkStopsRepository;
  final LocalRepository localRepository;
  const KrkStopsApp({
    Key? key,
    required this.httpKrkStopsRepository,
    required this.localRepository,
  }) : super(key: key);

  @override
  Widget build(BuildContext _) {
    return RepositoryProvider.value(
      value: httpKrkStopsRepository,
      child: MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => StopsCubit(localRepository)),
            BlocProvider(
                create: (_) =>
                    DeparturesCubit(httpKrkStopsRepository, localRepository)),
          ],
          child: MaterialApp(
            title: 'KrkStops',
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: [
              const Locale('en', ''),
              const Locale('pl', ''),
            ],
            theme: ThemeData(
                primarySwatch: Colors.indigo,
                primaryColor: Colors.indigo[200],
                brightness: Brightness.light,
                typography: Typography.material2021()),
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              primarySwatch: Colors.indigo,
              primaryColor: Colors.indigo[200],
              typography: Typography.material2021(),
            ),
            themeMode: ThemeMode.system,
            home: HomePage(LastStops(localRepository), title: "KrkStops"),
          )),
    );
  }
}
