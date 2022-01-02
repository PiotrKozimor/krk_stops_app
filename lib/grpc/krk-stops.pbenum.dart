///
//  Generated code. Do not modify.
//  source: krk-stops.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class Endpoint extends $pb.ProtobufEnum {
  static const Endpoint BUS = Endpoint._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'BUS');
  static const Endpoint TRAM = Endpoint._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'TRAM');
  static const Endpoint ALL = Endpoint._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'ALL');

  static const $core.List<Endpoint> values = <Endpoint> [
    BUS,
    TRAM,
    ALL,
  ];

  static final $core.Map<$core.int, Endpoint> _byValue = $pb.ProtobufEnum.initByValue(values);
  static Endpoint? valueOf($core.int value) => _byValue[value];

  const Endpoint._($core.int v, $core.String n) : super(v, n);
}

