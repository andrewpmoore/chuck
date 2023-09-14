import 'package:chuck/src/models/joke.dart';
import 'package:chuck/src/ui/resources/ui_constants.dart';
import 'package:chuck/src/ui/resources/ui_extensions/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

/// Displays the Joke text used on the pages which call the 'random' endpoint where there's more screen space to display them
class JokeDisplay extends StatelessWidget {

  final Joke? joke;

  const JokeDisplay({Key? key, required this.joke}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    String jokeText = joke?.value??'';
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Sizes.p16),
      child: TextAnimator(
        incomingEffect: WidgetTransitionEffects(opacity: 0.5, scale: 0.9),
        initialDelay: const Duration(milliseconds: 700),
        characterDelay: (jokeText).length > 100 ? const Duration(milliseconds: 5) : const Duration(milliseconds: 20),
        spaceDelay: (jokeText).length > 100 ? const Duration(milliseconds: 10) : const Duration(milliseconds: 40),
        jokeText,
        style: context.style.titleLarge!.copyWith(color: joke?.isFake??false ? context.colorScheme.error : null), //if the joke is a 'fake/error' joke, then change the text color
        textAlign: TextAlign.center,
      ),
    );
  }
}
