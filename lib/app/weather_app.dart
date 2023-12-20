import 'package:bloc_example/interactions/weather_bloc/weather_bloc.dart';
import 'package:bloc_example/repositories/weather_repository.dart';
import 'package:bloc_example/ui/appearance/colors.dart';
import 'package:bloc_example/ui/views/weather_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// This app is supposed to show actual weather
/// information for the selected city
class MyWeatherApp extends StatelessWidget {
  /// This app is supposed to show actual weather
  /// information for the selected city
  const MyWeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    final httpService = WeatherRepository(
      'https://api.openweathermap.org/data/2.5/',
    );
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: false,
        primarySwatch: WeatherColors.beige,
      ),
      home: BlocProvider(
        create: (context) => WeatherBloc(httpService),
        child: WeatherView(),
      ),
    );
  }
}
