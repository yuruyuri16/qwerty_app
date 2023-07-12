import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qwerty_app/home/home.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          final status = state.status;
          if (status.isInitial) {
            return const HomeInitial();
          } else if (status.isLoading) {
            return const HomeLoading();
          } else if (status.isSuccess) {
            return const HomeSuccess();
          } else {
            return const HomeFailure();
          }
        },
      ),
    );
  }
}
