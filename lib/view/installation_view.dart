import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:krk_stops_app/cubit/installation_cubit.dart';
import 'package:krk_stops_app/grpc/krk-stops.pb.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class InstallationView extends StatelessWidget {
  String airlyError = "";
  var _airlyIdController = TextEditingController();
  Function() showAirlyDialog(BuildContext context) {
    return () {
      showDialog(
          context: context,
          builder: (context) {
            var bloc = context.watch<InstallationCubit>();
            _airlyIdController.value =
                TextEditingValue(text: "${bloc.state.id}");
            airlyError = "";
            return StatefulBuilder(builder: (context, setState) {
              return AlertDialog(
                title:
                    Text(AppLocalizations.of(context)!.airlyEditInstallation),
                actions: [
                  OutlinedButton(
                      onPressed: () {
                        bloc
                            .checkId(int.parse(_airlyIdController.value.text))
                            .then((value) {
                          Navigator.pop(context);
                          context.read<InstallationCubit>().save(value);
                        }, onError: (Object error) {
                          setState(() {
                            airlyError = AppLocalizations.of(context)!
                                .airlyEditInstallationBadId;
                          });
                        });
                      },
                      child: Text(AppLocalizations.of(context)!
                          .airlyEditInstallationAccept)),
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
    var bloc = context.watch<InstallationCubit>();
    return Column(
      children: [
        Container(
            padding: EdgeInsets.all(12),
            child: Text(
              "Airly",
              style: Theme.of(context)
                  .textTheme
                  .subtitle2
                  ?.apply(color: Theme.of(context).primaryColorDark),
            )),
        Row(children: [
          Expanded(
            child: Container(
                padding: EdgeInsets.all(12),
                child: BlocBuilder<InstallationCubit, Installation>(
                    builder: (context, state) {
                  return Text(
                    AppLocalizations.of(context)!.airlyInstallation +
                        ": " +
                        "${state.id}",
                    style: Theme.of(context).textTheme.bodyText1,
                  );
                })),
          ),
          IconButton(
              icon: Icon(Icons.launch),
              tooltip: AppLocalizations.of(context)!.airlySeeOnMap,
              onPressed: () async {
                var url =
                    "https://airly.eu/map/pl/#${bloc.state.latitude},${bloc.state.longitude},i${bloc.state.id}";
                if (await canLaunch(url)) {
                  await launch(url);
                }
              }),
          IconButton(
            icon: Icon(Icons.location_searching),
            tooltip: AppLocalizations.of(context)!.airlyFindNearestInstallation,
            onPressed: () {
              Geolocator.requestPermission().then((permisions) {
                Geolocator.getCurrentPosition(
                        desiredAccuracy: LocationAccuracy.medium)
                    .then((location) {
                  bloc.findNearest(location).then((value) {
                    final snackBar = SnackBar(
                        content: Text(AppLocalizations.of(context)!
                            .airlyFindNearestInstallationOk));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }, onError: (Object error) {
                    final snackBar = SnackBar(
                        content: Text(AppLocalizations.of(context)!
                            .airlyFindNearestInstallationError));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  });
                });
              });
            },
          ),
          IconButton(
              icon: Icon(Icons.edit),
              tooltip: AppLocalizations.of(context)!.airlyEditInstallation,
              onPressed: showAirlyDialog(context)),
        ]),
        InkWell(
          child: Container(
            height: 48,
            child: Row(
              children: [
                Image(image: AssetImage('images/airly.png')),
                Expanded(child: Container())
              ],
            ),
            padding: EdgeInsets.all(12),
          ),
          onTap: () async {
            var url = "https://airly.eu";
            if (await canLaunch(url)) {
              await launch(url);
            }
          },
        ),
      ],
    );
  }
}
