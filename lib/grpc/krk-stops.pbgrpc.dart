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
  static final _$getAirly =
      $grpc.ClientMethod<$0.GetMeasurementRequest, $0.Measurement>(
          '/KrkStops/GetAirly',
          ($0.GetMeasurementRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.Measurement.fromBuffer(value));
  static final _$findNearestAirlyInstallation =
      $grpc.ClientMethod<$0.Location, $0.Installation>(
          '/KrkStops/FindNearestAirlyInstallation',
          ($0.Location value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.Installation.fromBuffer(value));
  static final _$getAirlyInstallation =
      $grpc.ClientMethod<$0.GetAirlyInstallationRequest, $0.Installation>(
          '/KrkStops/GetAirlyInstallation',
          ($0.GetAirlyInstallationRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.Installation.fromBuffer(value));
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

  $grpc.ResponseFuture<$0.Measurement> getAirly(
      $0.GetMeasurementRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAirly, request, options: options);
  }

  $grpc.ResponseFuture<$0.Installation> findNearestAirlyInstallation(
      $0.Location request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$findNearestAirlyInstallation, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.Installation> getAirlyInstallation(
      $0.GetAirlyInstallationRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAirlyInstallation, request, options: options);
  }

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
    $addMethod($grpc.ServiceMethod<$0.GetMeasurementRequest, $0.Measurement>(
        'GetAirly',
        getAirly_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetMeasurementRequest.fromBuffer(value),
        ($0.Measurement value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Location, $0.Installation>(
        'FindNearestAirlyInstallation',
        findNearestAirlyInstallation_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Location.fromBuffer(value),
        ($0.Installation value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.GetAirlyInstallationRequest, $0.Installation>(
            'GetAirlyInstallation',
            getAirlyInstallation_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.GetAirlyInstallationRequest.fromBuffer(value),
            ($0.Installation value) => value.writeToBuffer()));
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

  $async.Future<$0.Measurement> getAirly_Pre($grpc.ServiceCall call,
      $async.Future<$0.GetMeasurementRequest> request) async {
    return getAirly(call, await request);
  }

  $async.Future<$0.Installation> findNearestAirlyInstallation_Pre(
      $grpc.ServiceCall call, $async.Future<$0.Location> request) async {
    return findNearestAirlyInstallation(call, await request);
  }

  $async.Future<$0.Installation> getAirlyInstallation_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetAirlyInstallationRequest> request) async {
    return getAirlyInstallation(call, await request);
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

  $async.Future<$0.Measurement> getAirly(
      $grpc.ServiceCall call, $0.GetMeasurementRequest request);
  $async.Future<$0.Installation> findNearestAirlyInstallation(
      $grpc.ServiceCall call, $0.Location request);
  $async.Future<$0.Installation> getAirlyInstallation(
      $grpc.ServiceCall call, $0.GetAirlyInstallationRequest request);
  $async.Future<$0.GetDepartures2Response> getDepartures2(
      $grpc.ServiceCall call, $0.GetDepartures2Request request);
  $async.Future<$0.SearchStops2Response> searchStops2(
      $grpc.ServiceCall call, $0.SearchStops2Request request);
}
