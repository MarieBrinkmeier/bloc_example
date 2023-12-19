import 'package:bloc_example/interactions/weather_bloc/weather_bloc.dart';
import 'package:bloc_example/repositories/weather_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDataService extends Mock implements WeatherRepository {}

void main() {
  group('WeatherBloc', () {
    late WeatherRepository weatherRepository;
    late WeatherBloc weatherBloc;

    setUp(() {
      weatherRepository = MockDataService();
      weatherBloc = WeatherBloc(weatherRepository);
    });

    tearDown(() {
      weatherBloc.close();
    });

    blocTest<WeatherBloc, WeatherState>(
      'emits [WeatherLoading, WeatherLoaded] when GetWeatherEvent is '
      'added and DataService returns weather data',
      build: () => weatherBloc,
      act: (bloc) {
        when(() => weatherRepository.getWeather(any())).thenAnswer(
          (_) async => {
            'coord': {'lon': 14.3053, 'lat': 46.6247},
            'weather': [
              {
                'id': 801,
                'main': 'Clouds',
                'description': 'few clouds',
                'icon': '02d',
              }
            ],
            'base': 'stations',
            'main': {
              'temp': 280.06,
              'feels_like': 279.23,
              'temp_min': 279.5,
              'temp_max': 282.15,
              'pressure': 997,
              'humidity': 81,
            },
            'visibility': 10000,
            'wind': {'speed': 1.54, 'deg': 80},
            'clouds': {'all': 20},
            'dt': 1699111934,
            'sys': {
              'type': 1,
              'id': 6875,
              'country': 'AT',
              'sunrise': 1699076894,
              'sunset': 1699112663,
            },
            'timezone': 3600,
            'id': 2774326,
            'name': 'Klagenfurt',
            'cod': 200,
          },
        );
        return bloc.add(GetWeatherEvent('Klagenfurt'));
      },
      expect: () => [isA<WeatherLoading>(), isA<WeatherLoaded>()],
    );

    blocTest<WeatherBloc, WeatherState>(
      'emits [WeatherLoading, WeatherUnknownError] when GetWeatherEvent is '
      'added and DataService returns nothing',
      build: () => weatherBloc,
      act: (bloc) {
        when(() => weatherRepository.getWeather(any())).thenAnswer(
          (_) async => {},
        );
        return bloc.add(GetWeatherEvent('Klagenfurt'));
      },
      expect: () => [isA<WeatherLoading>(), isA<WeatherUnknownError>()],
    );

    blocTest<WeatherBloc, WeatherState>(
      'emits [WeatherLoading, WeatherErrorBadRequest] when GetWeatherEvent is '
      'added and DataService throws BadRequestException',
      build: () => weatherBloc,
      act: (bloc) {
        when(() => weatherRepository.getWeather(any()))
            .thenThrow(BadRequestException());
        return bloc.add(GetWeatherEvent('Klagenfurt'));
      },
      expect: () => [isA<WeatherLoading>(), isA<WeatherErrorBadRequest>()],
    );

    blocTest<WeatherBloc, WeatherState>(
      'emits [WeatherLoading, WeatherErrorServer] when GetWeatherEvent is '
      'added and DataService throws ServerException',
      build: () => weatherBloc,
      act: (bloc) {
        when(() => weatherRepository.getWeather(any()))
            .thenThrow(ServerException());
        return bloc.add(GetWeatherEvent('Klagenfurt'));
      },
      expect: () => [isA<WeatherLoading>(), isA<WeatherErrorServer>()],
    );

    blocTest<WeatherBloc, WeatherState>(
      'emits [WeatherLoading, WeatherErrorNotFound] when GetWeatherEvent '
      'is added and DataService throws NotFoundException',
      build: () => weatherBloc,
      act: (bloc) {
        when(() => weatherRepository.getWeather(any()))
            .thenThrow(NotFoundException());
        return bloc.add(GetWeatherEvent('Klagenfurt'));
      },
      expect: () => [isA<WeatherLoading>(), isA<WeatherErrorNotFound>()],
    );

    blocTest<WeatherBloc, WeatherState>(
      'emits [WeatherLoading, WeatherErrorTooManyRequests] when GetWeatherEvent'
      ' is added and DataService throws TooManyRequestsException',
      build: () => weatherBloc,
      act: (bloc) {
        when(() => weatherRepository.getWeather(any()))
            .thenThrow(TooManyRequestsException());
        return bloc.add(GetWeatherEvent('Klagenfurt'));
      },
      expect: () => [isA<WeatherLoading>(), isA<WeatherErrorTooManyRequests>()],
    );

    blocTest<WeatherBloc, WeatherState>(
      'emits [WeatherLoading, WeatherErrorUnauthorized] when GetWeatherEvent'
      ' is added and DataService throws UnauthorizedException',
      build: () => weatherBloc,
      act: (bloc) {
        when(() => weatherRepository.getWeather(any()))
            .thenThrow(UnauthorizedException());
        return bloc.add(GetWeatherEvent('Klagenfurt'));
      },
      expect: () => [isA<WeatherLoading>(), isA<WeatherErrorUnauthorized>()],
    );
  });
}
