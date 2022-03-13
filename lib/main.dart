import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krk_stops_app/cubit/airly_cubit.dart';
import 'package:krk_stops_app/cubit/departure_color_cubit.dart';
import 'package:krk_stops_app/cubit/departures_cubit.dart';
import 'package:krk_stops_app/cubit/installation_cubit.dart';
import 'package:krk_stops_app/cubit/stops_cubit.dart';
import 'package:krk_stops_app/page/departures.dart';
import 'package:krk_stops_app/page/edit_stops.dart';
import 'package:krk_stops_app/page/home.dart';
import 'package:krk_stops_app/repository/firebase_repository.dart';
import 'package:krk_stops_app/repository/krk_stops_repository.dart';
import 'package:krk_stops_app/repository/local_repository.dart';
import 'package:krk_stops_app/search_stops.dart';
import 'package:krk_stops_app/page/settings.dart';
import 'package:krk_stops_app/view/airly_view.dart';
import 'package:krk_stops_app/view/stops_view.dart';
import 'cubit/last_stops_cubit.dart';
import 'grpc/krk-stops.pb.dart';
import 'grpc/krk-stops.pbgrpc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(KrkStopsApp(
    krkStopsRepository: KrkStopsRepository(),
    localRepository: LocalRepository(),
  ));
}

class KrkStopsApp extends StatelessWidget {
  final KrkStopsRepository krkStopsRepository;
  final LocalRepository localRepository;
  const KrkStopsApp({
    Key? key,
    required this.krkStopsRepository,
    required this.localRepository,
  }) : super(key: key);

  @override
  Widget build(BuildContext _) {
    var colors = DepartureColorCubit(localRepository);
    return RepositoryProvider.value(
        value: krkStopsRepository,
        child: MultiBlocProvider(
            providers: [
              BlocProvider<AirlyCubit>(
                  create: (_) => AirlyCubit(krkStopsRepository)),
              BlocProvider<StopsCubit>(
                  create: (_) => StopsCubit(localRepository)),
              BlocProvider(
                  create: (_) =>
                      InstallationCubit(krkStopsRepository, localRepository)),
              BlocProvider(create: (_) => LastStopsCubit(localRepository)),
              BlocProvider(create: (_) => colors),
              BlocProvider(
                  create: (_) =>
                      DeparturesCubit(krkStopsRepository, colors.state))
            ],
            child: BlocListener<InstallationCubit, Installation>(
              listener: (context, state) {
                context.read<AirlyCubit>().fetchAirly(state);
              },
              child: BlocListener<DepartureColorCubit, List<Departure>>(
                  listener: (context, state) {
                    context.read<DeparturesCubit>().applyColors(state);
                  },
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
                        typography: Typography.material2018()),
                    home: HomePage(title: 'KrkStops'),
                  )),
            )));
  }
}
