import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:qwerty_app/app/app.dart';
import 'package:qwerty_app/l10n/l10n.dart';
import 'package:rick_and_morty_repository/rick_and_morty_repository.dart';
import 'package:user_repository/user_repository.dart';

class App extends StatelessWidget {
  const App({
    required UserRepository userRepository,
    required RickAndMortyRepository rickAndMortyRepository,
    required User user,
    super.key,
  })  : _userRepository = userRepository,
        _rickAndMortyRepository = rickAndMortyRepository,
        _user = user;

  final UserRepository _userRepository;
  final RickAndMortyRepository _rickAndMortyRepository;
  final User _user;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: _userRepository),
        RepositoryProvider.value(value: _rickAndMortyRepository),
      ],
      child: BlocProvider(
        create: (_) => AppBloc(userRepository: _userRepository, user: _user),
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  late final GoRouter _router;

  @override
  void initState() {
    _router = AppRouter(context.read<AppBloc>()).router;
    super.initState();
  }

  @override
  void dispose() {
    _router.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      theme: AppTheme.theme,
      darkTheme: AppTheme.darkTheme,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
