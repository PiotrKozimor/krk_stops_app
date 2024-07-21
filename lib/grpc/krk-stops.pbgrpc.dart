///
//  Generated code. Do not modify.
//  source: krk-stops.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'krk-stops.pb.dart' as $0;
export 'krk-stops.pb.dart';

class KrkStopsClient extends $grpc.Client {
  static final _$getDepartures2 =
      $grpc.ClientMethod<$0.GetDepartures2Request, $0.GetDepartures2Response>(
          '/KrkStops/GetDepartures2',
          ($0.GetDepartures2Request value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.GetDepartures2Response.fromBuffer(value));
  static final _$searchStops2 =
      $grpc.ClientMethod<$0.SearchStops2Request, $0.SearchStops2Response>(
          '/KrkStops/SearchStops2',
          ($0.SearchStops2Request value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.SearchStops2Response.fromBuffer(value));

  KrkStopsClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.GetDepartures2Response> getDepartures2(
      $0.GetDepartures2Request request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getDepartures2, request, options: options);
  }

  $grpc.ResponseFuture<$0.SearchStops2Response> searchStops2(
      $0.SearchStops2Request request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$searchStops2, request, options: options);
  }
}

abstract class KrkStopsServiceBase extends $grpc.Service {
  $core.String get $name => 'KrkStops';

  KrkStopsServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.GetDepartures2Request,
            $0.GetDepartures2Response>(
        'GetDepartures2',
        getDepartures2_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetDepartures2Request.fromBuffer(value),
        ($0.GetDepartures2Response value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.SearchStops2Request, $0.SearchStops2Response>(
            'SearchStops2',
            searchStops2_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.SearchStops2Request.fromBuffer(value),
            ($0.SearchStops2Response value) => value.writeToBuffer()));
  }

  $async.Future<$0.GetDepartures2Response> getDepartures2_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetDepartures2Request> request) async {
    return getDepartures2(call, await request);
  }

  $async.Future<$0.SearchStops2Response> searchStops2_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.SearchStops2Request> request) async {
    return searchStops2(call, await request);
  }

  $async.Future<$0.GetDepartures2Response> getDepartures2(
      $grpc.ServiceCall call, $0.GetDepartures2Request request);
  $async.Future<$0.SearchStops2Response> searchStops2(
      $grpc.ServiceCall call, $0.SearchStops2Request request);
}
