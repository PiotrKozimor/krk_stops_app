import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
              style: Theme.of(context).textTheme.titleLarge,
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
                    style: Theme.of(context).textTheme.bodyLarge,
                  );
                })),
          ),
          IconButton(
              icon: Icon(Icons.edit),
              tooltip: AppLocalizations.of(context)!.airlyEditInstallation,
              onPressed: showAirlyDialog(context)),
        ]),
      ],
    );
  }
}
