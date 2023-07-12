import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qwerty_app/home/home.dart';
import 'package:rick_and_morty_repository/rick_and_morty_repository.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeBloc(
        rickAndMortyRepository: context.read<RickAndMortyRepository>(),
      )..add(const HomeCharactersRequested()),
      child: const HomeView(),
    );
  }
}
