import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:url_launcher/url_launcher.dart';

import 'grpc/krk-stops.pbgrpc.dart';
import 'model.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage();
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<SettingsPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final getIt = GetIt.instance;
  AppModel model;
  String airlyError;
  var _airlyIdController = TextEditingController();
  _SettingsState() {
    model = getIt.get<AppModel>();
    _airlyIdController.text = "${model.installation.id}";
  }

  updateInstallation(Installation instalation) {
    setState(() {
      this.model.installation = instalation;
    });
  }

  Function() showAirlyDialog(BuildContext context) {
    return () {
      showDialog(
          context: context,
          builder: (context) {
            _airlyIdController.value =
                TextEditingValue(text: "${this.model.installation.id}");
            airlyError = null;
            return StatefulBuilder(builder: (context, setState) {
              return AlertDialog(
                title: Text("Edit installation"),
                actions: [
                  OutlineButton(
                      onPressed: () {
                        final installation = Installation()
                          ..id = int.tryParse(_airlyIdController.value.text);
                        this.model.stub.getAirlyInstallation(installation).then(
                            (fullInstallation) {
                          updateInstallation(fullInstallation);
                          this.model.saveInstallation();
                          Navigator.of(context).pop();
                        }, onError: (error) {
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
    List<Widget> backupList;
    if (model.auth.currentUser == null) {
      backupList = [
        Container(
            padding: EdgeInsets.all(12),
            child: Text(
              "Please log in to backup settings",
            )),
        Container(
            padding: EdgeInsets.fromLTRB(24, 8, 24, 8),
            child: RaisedButton(
              child: Text(
                "LOG IN",
              ),
              onPressed: () async {
                final GoogleSignInAccount googleUser =
                    await GoogleSignIn().signIn();
                print(googleUser);
                final GoogleSignInAuthentication googleAuth =
                    await googleUser.authentication;
                print(googleAuth);
                final GoogleAuthCredential credential =
                    GoogleAuthProvider.credential(
                  accessToken: googleAuth.accessToken,
                  idToken: googleAuth.idToken,
                );
                var currentUser = await FirebaseAuth.instance
                    .signInWithCredential(credential);
                setState(() {});
              },
            )),
      ];
    } else {
      backupList = [
        Container(
            padding: EdgeInsets.all(12),
            child: Text(
              "Logged as ${model.auth.currentUser.email}",
            )),
        Container(
            padding: EdgeInsets.fromLTRB(24, 8, 24, 8),
            child: RaisedButton(
              child: Text(
                "LOG OUT",
              ),
              onPressed: () async {
                model.auth.signOut();
                setState(() {});
              },
            )),
        Container(
            padding: EdgeInsets.fromLTRB(24, 8, 24, 8),
            child: RaisedButton(
                child: Text(
                  "BACKUP SETTINGS",
                ),
                onPressed: () async {
                  var backed = model.backupSettings();
                  backed.then((value) {
                    final snackBar =
                        SnackBar(content: Text('Backup finished successfully'));
                    _scaffoldKey.currentState.showSnackBar(snackBar);
                  }).catchError((Object error) {
                    final snackBar =
                        SnackBar(content: Text('Error occured during backup'));
                    _scaffoldKey.currentState.showSnackBar(snackBar);
                  });
                })),
        Container(
            padding: EdgeInsets.fromLTRB(24, 8, 24, 8),
            child: RaisedButton(
              child: Text(
                "RESTORE SETTINGS",
              ),
              onPressed: () async {
                model.restoreSettings().future.then((value) {
                  final snackBar =
                      SnackBar(content: Text('Restored settings successfully'));
                  _scaffoldKey.currentState.showSnackBar(snackBar);
                }).catchError((Object error) {
                  final snackBar = SnackBar(
                      content: Text('Error occured when restoring backup'));
                  _scaffoldKey.currentState.showSnackBar(snackBar);
                });
              },
            )),
        Container(
            padding: EdgeInsets.fromLTRB(24, 8, 24, 8),
            child: RaisedButton(
              child: Text(
                "REMOVE BACKUP",
              ),
              onPressed: () async {
                model.removeBackup().then((value) {
                  final snackBar =
                      SnackBar(content: Text('Backup removed successfully'));
                  _scaffoldKey.currentState.showSnackBar(snackBar);
                }).catchError((Object error) {
                  final snackBar = SnackBar(
                      content: Text('Error occured when removing backup'));
                  _scaffoldKey.currentState.showSnackBar(snackBar);
                });
              },
            )),
      ];
    }
    var scaf = Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text("KrkStops"),
        ),
        body: ListView(
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
                  child: Text(
                    "Installation: ${this.model.installation.id}",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
              ),
              IconButton(
                  icon: Icon(Icons.launch),
                  tooltip: 'See on Airly map',
                  onPressed: () async {
                    var url =
                        "https://airly.eu/map/pl/#${model.installation.latitude},${model.installation.longitude},i${model.installation.id}";
                    if (await canLaunch(url)) {
                      await launch(url);
                    }
                  }),
              IconButton(
                icon: Icon(Icons.location_searching),
                tooltip: 'Find nearest installation',
                onPressed: () {
                  requestPermission().then((permisions) {
                    getCurrentPosition(desiredAccuracy: LocationAccuracy.medium)
                        .then((location) {
                      this
                          .model
                          .stub
                          .findNearestAirlyInstallation(InstallationLocation()
                            ..latitude = location.latitude
                            ..longitude = location.longitude)
                          .then((installation) {
                        updateInstallation(installation);
                        this.model.saveInstallation();
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
            Divider(),
            Container(
                padding: EdgeInsets.all(12),
                child: Text(
                  "Cloud Backup",
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2
                      .apply(color: Theme.of(context).primaryColorDark),
                )),
            ...backupList
          ],
        ));
    return scaf;
  }
}
