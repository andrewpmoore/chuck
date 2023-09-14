import 'package:chuck/main.dart';
import 'package:chuck/src/business/joke_provider.dart';
import 'package:chuck/src/models/joke.dart';
import 'package:chuck/src/ui/resources/ui_constants.dart';
import 'package:chuck/src/ui/resources/ui_extensions/build_context_extension.dart';
import 'package:chuck/src/ui/widgets/joke_display.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';


class RandomJokeScreen extends StatelessWidget {
  const RandomJokeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => JokeProvider(jokesApi),
      child: const _RandomJoke(),
    );
  }
}


class _RandomJoke extends StatelessWidget {
  const _RandomJoke({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Joke? joke = context.watch<JokeProvider>().joke;
    return SingleChildScrollView(
      child: Column(
        children: [
          gapH32,
          Row(
            children: [
              const Expanded(child: SizedBox()),
              WidgetAnimator(
                incomingEffect: WidgetTransitionEffects.incomingSlideInFromBottom(),
                child: ElevatedButton(
                    onPressed: () async {
                      context.read<JokeProvider>().fetchAJoke();
                    },
                    child: Text(context.loc!.random)),
              ),
              const Expanded(child: SizedBox()),
            ],
          ),
          gapH16,
          context.watch<JokeProvider>().busy ? const CircularProgressIndicator.adaptive() : JokeDisplay(joke: joke, key: ValueKey('${joke?.value??''}_${context.isAppInDarkMode}'),)
        ],
      ),
    );
  }
}
