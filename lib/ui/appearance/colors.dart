import 'package:flutter/material.dart';

/// A custom color palette for the weather application.
class WeatherColors {
  /// A MaterialColor representing various shades of beige.
  ///
  /// The primary beige color is: 0xFFF5F5DC.
  static const MaterialColor beige = MaterialColor(
    0xFFe7deb5,
    <int, Color>{
      50: Color(0xFFf1ebd3),
      100: Color(0xFFeee8cb),
      200: Color(0xFFece5c4),
      300: Color(0xFFece5c4),
      400: Color(0xFFe9e1bc),
      500: Color(0xFFe7deb5),
      600: Color(0xFFd0c8a3),
      700: Color(0xFFb9b291),
      800: Color(0xFFa29b7f),
      900: Color(0xFF8b856d),
    },
  );

  /// A Color representing red.
  static const Color red = Color(0xFFFFB4AB);
}
