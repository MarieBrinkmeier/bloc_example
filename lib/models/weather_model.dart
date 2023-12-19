///A model representing the weather data.
///
/// Contains information about the weather for a specific city,
/// including the geographical coordinates, weather conditions,
/// temperature, atmospheric conditions, visibility, wind speed,
/// cloudiness, and time of data calculation.
class WeatherModel {
  /// Creates a [WeatherModel] instance.
  ///
  /// Takes a list of [Weather], base station, main weather data,
  /// visibility distance, data receiving time, timezone offset,
  /// city ID, and city name.
  WeatherModel({
    required this.weather,
    required this.base,
    required this.main,
    required this.visibility,
    required this.dt,
    required this.timezone,
    required this.id,
    required this.name,
  });

  /// Creates a [WeatherModel] from a JSON object.
  ///
  /// Maps the JSON object to the [WeatherModel] fields using the
  /// [Weather], [Main], and other classes for nested objects.
  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      weather: (json['weather'] as List)
          .map(
            (weatherJson) =>
                Weather.fromJson(weatherJson as Map<String, dynamic>),
          )
          .toList(),
      base: json['base'] as String,
      main: Main.fromJson(json['main'] as Map<String, dynamic>),
      visibility: json['visibility'] as int,
      dt: json['dt'] as int,
      timezone: json['timezone'] as int,
      id: json['id'] as int,
      name: json['name'] as String,
    );
  }

  /// List of weather data for different times of the day.
  final List<Weather> weather;

  /// Base station.
  final String base;

  /// Main weather data including temperature, pressure, etc.
  final Main main;

  /// Visibility distance in meters.
  final int visibility;

  /// Time of data calculation, unix, UTC.
  final int dt;

  /// Timezone offset, in seconds from UTC.
  final int timezone;

  /// City ID.
  final int id;

  /// City name.
  final String name;
}

///A model representing coordinates.
class Coord {
  /// Creates a [Coord] instance.
  ///
  /// - [lon]: The longitude coordinate of the location.
  /// - [lat]: The latitude coordinate of the location.
  Coord({required this.lon, required this.lat});

  /// Creates a [Coord] from a JSON object.
  ///
  /// Maps the JSON object to the [Coord] fields.
  factory Coord.fromJson(Map<String, dynamic> json) {
    return Coord(
      lon: (json['lon'] as num).toDouble(),
      lat: (json['lat'] as num).toDouble(),
    );
  }

  /// Longitude coordinate.
  final double lon;

  /// Latitude coordinate.
  final double lat;
}

///A model representing the weather data.
class Weather {
  /// Creates a [Weather] instance.
  ///
  /// - [id]: Weather condition id.
  /// - [main]: Group of weather parameters (Rain, Snow, Extreme, etc.).
  /// - [description]: Weather condition within the group.
  /// - [icon]: Weather icon id.
  Weather({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  /// Creates a [Weather] from a JSON object.
  ///
  /// Maps the JSON object to the [Weather] fields.
  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      id: json['id'] as int,
      main: json['main'] as String,
      description: json['description'] as String,
      icon: json['icon'] as String,
    );
  }

  /// Weather condition ID.
  final int id;

  /// Group of weather parameters (Rain, Snow, Extreme, etc.).
  final String main;

  /// Weather condition within the group.
  final String description;

  /// Weather icon ID.
  final String icon;
}

///A model representing a Group of weather parameters
class Main {
  /// Creates a [Main] instance.
  ///
  /// - [temp]: Current temperature, Kelvin.
  /// - [feelsLike]: Human perception of temperature, Kelvin.
  /// - [tempMin]: Minimum temperature at the moment, Kelvin.
  /// - [tempMax]: Maximum temperature at the moment, Kelvin.
  /// - [pressure]: Atmospheric pressure on the sea level, hPa.
  /// - [humidity]: Humidity percentage.
  Main({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.humidity,
  });

  /// Creates a [Main] from a JSON object.
  ///
  /// Maps the JSON object to the [Main] fields.
  factory Main.fromJson(Map<String, dynamic> json) {
    return Main(
      temp: (json['temp'] as num).toDouble(),
      feelsLike: (json['feels_like'] as num).toDouble(),
      tempMin: (json['temp_min'] as num).toDouble(),
      tempMax: (json['temp_max'] as num).toDouble(),
      pressure: json['pressure'] as int,
      humidity: json['humidity'] as int,
    );
  }

  /// Current temperature in Kelvin.
  final double temp;

  /// Human-perceived equivalent temperature in Kelvin.
  final double feelsLike;

  /// Minimum temperature at the moment in Kelvin.
  final double tempMin;

  /// Maximum temperature at the moment in Kelvin.
  final double tempMax;

  /// Atmospheric pressure on the sea level, hPa.
  final int pressure;

  /// Humidity percentage.
  final int humidity;
}
