import 'dart:convert';
import 'package:http/http.dart' as http;

/// A service for making HTTP requests to fetch weather data.
///
/// This service defines methods for fetching weather data
/// from a specified API. The base URL of the API is passed in the constructor.
class WeatherRepository {
  /// Creates a [WeatherRepository] instance.
  ///
  /// [baseUrl] is the base URL of the API from which weather data is fetched.
  WeatherRepository(this.baseUrl);

  /// The base URL of the API from which weather data is fetched.
  final String baseUrl;

  /// Fetches weather data for the specified [city].
  ///
  /// Sends an HTTP GET request to the API to fetch weather data for the
  /// specified [city]. Returns a [Map] containing the weather data.
  /// Throws an [Exception] if the request fails.
  Future<Map<String, dynamic>> getWeather(String city) async {
    final url = Uri.parse(
      // ToDo pass your key as run parameter like `--dart-define="API_KEY=<your_key>"`
      '$baseUrl/weather?q=$city&appid=${const String.fromEnvironment('API_KEY')}&units=metric',
    );
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return json.decode(response.body) as Map<String, dynamic>;
    } else if (response.statusCode == 400) {
      throw BadRequestException();
    } else if (response.statusCode == 401) {
      throw UnauthorizedException();
    } else if (response.statusCode == 404) {
      throw NotFoundException();
    } else if (response.statusCode == 429) {
      throw TooManyRequestsException();
    } else if (response.statusCode.toString().startsWith('5')) {
      throw ServerException();
    } else {
      throw UnknownException();
    }
  }
}

/// Thrown when the server returns a HTTP status code of 400.
///
/// Indicates that the server could not understand the request due to
/// invalid syntax.
class BadRequestException implements Exception {}

/// Thrown when the server returns a HTTP status code of 401.
///
/// Indicates that the client must authenticate itself to get
/// network access.
class UnauthorizedException implements Exception {}

/// Thrown when the server returns a HTTP status code of 404.
///
/// Indicates that the server can not find the requested resource.
class NotFoundException implements Exception {}

/// Thrown when the server returns a HTTP status code of 429.
///
/// Indicates that the user has sent too many requests in a
/// given amount of time.
class TooManyRequestsException implements Exception {}

/// Thrown when the server returns a HTTP status code that starts with 5.
///
/// Indicates that the server is aware that it has encountered an error
/// or is otherwise incapable of performing the request.
class ServerException implements Exception {}

/// Thrown when an unknown or unhandled error occurs.
class UnknownException implements Exception {}
