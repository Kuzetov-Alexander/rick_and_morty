import 'package:bloc/bloc.dart';
import 'package:rick_and_morty/core/error/failure.dart';
import 'package:rick_and_morty/feature/domain/entities/person_entities.dart';

import 'package:rick_and_morty/feature/domain/usecases/get_all_persons.dart';
import 'package:rick_and_morty/feature/presentation/bloc/person_list_cubit/person_list_state.dart';
import 'package:rick_and_morty/feature/presentation/bloc/search_bloc/search_bloc.dart';

class PersonListCubit extends Cubit<PersonState> {
  final GetAllPersons getAllPersons;

  PersonListCubit({required this.getAllPersons}) : super(PersonEmpty());

  int page = 1;

  void loadPerson() async {
    if (state is Personloading) return;

    final currentState = state;
    var oldPerson = <PersonEntities>[];

    if (currentState is PersonLoaded) {
      oldPerson = currentState.personList;
    }
    emit(Personloading(oldPerson, isFirstFetch: page == 1));

    final failureOrPerson = await getAllPersons(PagePersonParams(page: page));

    failureOrPerson.fold(
        (error) => emit(PersonError(message: _mapFailureToMessage(error))),
        (character) {
      page++;
      final persons = (state as Personloading).oldPersonList;
      persons.addAll(character);
      emit(PersonLoaded(personList: persons));
    });
  }

  _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return serverFailureMessage;
      case CacheFailure:
        return cachedFailureMessage;
    }
  }
}
