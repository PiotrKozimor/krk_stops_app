///
//  Generated code. Do not modify.
//  source: krk-stops.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class Transit extends $pb.ProtobufEnum {
  static const Transit BUS = Transit._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'BUS');
  static const Transit TRAM = Transit._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'TRAM');
  static const Transit ALL = Transit._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'ALL');

  static const $core.List<Transit> values = <Transit> [
    BUS,
    TRAM,
    ALL,
  ];

  static final $core.Map<$core.int, Transit> _byValue = $pb.ProtobufEnum.initByValue(values);
  static Transit? valueOf($core.int value) => _byValue[value];

  const Transit._($core.int v, $core.String n) : super(v, n);
}

