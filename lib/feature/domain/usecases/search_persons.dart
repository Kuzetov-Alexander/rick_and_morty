// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:rick_and_morty/core/error/failure.dart';
import 'package:rick_and_morty/core/uscases/usecase.dart';
import 'package:rick_and_morty/feature/domain/entities/person_entities.dart';
import 'package:rick_and_morty/feature/domain/repositories/person_repository.dart';

class SearchPerson extends UseCase<List<PersonEntities>, SearchPersonParams> {
  final PersonRepository personRepository;

  SearchPerson({required this.personRepository});

  @override
  Future<Either<Failure, List<PersonEntities>>> call(
      SearchPersonParams params) async {
    return await personRepository.searchPerson(params.query);
  }
}

class SearchPersonParams extends Equatable {
  final String query;

  const SearchPersonParams({required this.query});

  @override
  List<Object?> get props => [query];
}
