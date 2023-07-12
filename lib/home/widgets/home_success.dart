import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qwerty_app/home/home.dart';

class HomeSuccess extends StatefulWidget {
  const HomeSuccess({super.key});

  @override
  State<HomeSuccess> createState() => _HomeSuccessState();
}

class _HomeSuccessState extends State<HomeSuccess> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<HomeBloc>().add(const HomeCharactersRequested());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;

    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.8);
  }

  @override
  Widget build(BuildContext context) {
    final characters = context.select((HomeBloc bloc) => bloc.state.characters);
    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.lg,
        AppSpacing.lg,
        0,
      ),
      itemCount: characters.length,
      itemBuilder: (_, index) {
        final character = characters[index];
        return CharacterCard(character: character);
      },
    );
  }
}
