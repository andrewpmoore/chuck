import 'package:chuck/src/ui/resources/ui_extensions/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

/// Displays the Joke text used on the pages which call the 'random' endpoint where there's more screen space to display them
class JokeDisplay extends StatelessWidget {
  final String jokeText;

  const JokeDisplay({Key? key, required this.jokeText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextAnimator(
      incomingEffect: WidgetTransitionEffects(opacity: 0.5, scale: 0.9),
      initialDelay: const Duration(milliseconds: 700),
      characterDelay: (jokeText ?? '').length > 100 ? const Duration(milliseconds: 5) : const Duration(milliseconds: 20),
      spaceDelay: (jokeText ?? '').length > 100 ? const Duration(milliseconds: 10) : const Duration(milliseconds: 40),
      jokeText,
      style: context.style.titleLarge,
      textAlign: TextAlign.center,
    );
  }
}
