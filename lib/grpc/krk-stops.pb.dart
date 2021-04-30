///
//  Generated code. Do not modify.
//  source: krk-stops.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'krk-stops.pbenum.dart';

export 'krk-stops.pbenum.dart';

class Installation extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Installation', createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id', $pb.PbFieldType.O3)
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'latitude', $pb.PbFieldType.OF)
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'longitude', $pb.PbFieldType.OF)
    ..hasRequiredFields = false
  ;

  Installation._() : super();
  factory Installation({
    $core.int? id,
    $core.double? latitude,
    $core.double? longitude,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (latitude != null) {
      _result.latitude = latitude;
    }
    if (longitude != null) {
      _result.longitude = longitude;
    }
    return _result;
  }
  factory Installation.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Installation.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Installation clone() => Installation()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Installation copyWith(void Function(Installation) updates) => super.copyWith((message) => updates(message as Installation)) as Installation; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Installation create() => Installation._();
  Installation createEmptyInstance() => create();
  static $pb.PbList<Installation> createRepeated() => $pb.PbList<Installation>();
  @$core.pragma('dart2js:noInline')
  static Installation getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Installation>(create);
  static Installation? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get id => $_getIZ(0);
  @$pb.TagNumber(1)
  set id($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get latitude => $_getN(1);
  @$pb.TagNumber(2)
  set latitude($core.double v) { $_setFloat(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasLatitude() => $_has(1);
  @$pb.TagNumber(2)
  void clearLatitude() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get longitude => $_getN(2);
  @$pb.TagNumber(3)
  set longitude($core.double v) { $_setFloat(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasLongitude() => $_has(2);
  @$pb.TagNumber(3)
  void clearLongitude() => clearField(3);
}

class Airly extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Airly', createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'caqi', $pb.PbFieldType.O3)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'colorStr', protoName: 'colorStr')
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'humidity', $pb.PbFieldType.O3)
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'temperature', $pb.PbFieldType.OF)
    ..a<$core.int>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'color', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  Airly._() : super();
  factory Airly({
    $core.int? caqi,
    $core.String? colorStr,
    $core.int? humidity,
    $core.double? temperature,
    $core.int? color,
  }) {
    final _result = create();
    if (caqi != null) {
      _result.caqi = caqi;
    }
    if (colorStr != null) {
      _result.colorStr = colorStr;
    }
    if (humidity != null) {
      _result.humidity = humidity;
    }
    if (temperature != null) {
      _result.temperature = temperature;
    }
    if (color != null) {
      _result.color = color;
    }
    return _result;
  }
  factory Airly.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Airly.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Airly clone() => Airly()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Airly copyWith(void Function(Airly) updates) => super.copyWith((message) => updates(message as Airly)) as Airly; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Airly create() => Airly._();
  Airly createEmptyInstance() => create();
  static $pb.PbList<Airly> createRepeated() => $pb.PbList<Airly>();
  @$core.pragma('dart2js:noInline')
  static Airly getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Airly>(create);
  static Airly? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get caqi => $_getIZ(0);
  @$pb.TagNumber(1)
  set caqi($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCaqi() => $_has(0);
  @$pb.TagNumber(1)
  void clearCaqi() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get colorStr => $_getSZ(1);
  @$pb.TagNumber(2)
  set colorStr($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasColorStr() => $_has(1);
  @$pb.TagNumber(2)
  void clearColorStr() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get humidity => $_getIZ(2);
  @$pb.TagNumber(3)
  set humidity($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasHumidity() => $_has(2);
  @$pb.TagNumber(3)
  void clearHumidity() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get temperature => $_getN(3);
  @$pb.TagNumber(4)
  set temperature($core.double v) { $_setFloat(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasTemperature() => $_has(3);
  @$pb.TagNumber(4)
  void clearTemperature() => clearField(4);

  @$pb.TagNumber(5)
  $core.int get color => $_getIZ(4);
  @$pb.TagNumber(5)
  set color($core.int v) { $_setUnsignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasColor() => $_has(4);
  @$pb.TagNumber(5)
  void clearColor() => clearField(5);
}

class InstallationLocation extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'InstallationLocation', createEmptyInstance: create)
    ..a<$core.double>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'latitude', $pb.PbFieldType.OF)
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'longitude', $pb.PbFieldType.OF)
    ..hasRequiredFields = false
  ;

  InstallationLocation._() : super();
  factory InstallationLocation({
    $core.double? latitude,
    $core.double? longitude,
  }) {
    final _result = create();
    if (latitude != null) {
      _result.latitude = latitude;
    }
    if (longitude != null) {
      _result.longitude = longitude;
    }
    return _result;
  }
  factory InstallationLocation.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InstallationLocation.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  InstallationLocation clone() => InstallationLocation()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  InstallationLocation copyWith(void Function(InstallationLocation) updates) => super.copyWith((message) => updates(message as InstallationLocation)) as InstallationLocation; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static InstallationLocation create() => InstallationLocation._();
  InstallationLocation createEmptyInstance() => create();
  static $pb.PbList<InstallationLocation> createRepeated() => $pb.PbList<InstallationLocation>();
  @$core.pragma('dart2js:noInline')
  static InstallationLocation getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<InstallationLocation>(create);
  static InstallationLocation? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get latitude => $_getN(0);
  @$pb.TagNumber(1)
  set latitude($core.double v) { $_setFloat(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasLatitude() => $_has(0);
  @$pb.TagNumber(1)
  void clearLatitude() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get longitude => $_getN(1);
  @$pb.TagNumber(2)
  set longitude($core.double v) { $_setFloat(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasLongitude() => $_has(1);
  @$pb.TagNumber(2)
  void clearLongitude() => clearField(2);
}

class Departure extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Departure', createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'relativeTime', $pb.PbFieldType.O3, protoName: 'relativeTime')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'plannedTime', protoName: 'plannedTime')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'direction')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'patternText', protoName: 'patternText')
    ..a<$core.int>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'color', $pb.PbFieldType.OU3)
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'relativeTimeParsed', protoName: 'relativeTimeParsed')
    ..aOB(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'predicted')
    ..e<Endpoint>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'type', $pb.PbFieldType.OE, defaultOrMaker: Endpoint.BUS, valueOf: Endpoint.valueOf, enumValues: Endpoint.values)
    ..hasRequiredFields = false
  ;

  Departure._() : super();
  factory Departure({
    $core.int? relativeTime,
    $core.String? plannedTime,
    $core.String? direction,
    $core.String? patternText,
    $core.int? color,
    $core.String? relativeTimeParsed,
    $core.bool? predicted,
    Endpoint? type,
  }) {
    final _result = create();
    if (relativeTime != null) {
      _result.relativeTime = relativeTime;
    }
    if (plannedTime != null) {
      _result.plannedTime = plannedTime;
    }
    if (direction != null) {
      _result.direction = direction;
    }
    if (patternText != null) {
      _result.patternText = patternText;
    }
    if (color != null) {
      _result.color = color;
    }
    if (relativeTimeParsed != null) {
      _result.relativeTimeParsed = relativeTimeParsed;
    }
    if (predicted != null) {
      _result.predicted = predicted;
    }
    if (type != null) {
      _result.type = type;
    }
    return _result;
  }
  factory Departure.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Departure.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Departure clone() => Departure()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Departure copyWith(void Function(Departure) updates) => super.copyWith((message) => updates(message as Departure)) as Departure; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Departure create() => Departure._();
  Departure createEmptyInstance() => create();
  static $pb.PbList<Departure> createRepeated() => $pb.PbList<Departure>();
  @$core.pragma('dart2js:noInline')
  static Departure getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Departure>(create);
  static Departure? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get relativeTime => $_getIZ(0);
  @$pb.TagNumber(1)
  set relativeTime($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasRelativeTime() => $_has(0);
  @$pb.TagNumber(1)
  void clearRelativeTime() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get plannedTime => $_getSZ(1);
  @$pb.TagNumber(2)
  set plannedTime($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPlannedTime() => $_has(1);
  @$pb.TagNumber(2)
  void clearPlannedTime() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get direction => $_getSZ(2);
  @$pb.TagNumber(3)
  set direction($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasDirection() => $_has(2);
  @$pb.TagNumber(3)
  void clearDirection() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get patternText => $_getSZ(3);
  @$pb.TagNumber(4)
  set patternText($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasPatternText() => $_has(3);
  @$pb.TagNumber(4)
  void clearPatternText() => clearField(4);

  @$pb.TagNumber(5)
  $core.int get color => $_getIZ(4);
  @$pb.TagNumber(5)
  set color($core.int v) { $_setUnsignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasColor() => $_has(4);
  @$pb.TagNumber(5)
  void clearColor() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get relativeTimeParsed => $_getSZ(5);
  @$pb.TagNumber(6)
  set relativeTimeParsed($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasRelativeTimeParsed() => $_has(5);
  @$pb.TagNumber(6)
  void clearRelativeTimeParsed() => clearField(6);

  @$pb.TagNumber(7)
  $core.bool get predicted => $_getBF(6);
  @$pb.TagNumber(7)
  set predicted($core.bool v) { $_setBool(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasPredicted() => $_has(6);
  @$pb.TagNumber(7)
  void clearPredicted() => clearField(7);

  @$pb.TagNumber(8)
  Endpoint get type => $_getN(7);
  @$pb.TagNumber(8)
  set type(Endpoint v) { setField(8, v); }
  @$pb.TagNumber(8)
  $core.bool hasType() => $_has(7);
  @$pb.TagNumber(8)
  void clearType() => clearField(8);
}

class Stop extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Stop', createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'shortName', protoName: 'shortName')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id', $pb.PbFieldType.OU3)
    ..e<Endpoint>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'type', $pb.PbFieldType.OE, defaultOrMaker: Endpoint.BUS, valueOf: Endpoint.valueOf, enumValues: Endpoint.values)
    ..hasRequiredFields = false
  ;

  Stop._() : super();
  factory Stop({
    $core.String? shortName,
    $core.String? name,
    $core.int? id,
    Endpoint? type,
  }) {
    final _result = create();
    if (shortName != null) {
      _result.shortName = shortName;
    }
    if (name != null) {
      _result.name = name;
    }
    if (id != null) {
      _result.id = id;
    }
    if (type != null) {
      _result.type = type;
    }
    return _result;
  }
  factory Stop.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Stop.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Stop clone() => Stop()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Stop copyWith(void Function(Stop) updates) => super.copyWith((message) => updates(message as Stop)) as Stop; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Stop create() => Stop._();
  Stop createEmptyInstance() => create();
  static $pb.PbList<Stop> createRepeated() => $pb.PbList<Stop>();
  @$core.pragma('dart2js:noInline')
  static Stop getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Stop>(create);
  static Stop? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get shortName => $_getSZ(0);
  @$pb.TagNumber(1)
  set shortName($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasShortName() => $_has(0);
  @$pb.TagNumber(1)
  void clearShortName() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get id => $_getIZ(2);
  @$pb.TagNumber(3)
  set id($core.int v) { $_setUnsignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasId() => $_has(2);
  @$pb.TagNumber(3)
  void clearId() => clearField(3);

  @$pb.TagNumber(4)
  Endpoint get type => $_getN(3);
  @$pb.TagNumber(4)
  set type(Endpoint v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasType() => $_has(3);
  @$pb.TagNumber(4)
  void clearType() => clearField(4);
}

class StopSearch extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'StopSearch', createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'query')
    ..hasRequiredFields = false
  ;

  StopSearch._() : super();
  factory StopSearch({
    $core.String? query,
  }) {
    final _result = create();
    if (query != null) {
      _result.query = query;
    }
    return _result;
  }
  factory StopSearch.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory StopSearch.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  StopSearch clone() => StopSearch()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  StopSearch copyWith(void Function(StopSearch) updates) => super.copyWith((message) => updates(message as StopSearch)) as StopSearch; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static StopSearch create() => StopSearch._();
  StopSearch createEmptyInstance() => create();
  static $pb.PbList<StopSearch> createRepeated() => $pb.PbList<StopSearch>();
  @$core.pragma('dart2js:noInline')
  static StopSearch getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<StopSearch>(create);
  static StopSearch? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get query => $_getSZ(0);
  @$pb.TagNumber(1)
  set query($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasQuery() => $_has(0);
  @$pb.TagNumber(1)
  void clearQuery() => clearField(1);
}

