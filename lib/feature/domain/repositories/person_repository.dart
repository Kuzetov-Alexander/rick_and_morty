import 'package:dartz/dartz.dart';
import 'package:rick_and_morty/core/error/failure.dart';
import 'package:rick_and_morty/feature/domain/entities/person_entities.dart';

abstract class PersonRepository {
  Future<Either<Failure, List<PersonEntities>>> getAllPersons(int page);
  Future<Either<Failure, List<PersonEntities>>> searchPerson(String query);
}

// 1.2