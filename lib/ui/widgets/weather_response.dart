import 'package:bloc_example/interactions/weather_bloc/weather_bloc.dart';
import 'package:bloc_example/ui/appearance/colors.dart';
import 'package:bloc_example/ui/widgets/impatient_placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// A widget to display the weather response.
///
/// This widget listens to the [WeatherBloc] and rebuilds
/// whenever the [WeatherState] changes.
/// It displays different UI depending on the current state:
/// - A placeholder when the state is [WeatherInitial]
/// - A text widget with weather information when state is [WeatherLoaded].
/// - A loading indicator when state is [WeatherLoading].
/// - Error messages for various error states.
class WeatherResponse extends StatelessWidget {
  /// Creates a [WeatherResponse] widget.
  const WeatherResponse({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Center(
        child: BlocBuilder<WeatherBloc, WeatherState>(
          builder: (context, state) {
            if (state is WeatherLoaded) {
              return Column(
                children: [
                  Image.network(
                    'https://openweathermap.org/img/wn/${state.weatherModel.weather[0].icon}@2x.png',
                  ),
                  Text(
                    'Weather: ${state.weatherModel.weather[0].description}\n'
                    'Temperature: ${state.weatherModel.main.temp}°C',
                    style: const TextStyle(fontSize: 24),
                  ),
                ],
              );
            } else if (state is WeatherLoading) {
              return const CircularProgressIndicator();
            } else if (state is WeatherUnknownError) {
              return const Text(
                'An unknown error occurred.',
                style: TextStyle(fontSize: 24, color: WeatherColors.red),
              );
            } else if (state is WeatherErrorBadRequest) {
              return const Text(
                'Some mandatory parameters are missing.',
                style: TextStyle(fontSize: 24, color: WeatherColors.red),
              );
            } else if (state is WeatherErrorUnauthorized) {
              return const Text(
                'Your API token seems to be wrong.',
                style: TextStyle(fontSize: 24, color: WeatherColors.red),
              );
            } else if (state is WeatherErrorNotFound) {
              return const Text(
                'Your city seems to be unknown.',
                style: TextStyle(fontSize: 24, color: WeatherColors.red),
              );
            } else if (state is WeatherErrorTooManyRequests) {
              return const Text(
                'You are a bit too active ;). '
                'You reached your request limit.',
                style: TextStyle(fontSize: 24, color: WeatherColors.red),
              );
            } else if (state is WeatherErrorServer) {
              return const Text(
                'Ooops the server seems to be down.',
                style: TextStyle(fontSize: 24, color: WeatherColors.red),
              );
            }
            return const ImpatientPlaceholder();
          },
        ),
      ),
    );
  }
}
