import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:rick_and_morty_repository/rick_and_morty_repository.dart';
import 'package:stream_transform/stream_transform.dart';

part 'home_event.dart';
part 'home_state.dart';

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({
    required RickAndMortyRepository rickAndMortyRepository,
  })  : _rickAndMortyRepository = rickAndMortyRepository,
        super(const HomeState()) {
    on<HomeCharactersRequested>(
      _onCharactersRequested,
      transformer: throttleDroppable(const Duration(milliseconds: 100)),
    );
  }

  final RickAndMortyRepository _rickAndMortyRepository;

  Future<void> _onCharactersRequested(
    HomeCharactersRequested event,
    Emitter<HomeState> emit,
  ) async {
    if (state.hasReachedCharactersLimit) return;

    final hasReachedCharactersLimit = state.page > 42;
    if (hasReachedCharactersLimit) {
      emit(
        state.copyWith(hasReachedCharactersLimit: hasReachedCharactersLimit),
      );
      return;
    }

    if (state.status.isInitial) {
      emit(state.copyWith(status: HomeStatus.loading));
    }

    try {
      final characters = await _rickAndMortyRepository.getCharacters(
        page: state.page,
      );
      emit(
        state.copyWith(
          status: HomeStatus.success,
          characters: [...state.characters, ...characters],
          page: state.page + 1,
        ),
      );
    } catch (error, stackTrace) {
      emit(state.copyWith(status: HomeStatus.failure));
      addError(error, stackTrace);
    }
  }
}
