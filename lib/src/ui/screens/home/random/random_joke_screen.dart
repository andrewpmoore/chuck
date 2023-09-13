import 'package:chuck/src/business/random_joke_provider.dart';
import 'package:chuck/src/ui/resources/ui_constants.dart';
import 'package:chuck/src/ui/resources/ui_extensions/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class RandomJokeScreen extends StatelessWidget {
  const RandomJokeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RandomJokeProvider(),
      child: const _RandomJoke(),
    );
  }
}


class _RandomJoke extends StatelessWidget {
  const _RandomJoke({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          gapH32,
          Row(
            children: [
              const Expanded(child: SizedBox()),
              ElevatedButton(
                  onPressed: () async {
                    context.read<RandomJokeProvider>().fetchAJoke();
                  },
                  child: Text(context.loc!.random)),
              const Expanded(child: SizedBox()),
            ],
          ),
          gapH16,
          context.watch<RandomJokeProvider>().busy ? const CircularProgressIndicator.adaptive() : Padding(
            padding: const EdgeInsets.symmetric(horizontal: Sizes.p16),
            child: Text(context.watch<RandomJokeProvider>().joke?.value??'', style: context.style.titleLarge, textAlign: TextAlign.center,),
          )
        ],
      ),
    );
  }
}
