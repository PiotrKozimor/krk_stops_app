import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:krk_stops_app/cubit/installation_cubit.dart';
import 'package:krk_stops_app/grpc/krk-stops.pb.dart';
import 'package:url_launcher/url_launcher.dart';

class InstallationView extends StatelessWidget {
  String airlyError;
  var _airlyIdController = TextEditingController();
  Function() showAirlyDialog(BuildContext context) {
    return () {
      showDialog(
          context: context,
          builder: (context) {
            var bloc = context.watch<InstallationCubit>();
            _airlyIdController.value =
                TextEditingValue(text: "${bloc.state.id}");
            airlyError = null;
            return StatefulBuilder(builder: (context, setState) {
              return AlertDialog(
                title: Text("Edit installation"),
                actions: [
                  OutlineButton(
                      onPressed: () {
                        bloc
                            .checkId(
                                int.tryParse(_airlyIdController.value.text))
                            .then((value) => Navigator.pop(context),
                                onError: (Object error) {
                          setState(() {
                            airlyError = "Bad installation id";
                          });
                        });
                      },
                      child: Text("ACCEPT")),
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
                  .apply(color: Theme.of(context).primaryColorDark),
            )),
        Row(children: [
          Expanded(
            child: Container(
                padding: EdgeInsets.all(12),
                child: BlocBuilder<InstallationCubit, Installation>(
                    builder: (context, state) {
                  return Text(
                    "Installation: ${state.id}",
                    style: Theme.of(context).textTheme.bodyText1,
                  );
                })),
          ),
          IconButton(
              icon: Icon(Icons.launch),
              tooltip: 'See on Airly map',
              onPressed: () async {
                var url =
                    "https://airly.eu/map/pl/#${bloc.state.latitude},${bloc.state.longitude},i${bloc.state.id}";
                if (await canLaunch(url)) {
                  await launch(url);
                }
              }),
          IconButton(
            icon: Icon(Icons.location_searching),
            tooltip: 'Find nearest installation',
            onPressed: () {
              Geolocator.requestPermission().then((permisions) {
                Geolocator.getCurrentPosition(
                        desiredAccuracy: LocationAccuracy.medium)
                    .then((location) {
                  bloc.findNearest(location).then((value) {
                    final snackBar =
                        SnackBar(content: Text('Found nearest installation'));
                    Scaffold.of(context).showSnackBar(snackBar);
                  }, onError: (Object error) {
                    final snackBar = SnackBar(
                        content: Text(
                            'Error occured when finding nearest installation'));
                    Scaffold.of(context).showSnackBar(snackBar);
                  });
                });
              });
            },
          ),
          IconButton(
              icon: Icon(Icons.edit),
              tooltip: 'Edit installation',
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
