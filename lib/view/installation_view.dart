import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:krk_stops_app/cubit/airly_cubit.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class InstallationView extends StatelessWidget {
  Function() showAirlyDialog(BuildContext context) {
    return () {
      showDialog(
          context: context,
          builder: (context) {
            String airlyError = "";
            var _airlyIdController = TextEditingController();
            var bloc = context.watch<AirlyCubit>();
            _airlyIdController.value =
                TextEditingValue(text: "${bloc.state.inst.id}");
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
                          context.read<AirlyCubit>().save(value);
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
                  decoration: airlyError == ""
                      ? InputDecoration(border: OutlineInputBorder())
                      : InputDecoration(
                          errorStyle: TextStyle(),
                          errorText: airlyError,
                          border: OutlineInputBorder()),
                ),
              );
            });
          });
    };
  }

  @override
  Widget build(BuildContext context) {
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
                child: BlocBuilder<AirlyCubit, AirlyInstallation>(
                    builder: (context, state) {
                  return Text(
                    AppLocalizations.of(context)!.airlyInstallation +
                        ": " +
                        "${state.inst.id}",
                    style: Theme.of(context).textTheme.bodyText1,
                  );
                })),
          ),
          IconButton(
              icon: Icon(Icons.launch),
              tooltip: AppLocalizations.of(context)!.airlySeeOnMap,
              onPressed: () async {
                var bloc = context.read<AirlyCubit>();
                var url = Uri(
                    scheme: "https",
                    host: "airly.eu",
                    path: "map/pl",
                    fragment:
                        "${bloc.state.inst.latitude},${bloc.state.inst.longitude},i${bloc.state.inst.id}");
                if (await canLaunchUrl(url)) {
                  await launchUrl(url, mode: LaunchMode.externalApplication);
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
                  context.read<AirlyCubit>().findNearest(location).then(
                      (value) {
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
            var url = Uri(scheme: "https", host: "airly.eu");
            if (await canLaunchUrl(url)) {
              await launchUrl(url, mode: LaunchMode.externalApplication);
            }
          },
        ),
      ],
    );
  }
}
