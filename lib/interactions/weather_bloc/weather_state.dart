part of 'weather_bloc.dart';

@immutable

/// state of [WeatherBloc]
abstract class WeatherState {}

/// initial state of [WeatherBloc], can be used as first state of the bloc
class WeatherInitial extends WeatherState {}

/// Represents the state where the weather data is currently being fetched.
class WeatherLoading extends WeatherState {}

/// Represents the state where the weather data has been successfully loaded.
class WeatherLoaded extends WeatherState {
  /// Represents the state where the weather data has been successfully loaded.
  ///
  /// This class needs two inputs:
  /// - [weatherModel] : This represents the weather data.
  WeatherLoaded(
    this.weatherModel,
  );

  /// represents the weather data.
  final WeatherModel weatherModel;
}

/// error state of [WeatherBloc]
abstract class WeatherError extends WeatherState {
  /// creates an instance of [WeatherError]
  WeatherError(this.errorMessage);

  /// error message
  final String errorMessage;
}

/// Represents a state where a bad request error has occurred.
class WeatherErrorBadRequest extends WeatherError {
  /// creates an instance of [WeatherErrorBadRequest]
  WeatherErrorBadRequest(super.errorMessage);
}

/// Represents a state where an unauthorized error has occurred.
class WeatherErrorUnauthorized extends WeatherError {
  /// creates an instance of [WeatherErrorUnauthorized]
  WeatherErrorUnauthorized(super.errorMessage);
}

/// Represents a state where a not found error has occurred.
class WeatherErrorNotFound extends WeatherError {
  /// creates an instance of [WeatherErrorNotFound]
  WeatherErrorNotFound(super.errorMessage);
}

/// Represents a state where a too many requests error has occurred.
class WeatherErrorTooManyRequests extends WeatherError {
  /// creates an instance of [WeatherErrorTooManyRequests]
  WeatherErrorTooManyRequests(super.errorMessage);
}

/// Represents a state where a server error has occurred.
class WeatherErrorServer extends WeatherError {
  /// creates an instance of [WeatherErrorServer]
  WeatherErrorServer(super.errorMessage);
}

/// Represents the state where an unknown error has occurred.
class WeatherUnknownError extends WeatherError {
  /// creates an instance of [WeatherUnknownError]
  WeatherUnknownError(super.errorMessage);
}
