///
//  Generated code. Do not modify.
//  source: krk-stops.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use transitDescriptor instead')
const Transit$json = const {
  '1': 'Transit',
  '2': const [
    const {'1': 'BUS', '2': 0},
    const {'1': 'TRAM', '2': 1},
    const {'1': 'ALL', '2': 2},
  ],
};

/// Descriptor for `Transit`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List transitDescriptor = $convert.base64Decode('CgdUcmFuc2l0EgcKA0JVUxAAEggKBFRSQU0QARIHCgNBTEwQAg==');
@$core.Deprecated('Use getDepartures2RequestDescriptor instead')
const GetDepartures2Request$json = const {
  '1': 'GetDepartures2Request',
  '2': const [
    const {'1': 'id', '3': 3, '4': 1, '5': 13, '10': 'id'},
  ],
};

/// Descriptor for `GetDepartures2Request`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getDepartures2RequestDescriptor = $convert.base64Decode('ChVHZXREZXBhcnR1cmVzMlJlcXVlc3QSDgoCaWQYAyABKA1SAmlk');
@$core.Deprecated('Use getDepartures2ResponseDescriptor instead')
const GetDepartures2Response$json = const {
  '1': 'GetDepartures2Response',
  '2': const [
    const {'1': 'departures', '3': 1, '4': 3, '5': 11, '6': '.Departure', '10': 'departures'},
  ],
};

/// Descriptor for `GetDepartures2Response`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getDepartures2ResponseDescriptor = $convert.base64Decode('ChZHZXREZXBhcnR1cmVzMlJlc3BvbnNlEioKCmRlcGFydHVyZXMYASADKAsyCi5EZXBhcnR1cmVSCmRlcGFydHVyZXM=');
@$core.Deprecated('Use searchStops2RequestDescriptor instead')
const SearchStops2Request$json = const {
  '1': 'SearchStops2Request',
  '2': const [
    const {'1': 'query', '3': 1, '4': 1, '5': 9, '10': 'query'},
  ],
};

/// Descriptor for `SearchStops2Request`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List searchStops2RequestDescriptor = $convert.base64Decode('ChNTZWFyY2hTdG9wczJSZXF1ZXN0EhQKBXF1ZXJ5GAEgASgJUgVxdWVyeQ==');
@$core.Deprecated('Use searchStops2ResponseDescriptor instead')
const SearchStops2Response$json = const {
  '1': 'SearchStops2Response',
  '2': const [
    const {'1': 'stops', '3': 1, '4': 3, '5': 11, '6': '.Stop', '10': 'stops'},
  ],
};

/// Descriptor for `SearchStops2Response`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List searchStops2ResponseDescriptor = $convert.base64Decode('ChRTZWFyY2hTdG9wczJSZXNwb25zZRIbCgVzdG9wcxgBIAMoCzIFLlN0b3BSBXN0b3Bz');
@$core.Deprecated('Use departureDescriptor instead')
const Departure$json = const {
  '1': 'Departure',
  '2': const [
    const {'1': 'relativeTime', '3': 1, '4': 1, '5': 5, '10': 'relativeTime'},
    const {'1': 'plannedTime', '3': 2, '4': 1, '5': 9, '10': 'plannedTime'},
    const {'1': 'direction', '3': 3, '4': 1, '5': 9, '10': 'direction'},
    const {'1': 'patternText', '3': 4, '4': 1, '5': 9, '10': 'patternText'},
    const {'1': 'color', '3': 5, '4': 1, '5': 13, '10': 'color'},
    const {'1': 'relativeTimeParsed', '3': 6, '4': 1, '5': 9, '10': 'relativeTimeParsed'},
    const {'1': 'predicted', '3': 7, '4': 1, '5': 8, '10': 'predicted'},
    const {'1': 'type', '3': 8, '4': 1, '5': 14, '6': '.Transit', '10': 'type'},
  ],
};

/// Descriptor for `Departure`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List departureDescriptor = $convert.base64Decode('CglEZXBhcnR1cmUSIgoMcmVsYXRpdmVUaW1lGAEgASgFUgxyZWxhdGl2ZVRpbWUSIAoLcGxhbm5lZFRpbWUYAiABKAlSC3BsYW5uZWRUaW1lEhwKCWRpcmVjdGlvbhgDIAEoCVIJZGlyZWN0aW9uEiAKC3BhdHRlcm5UZXh0GAQgASgJUgtwYXR0ZXJuVGV4dBIUCgVjb2xvchgFIAEoDVIFY29sb3ISLgoScmVsYXRpdmVUaW1lUGFyc2VkGAYgASgJUhJyZWxhdGl2ZVRpbWVQYXJzZWQSHAoJcHJlZGljdGVkGAcgASgIUglwcmVkaWN0ZWQSHAoEdHlwZRgIIAEoDjIILlRyYW5zaXRSBHR5cGU=');
@$core.Deprecated('Use stopDescriptor instead')
const Stop$json = const {
  '1': 'Stop',
  '2': const [
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'id', '3': 3, '4': 1, '5': 13, '10': 'id'},
    const {'1': 'type', '3': 4, '4': 1, '5': 14, '6': '.Transit', '10': 'type'},
  ],
  '9': const [
    const {'1': 1, '2': 2},
  ],
};

/// Descriptor for `Stop`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List stopDescriptor = $convert.base64Decode('CgRTdG9wEhIKBG5hbWUYAiABKAlSBG5hbWUSDgoCaWQYAyABKA1SAmlkEhwKBHR5cGUYBCABKA4yCC5UcmFuc2l0UgR0eXBlSgQIARAC');
