part of 'weather_bloc.dart';

@immutable

/// event of [WeatherBloc]
abstract class WeatherEvent {}

/// Represents an event triggered when the user wants to get the
/// weather for a specific city.
class GetWeatherEvent extends WeatherEvent {
  /// Represents an event triggered when the user wants to get the
  /// weather for a specific city.
  ///
  /// - [city] is the name of the city for which to fetch the weather data.
  GetWeatherEvent(this.city);

  /// The name of the city for which to fetch the weather data.
  final String city;
}
