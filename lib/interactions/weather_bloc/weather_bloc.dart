import 'dart:async';

import 'package:bloc_example/models/weather_model.dart';
import 'package:bloc_example/repositories/weather_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'weather_event.dart';
part 'weather_state.dart';

/// [WeatherBloc] is a [Bloc] that handles the logic of fetching and
/// managing weather data in response to [WeatherEvent]s.
///
/// It outputs [WeatherState]s which reflect the current state of
/// weather data retrieval and management.
class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  /// Creates a [WeatherBloc] instance.
  ///
  /// - [httpService]: The [WeatherRepository] used to fetch weather data.
  WeatherBloc(this.httpService) : super(WeatherInitial()) {
    on<GetWeatherEvent>(getWeather);
  }

  /// The [WeatherRepository] used to fetch weather data.
  final WeatherRepository httpService;

  /// Fetches weather data based on a [GetWeatherEvent].
  ///
  /// - [event]: The [GetWeatherEvent] that triggers weather data fetching.
  /// - [emit]: The [Emitter] used to output [WeatherState]s.
  Future<void> getWeather(
    GetWeatherEvent event,
    Emitter<WeatherState> emit,
  ) async {
    emit(WeatherLoading());
    try {
      final weatherData = await httpService.getWeather(event.city);

      final weatherModel = WeatherModel.fromJson(weatherData);

      emit(WeatherLoaded(weatherModel));
    } on BadRequestException {
      emit(WeatherErrorBadRequest('Some mandatory parameters are missing.'));
    } on UnauthorizedException {
      emit(WeatherErrorUnauthorized('Your API token seems to be wrong.'));
    } on NotFoundException {
      emit(WeatherErrorNotFound('Your city seems to be unknown.'));
    } on TooManyRequestsException {
      emit(WeatherErrorTooManyRequests('You reached your request limit.'));
    } on ServerException {
      emit(WeatherErrorServer('Ooops the server seems to be down.'));
    } on UnknownException {
      emit(WeatherUnknownError('An unknown error occurred.'));
    } catch (e) {
      emit(WeatherUnknownError('An unknown error occurred.'));
    }
  }
}
