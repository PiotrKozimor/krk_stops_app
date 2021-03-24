///
//  Generated code. Do not modify.
//  source: krk-stops.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields,deprecated_member_use_from_same_package

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use installationDescriptor instead')
const Installation$json = const {
  '1': 'Installation',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 5, '10': 'id'},
    const {'1': 'latitude', '3': 2, '4': 1, '5': 2, '10': 'latitude'},
    const {'1': 'longitude', '3': 3, '4': 1, '5': 2, '10': 'longitude'},
  ],
};

/// Descriptor for `Installation`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List installationDescriptor = $convert.base64Decode('CgxJbnN0YWxsYXRpb24SDgoCaWQYASABKAVSAmlkEhoKCGxhdGl0dWRlGAIgASgCUghsYXRpdHVkZRIcCglsb25naXR1ZGUYAyABKAJSCWxvbmdpdHVkZQ==');
@$core.Deprecated('Use airlyDescriptor instead')
const Airly$json = const {
  '1': 'Airly',
  '2': const [
    const {'1': 'caqi', '3': 1, '4': 1, '5': 5, '10': 'caqi'},
    const {'1': 'colorStr', '3': 2, '4': 1, '5': 9, '10': 'colorStr'},
    const {'1': 'humidity', '3': 3, '4': 1, '5': 5, '10': 'humidity'},
    const {'1': 'temperature', '3': 4, '4': 1, '5': 2, '10': 'temperature'},
    const {'1': 'color', '3': 5, '4': 1, '5': 13, '10': 'color'},
  ],
};

/// Descriptor for `Airly`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List airlyDescriptor = $convert.base64Decode('CgVBaXJseRISCgRjYXFpGAEgASgFUgRjYXFpEhoKCGNvbG9yU3RyGAIgASgJUghjb2xvclN0chIaCghodW1pZGl0eRgDIAEoBVIIaHVtaWRpdHkSIAoLdGVtcGVyYXR1cmUYBCABKAJSC3RlbXBlcmF0dXJlEhQKBWNvbG9yGAUgASgNUgVjb2xvcg==');
@$core.Deprecated('Use installationLocationDescriptor instead')
const InstallationLocation$json = const {
  '1': 'InstallationLocation',
  '2': const [
    const {'1': 'latitude', '3': 1, '4': 1, '5': 2, '10': 'latitude'},
    const {'1': 'longitude', '3': 2, '4': 1, '5': 2, '10': 'longitude'},
  ],
};

/// Descriptor for `InstallationLocation`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List installationLocationDescriptor = $convert.base64Decode('ChRJbnN0YWxsYXRpb25Mb2NhdGlvbhIaCghsYXRpdHVkZRgBIAEoAlIIbGF0aXR1ZGUSHAoJbG9uZ2l0dWRlGAIgASgCUglsb25naXR1ZGU=');
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
  ],
};

/// Descriptor for `Departure`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List departureDescriptor = $convert.base64Decode('CglEZXBhcnR1cmUSIgoMcmVsYXRpdmVUaW1lGAEgASgFUgxyZWxhdGl2ZVRpbWUSIAoLcGxhbm5lZFRpbWUYAiABKAlSC3BsYW5uZWRUaW1lEhwKCWRpcmVjdGlvbhgDIAEoCVIJZGlyZWN0aW9uEiAKC3BhdHRlcm5UZXh0GAQgASgJUgtwYXR0ZXJuVGV4dBIUCgVjb2xvchgFIAEoDVIFY29sb3ISLgoScmVsYXRpdmVUaW1lUGFyc2VkGAYgASgJUhJyZWxhdGl2ZVRpbWVQYXJzZWQSHAoJcHJlZGljdGVkGAcgASgIUglwcmVkaWN0ZWQ=');
@$core.Deprecated('Use stopDescriptor instead')
const Stop$json = const {
  '1': 'Stop',
  '2': const [
    const {'1': 'shortName', '3': 1, '4': 1, '5': 9, '10': 'shortName'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'id', '3': 3, '4': 1, '5': 13, '10': 'id'},
  ],
};

/// Descriptor for `Stop`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List stopDescriptor = $convert.base64Decode('CgRTdG9wEhwKCXNob3J0TmFtZRgBIAEoCVIJc2hvcnROYW1lEhIKBG5hbWUYAiABKAlSBG5hbWUSDgoCaWQYAyABKA1SAmlk');
@$core.Deprecated('Use stopSearchDescriptor instead')
const StopSearch$json = const {
  '1': 'StopSearch',
  '2': const [
    const {'1': 'query', '3': 1, '4': 1, '5': 9, '10': 'query'},
  ],
};

/// Descriptor for `StopSearch`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List stopSearchDescriptor = $convert.base64Decode('CgpTdG9wU2VhcmNoEhQKBXF1ZXJ5GAEgASgJUgVxdWVyeQ==');
