import 'package:flutter/material.dart';
import 'package:krk_stops_app/l10n/app_localizations.dart';

import 'package:url_launcher/url_launcher.dart';

class LegalView extends StatelessWidget {
  LegalView();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextButton(
          onPressed: () => launchUrl(
              Uri.parse("https://krkstops.cozymore.dev/legal_notice")),
          child: Text(AppLocalizations.of(context)!.legalNotice)),
    );
  }
}
