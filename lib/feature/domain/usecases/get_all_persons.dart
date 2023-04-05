// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:rick_and_morty/core/error/failure.dart';
import 'package:rick_and_morty/core/uscases/usecase.dart';
import 'package:rick_and_morty/feature/domain/entities/person_entities.dart';
import 'package:rick_and_morty/feature/domain/repositories/person_repository.dart';

class GetAllPersons extends UseCase<List<PersonEntities>, PagePersonParams> {
  final PersonRepository personRepository;

  GetAllPersons({required this.personRepository});

  @override
  Future<Either<Failure, List<PersonEntities>>> call(
      PagePersonParams params) async {
    return await personRepository.getAllPersons(params.page);
  }
}

class PagePersonParams extends Equatable {
  final int page;

  const PagePersonParams({required this.page});

  @override
  List<Object?> get props => [page];
}

// 1.3