import 'package:bloc_example/interactions/weather_bloc/weather_bloc.dart';
import 'package:bloc_example/ui/widgets/weather_response.dart';
import 'package:bloc_example/utilities/url_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// A widget which represents the weather screen.
///
/// This screen allows the user to input a city name, fetch the weather data
/// for that city, and view the fetched weather data.
class WeatherView extends StatelessWidget {
  /// Creates a [WeatherView] instance.
  WeatherView({super.key});

  /// Controller for the city input text field.
  final TextEditingController cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(title: const Text('Weather App')),
      body: BlocListener<WeatherBloc, WeatherState>(
        listener: (context, state) {
          if (state is WeatherError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: ${state.errorMessage}')),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            children: [
              const WeatherResponse(),
              SizedBox(
                width: 200,
                child: TextField(
                  controller: cityController,
                  decoration: const InputDecoration(labelText: 'Enter city'),
                  textInputAction: TextInputAction.next,
                ),
              ),
              const SizedBox(
                height: 50,
                width: double.infinity,
              ),
              ElevatedButton(
                onPressed: () {
                  context
                      .read<WeatherBloc>()
                      .add(GetWeatherEvent(cityController.text));
                },
                child: const Text('Get Weather'),
              ),
              const SizedBox(
                height: 50,
              ),
              const Spacer(),
              BlocBuilder<WeatherBloc, WeatherState>(
                buildWhen: (previous, current) {
                  return current is WeatherInitial ||
                      previous is WeatherInitial;
                },
                builder: (context, state) {
                  if (state is WeatherInitial) {
                    return TextButton(
                      onPressed: () {
                        UrlService.launchUrl(
                          'https://rive.app/community/2492-5015-impatient-placeholder/',
                        );
                      },
                      child:
                          const Text('Impatient Placeholder by rockingelevator '
                              'under CC BY License'),
                    );
                  }
                  return const SizedBox();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
