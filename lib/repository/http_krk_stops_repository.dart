import 'package:http/http.dart' as http;
import 'package:krk_stops_app/grpc/krk-stops.pb.dart';

enum RepositoryError {
  upstream,
  other,
}

class HttpRepositoryResult<T> {
  final T data;
  final RepositoryError? error;

  HttpRepositoryResult(this.data, this.error);
}

class HttpKrkStopsRepository {
  static const String _searchStopsUrl =
      'https://httpapikrkstops.cozymore.dev/1';
  static const String _fetchDeparturesUrl =
      'https://httpapikrkstops.cozymore.dev/2';

  late final http.Client _client;
  int lastStopId = 0;

  HttpKrkStopsRepository() {
    _client = http.Client();
  }

  Future<HttpRepositoryResult<List<Departure>>> fetchDepartures(
      int stopId) async {
    lastStopId = stopId;
    print('http: fetching departures: $stopId');

    try {
      final request = GetDepartures2Request(id: stopId);
      final requestData = request.writeToBuffer();

      final response = await _client.post(
        Uri.parse(_fetchDeparturesUrl),
        body: requestData,
        headers: {'Content-Type': 'application/x-protobuf'},
      );

      if (response.statusCode == 500) {
        return HttpRepositoryResult(<Departure>[], RepositoryError.upstream);
      }

      if (response.statusCode != 200) {
        print('http: unexpected status code: ${response.statusCode}');
        return HttpRepositoryResult(<Departure>[], RepositoryError.other);
      }

      final responseData =
          GetDepartures2Response.fromBuffer(response.bodyBytes);
      return HttpRepositoryResult(responseData.departures, null);
    } catch (error) {
      print('http: failed to fetch departures: $error');
      return HttpRepositoryResult(<Departure>[], RepositoryError.other);
    }
  }

  Future<HttpRepositoryResult<List<Stop>>> searchStops(String query) async {
    print('http: searching stops: $query');

    try {
      final request = SearchStops2Request(query: query);
      final requestData = request.writeToBuffer();

      final response = await _client.post(
        Uri.parse(_searchStopsUrl),
        body: requestData,
        headers: {'Content-Type': 'application/x-protobuf'},
      );

      if (response.statusCode == 500) {
        return HttpRepositoryResult(<Stop>[], RepositoryError.upstream);
      }

      if (response.statusCode != 200) {
        print('http: unexpected status code: ${response.statusCode}');
        return HttpRepositoryResult(<Stop>[], RepositoryError.other);
      }

      final responseData = SearchStops2Response.fromBuffer(response.bodyBytes);
      return HttpRepositoryResult(responseData.stops, null);
    } catch (error) {
      print('http: failed to search stops: $error');
      return HttpRepositoryResult(<Stop>[], RepositoryError.other);
    }
  }

  void dispose() {
    _client.close();
  }
}
