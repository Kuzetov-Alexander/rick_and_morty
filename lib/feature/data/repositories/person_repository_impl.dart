import 'package:dartz/dartz.dart';
import 'package:rick_and_morty/core/error/exception.dart';
import 'package:rick_and_morty/core/error/failure.dart';
import 'package:rick_and_morty/core/platform/network_info.dart';
import 'package:rick_and_morty/feature/data/datasources/person_local_data_source.dart';
import 'package:rick_and_morty/feature/data/datasources/person_remote_data_source.dart';
import 'package:rick_and_morty/feature/data/models/person_model.dart';
import 'package:rick_and_morty/feature/domain/entities/person_entities.dart';
import 'package:rick_and_morty/feature/domain/repositories/person_repository.dart';

class PersonRepositoryImpl implements PersonRepository {
  final PersonRemoteDataSource remoteDateSource;
  final PersonLocalDataSource localDateSource;
  final NetworkInfo networkInfo;

  PersonRepositoryImpl({
    required this.remoteDateSource,
    required this.localDateSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<PersonEntities>>> getAllPersons(int page) async {
    return _getPersons(() {
      return remoteDateSource.getAllPersons(page);
    });
  }

  @override
  Future<Either<Failure, List<PersonEntities>>> searchPerson(
      String query) async {
    return _getPersons(() {
      return remoteDateSource.searchPerson(query);
    });
  }

  /// Тело методов
  Future<Either<Failure, List<PersonModel>>> _getPersons(
      Future<List<PersonModel>> Function() getPersons) async {
    if (await networkInfo.isConnected) {
      try {
        final remotePerson = await getPersons();
        localDateSource.personsToCache(remotePerson);
        return Right(remotePerson);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final locationPerson = await localDateSource.getLastPersonFromCache();
        return Right(locationPerson);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
