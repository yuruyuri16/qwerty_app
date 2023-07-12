part of 'home_bloc.dart';

enum HomeStatus {
  initial,
  loading,
  success,
  failure;

  bool get isInitial => this == HomeStatus.initial;
  bool get isLoading => this == HomeStatus.loading;
  bool get isSuccess => this == HomeStatus.success;
  bool get isFailure => this == HomeStatus.failure;
}

class HomeState extends Equatable {
  const HomeState({
    this.status = HomeStatus.initial,
    this.characters = const [],
    this.page = 1,
    this.hasReachedCharactersLimit = false,
  });

  final HomeStatus status;
  final List<Character> characters;
  final int page;
  final bool hasReachedCharactersLimit;

  @override
  List<Object> get props => [
        status,
        characters,
        page,
        hasReachedCharactersLimit,
      ];

  HomeState copyWith({
    HomeStatus? status,
    List<Character>? characters,
    int? page,
    bool? hasReachedCharactersLimit,
  }) {
    return HomeState(
      status: status ?? this.status,
      characters: characters ?? this.characters,
      page: page ?? this.page,
      hasReachedCharactersLimit:
          hasReachedCharactersLimit ?? this.hasReachedCharactersLimit,
    );
  }
}
