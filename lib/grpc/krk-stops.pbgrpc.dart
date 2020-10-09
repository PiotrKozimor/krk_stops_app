///
//  Generated code. Do not modify.
//  source: krk-stops.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'krk-stops.pb.dart' as $0;
export 'krk-stops.pb.dart';

class KrkStopsClient extends $grpc.Client {
  static final _$getAirly = $grpc.ClientMethod<$0.Installation, $0.Airly>(
      '/KrkStops/GetAirly',
      ($0.Installation value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Airly.fromBuffer(value));
  static final _$getAirlyInstallation =
      $grpc.ClientMethod<$0.InstallationLocation, $0.Installation>(
          '/KrkStops/GetAirlyInstallation',
          ($0.InstallationLocation value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.Installation.fromBuffer(value));
  static final _$getDepartures = $grpc.ClientMethod<$0.Stop, $0.Departure>(
      '/KrkStops/GetDepartures',
      ($0.Stop value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Departure.fromBuffer(value));
  static final _$searchStops = $grpc.ClientMethod<$0.StopSearch, $0.Stop>(
      '/KrkStops/SearchStops',
      ($0.StopSearch value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Stop.fromBuffer(value));

  KrkStopsClient($grpc.ClientChannel channel, {$grpc.CallOptions options})
      : super(channel, options: options);

  $grpc.ResponseFuture<$0.Airly> getAirly($0.Installation request,
      {$grpc.CallOptions options}) {
    final call = $createCall(_$getAirly, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseFuture<$0.Installation> getAirlyInstallation(
      $0.InstallationLocation request,
      {$grpc.CallOptions options}) {
    final call = $createCall(
        _$getAirlyInstallation, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseStream<$0.Departure> getDepartures($0.Stop request,
      {$grpc.CallOptions options}) {
    final call = $createCall(
        _$getDepartures, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseStream(call);
  }

  $grpc.ResponseStream<$0.Stop> searchStops($0.StopSearch request,
      {$grpc.CallOptions options}) {
    final call = $createCall(
        _$searchStops, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseStream(call);
  }
}

abstract class KrkStopsServiceBase extends $grpc.Service {
  $core.String get $name => 'KrkStops';

  KrkStopsServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.Installation, $0.Airly>(
        'GetAirly',
        getAirly_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Installation.fromBuffer(value),
        ($0.Airly value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.InstallationLocation, $0.Installation>(
        'GetAirlyInstallation',
        getAirlyInstallation_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.InstallationLocation.fromBuffer(value),
        ($0.Installation value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Stop, $0.Departure>(
        'GetDepartures',
        getDepartures_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $0.Stop.fromBuffer(value),
        ($0.Departure value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.StopSearch, $0.Stop>(
        'SearchStops',
        searchStops_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $0.StopSearch.fromBuffer(value),
        ($0.Stop value) => value.writeToBuffer()));
  }

  $async.Future<$0.Airly> getAirly_Pre(
      $grpc.ServiceCall call, $async.Future<$0.Installation> request) async {
    return getAirly(call, await request);
  }

  $async.Future<$0.Installation> getAirlyInstallation_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.InstallationLocation> request) async {
    return getAirlyInstallation(call, await request);
  }

  $async.Stream<$0.Departure> getDepartures_Pre(
      $grpc.ServiceCall call, $async.Future<$0.Stop> request) async* {
    yield* getDepartures(call, await request);
  }

  $async.Stream<$0.Stop> searchStops_Pre(
      $grpc.ServiceCall call, $async.Future<$0.StopSearch> request) async* {
    yield* searchStops(call, await request);
  }

  $async.Future<$0.Airly> getAirly(
      $grpc.ServiceCall call, $0.Installation request);
  $async.Future<$0.Installation> getAirlyInstallation(
      $grpc.ServiceCall call, $0.InstallationLocation request);
  $async.Stream<$0.Departure> getDepartures(
      $grpc.ServiceCall call, $0.Stop request);
  $async.Stream<$0.Stop> searchStops(
      $grpc.ServiceCall call, $0.StopSearch request);
}
