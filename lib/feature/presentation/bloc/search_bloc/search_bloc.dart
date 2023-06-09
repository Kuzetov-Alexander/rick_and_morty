import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/core/error/failure.dart';
import 'package:rick_and_morty/feature/domain/usecases/search_persons.dart';

import 'package:rick_and_morty/feature/presentation/bloc/search_bloc/search_event.dart';
import 'package:rick_and_morty/feature/presentation/bloc/search_bloc/search_state.dart';

const serverFailureMessage = 'Server failure';
const cachedFailureMessage = 'Cache failure';

class PersonSearchBloc extends Bloc<PersonSearchEvent, PersonSearchState> {
  final SearchPerson searchPerson;

  PersonSearchBloc({required this.searchPerson}) : super(PersonSearchEmpty()) {
    on<SearchPersons>((event, emit) async {
      emit(PersonSearchLoading());
      final failureOrPerson =
          await searchPerson(SearchPersonParams(query: event.personQuery));
      emit(failureOrPerson.fold(
          (failure) =>
              PersonSearchError(message: _mapFailureToMessage(failure)),
          (person) => PersonSearchLoaded(persons: person)));
    });
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return serverFailureMessage;
      case CacheFailure:
        return cachedFailureMessage;
      default:
        return 'Unexpected Error';
    }
  }
}
