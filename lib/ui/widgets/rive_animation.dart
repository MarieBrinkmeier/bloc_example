import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

/// A widget to display a Rive animation.
///
/// This widget plays a Rive animation.
class SimpleRiveAnimation extends StatelessWidget {
  /// Creates a [SimpleRiveAnimation] widget.
  ///
  /// The [riveFile] argument must not be null and should point to a valid
  /// Rive animation file.
  const SimpleRiveAnimation({
    required this.riveFile,
    super.key,
  });

  /// The path to the Rive animation file.
  final String riveFile;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: 200,
      child: RiveAnimation.asset(
        riveFile,
        fit: BoxFit.cover,
      ),
    );
  }
}
