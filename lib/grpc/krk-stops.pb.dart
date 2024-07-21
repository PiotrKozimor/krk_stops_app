///
//  Generated code. Do not modify.
//  source: krk-stops.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'krk-stops.pbenum.dart';

export 'krk-stops.pbenum.dart';

class GetDepartures2Request extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetDepartures2Request', createEmptyInstance: create)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  GetDepartures2Request._() : super();
  factory GetDepartures2Request({
    $core.int? id,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    return _result;
  }
  factory GetDepartures2Request.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetDepartures2Request.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetDepartures2Request clone() => GetDepartures2Request()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetDepartures2Request copyWith(void Function(GetDepartures2Request) updates) => super.copyWith((message) => updates(message as GetDepartures2Request)) as GetDepartures2Request; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetDepartures2Request create() => GetDepartures2Request._();
  GetDepartures2Request createEmptyInstance() => create();
  static $pb.PbList<GetDepartures2Request> createRepeated() => $pb.PbList<GetDepartures2Request>();
  @$core.pragma('dart2js:noInline')
  static GetDepartures2Request getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetDepartures2Request>(create);
  static GetDepartures2Request? _defaultInstance;

  @$pb.TagNumber(3)
  $core.int get id => $_getIZ(0);
  @$pb.TagNumber(3)
  set id($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(3)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(3)
  void clearId() => clearField(3);
}

class GetDepartures2Response extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetDepartures2Response', createEmptyInstance: create)
    ..pc<Departure>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'departures', $pb.PbFieldType.PM, subBuilder: Departure.create)
    ..hasRequiredFields = false
  ;

  GetDepartures2Response._() : super();
  factory GetDepartures2Response({
    $core.Iterable<Departure>? departures,
  }) {
    final _result = create();
    if (departures != null) {
      _result.departures.addAll(departures);
    }
    return _result;
  }
  factory GetDepartures2Response.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetDepartures2Response.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetDepartures2Response clone() => GetDepartures2Response()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetDepartures2Response copyWith(void Function(GetDepartures2Response) updates) => super.copyWith((message) => updates(message as GetDepartures2Response)) as GetDepartures2Response; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetDepartures2Response create() => GetDepartures2Response._();
  GetDepartures2Response createEmptyInstance() => create();
  static $pb.PbList<GetDepartures2Response> createRepeated() => $pb.PbList<GetDepartures2Response>();
  @$core.pragma('dart2js:noInline')
  static GetDepartures2Response getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetDepartures2Response>(create);
  static GetDepartures2Response? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<Departure> get departures => $_getList(0);
}

class SearchStops2Request extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SearchStops2Request', createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'query')
    ..hasRequiredFields = false
  ;

  SearchStops2Request._() : super();
  factory SearchStops2Request({
    $core.String? query,
  }) {
    final _result = create();
    if (query != null) {
      _result.query = query;
    }
    return _result;
  }
  factory SearchStops2Request.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SearchStops2Request.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SearchStops2Request clone() => SearchStops2Request()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SearchStops2Request copyWith(void Function(SearchStops2Request) updates) => super.copyWith((message) => updates(message as SearchStops2Request)) as SearchStops2Request; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SearchStops2Request create() => SearchStops2Request._();
  SearchStops2Request createEmptyInstance() => create();
  static $pb.PbList<SearchStops2Request> createRepeated() => $pb.PbList<SearchStops2Request>();
  @$core.pragma('dart2js:noInline')
  static SearchStops2Request getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SearchStops2Request>(create);
  static SearchStops2Request? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get query => $_getSZ(0);
  @$pb.TagNumber(1)
  set query($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasQuery() => $_has(0);
  @$pb.TagNumber(1)
  void clearQuery() => clearField(1);
}

class SearchStops2Response extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SearchStops2Response', createEmptyInstance: create)
    ..pc<Stop>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'stops', $pb.PbFieldType.PM, subBuilder: Stop.create)
    ..hasRequiredFields = false
  ;

  SearchStops2Response._() : super();
  factory SearchStops2Response({
    $core.Iterable<Stop>? stops,
  }) {
    final _result = create();
    if (stops != null) {
      _result.stops.addAll(stops);
    }
    return _result;
  }
  factory SearchStops2Response.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SearchStops2Response.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SearchStops2Response clone() => SearchStops2Response()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SearchStops2Response copyWith(void Function(SearchStops2Response) updates) => super.copyWith((message) => updates(message as SearchStops2Response)) as SearchStops2Response; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SearchStops2Response create() => SearchStops2Response._();
  SearchStops2Response createEmptyInstance() => create();
  static $pb.PbList<SearchStops2Response> createRepeated() => $pb.PbList<SearchStops2Response>();
  @$core.pragma('dart2js:noInline')
  static SearchStops2Response getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SearchStops2Response>(create);
  static SearchStops2Response? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<Stop> get stops => $_getList(0);
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
    ..e<Transit>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'type', $pb.PbFieldType.OE, defaultOrMaker: Transit.BUS, valueOf: Transit.valueOf, enumValues: Transit.values)
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
    Transit? type,
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
  Transit get type => $_getN(7);
  @$pb.TagNumber(8)
  set type(Transit v) { setField(8, v); }
  @$pb.TagNumber(8)
  $core.bool hasType() => $_has(7);
  @$pb.TagNumber(8)
  void clearType() => clearField(8);
}

class Stop extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Stop', createEmptyInstance: create)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id', $pb.PbFieldType.OU3)
    ..e<Transit>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'type', $pb.PbFieldType.OE, defaultOrMaker: Transit.BUS, valueOf: Transit.valueOf, enumValues: Transit.values)
    ..hasRequiredFields = false
  ;

  Stop._() : super();
  factory Stop({
    $core.String? name,
    $core.int? id,
    Transit? type,
  }) {
    final _result = create();
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

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(2)
  set name($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(2)
  void clearName() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get id => $_getIZ(1);
  @$pb.TagNumber(3)
  set id($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(3)
  $core.bool hasId() => $_has(1);
  @$pb.TagNumber(3)
  void clearId() => clearField(3);

  @$pb.TagNumber(4)
  Transit get type => $_getN(2);
  @$pb.TagNumber(4)
  set type(Transit v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasType() => $_has(2);
  @$pb.TagNumber(4)
  void clearType() => clearField(4);
}

