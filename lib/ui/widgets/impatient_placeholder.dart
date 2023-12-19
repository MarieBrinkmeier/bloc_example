import 'package:bloc_example/ui/widgets/rive_animation.dart';
import 'package:flutter/material.dart';

/// A widget to display a Rive animation.
///
/// This widget plays a Rive animation as a placeholder to
/// entertain the user while they wait.
class ImpatientPlaceholder extends StatelessWidget {
  /// Creates a [ImpatientPlaceholder] widget.
  const ImpatientPlaceholder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SimpleRiveAnimation(
      riveFile: 'assets/animations/impatient_placeholder.riv',
    );
  }
}
