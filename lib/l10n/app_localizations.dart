import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_pl.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('pl')
  ];

  /// No description provided for @loginLoggedAs.
  ///
  /// In en, this message translates to:
  /// **'Logged as'**
  String get loginLoggedAs;

  /// No description provided for @loginOut.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get loginOut;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Log in'**
  String get login;

  /// No description provided for @loginPlease.
  ///
  /// In en, this message translates to:
  /// **'Please log in to backup settings'**
  String get loginPlease;

  /// No description provided for @legalNotice.
  ///
  /// In en, this message translates to:
  /// **'Legal notice'**
  String get legalNotice;

  /// No description provided for @backup.
  ///
  /// In en, this message translates to:
  /// **'Cloud backup'**
  String get backup;

  /// No description provided for @backupSettings.
  ///
  /// In en, this message translates to:
  /// **'Backup Settings'**
  String get backupSettings;

  /// No description provided for @backupSettingsOk.
  ///
  /// In en, this message translates to:
  /// **'Backup finished successfully'**
  String get backupSettingsOk;

  /// No description provided for @backupSettingsError.
  ///
  /// In en, this message translates to:
  /// **'Error occured during backup'**
  String get backupSettingsError;

  /// No description provided for @backupRestore.
  ///
  /// In en, this message translates to:
  /// **'Restore Settings'**
  String get backupRestore;

  /// No description provided for @backupRestoreOk.
  ///
  /// In en, this message translates to:
  /// **'Restored settings successfully'**
  String get backupRestoreOk;

  /// No description provided for @backupRestoreError.
  ///
  /// In en, this message translates to:
  /// **'Error occured when restoring backup'**
  String get backupRestoreError;

  /// No description provided for @backupRemove.
  ///
  /// In en, this message translates to:
  /// **'Remove Backup'**
  String get backupRemove;

  /// No description provided for @backupRemoveOk.
  ///
  /// In en, this message translates to:
  /// **'Backup removed successfully'**
  String get backupRemoveOk;

  /// No description provided for @backupRemoveError.
  ///
  /// In en, this message translates to:
  /// **'Error occured when removing backup'**
  String get backupRemoveError;

  /// No description provided for @departuresError.
  ///
  /// In en, this message translates to:
  /// **'Failed to fetch departures'**
  String get departuresError;

  /// No description provided for @departuresErrorUpstream.
  ///
  /// In en, this message translates to:
  /// **'Failed to fetch departures: upstream server error'**
  String get departuresErrorUpstream;

  /// No description provided for @savedStopsAdd.
  ///
  /// In en, this message translates to:
  /// **'Add to saved'**
  String get savedStopsAdd;

  /// No description provided for @savedStopsRemove.
  ///
  /// In en, this message translates to:
  /// **'Remove from saved'**
  String get savedStopsRemove;

  /// No description provided for @stopsSearchError.
  ///
  /// In en, this message translates to:
  /// **'Failed to search stops'**
  String get stopsSearchError;

  /// No description provided for @departureFilterbyType.
  ///
  /// In en, this message translates to:
  /// **'Filter bus or tram departures'**
  String get departureFilterbyType;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'pl'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'pl':
      return AppLocalizationsPl();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
