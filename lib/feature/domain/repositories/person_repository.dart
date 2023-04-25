import 'package:dartz/dartz.dart';

import 'package:rick_and_morty/core/error/failure.dart';
import 'package:rick_and_morty/feature/domain/entities/person_entities.dart';

/// Уровень хранилища представляет собой оболочку вокруг одного или
/// нескольких поставщиков данных, с которыми связывается уровень Bloc.
///
/// Определили контракт!
abstract class PersonRepository {
  /// Метод для получения списков персонажей
  ///
  /// (int page) задаем, чтобы получить всех персонажей при вызове метода,
  /// если страницы не указывать, то увидим только 20 персонажей с 1-ой страницы API
  Future<Either<Failure, List<PersonEntities>>> getAllPersons(int page);

  /// Метод для поиска персонажей по имени
  Future<Either<Failure, List<PersonEntities>>> searchPerson(String query);
}

/// Класс для поиска ошибок при реализации методов получения и поиска персонажей
///
/// Пакет dartz, Either<L,R> тип для предоставления любых 2-х типов одновременно,
/// используем для обработки ошибок, но без блока try -> catch
/// <Failure - сбои, Entities - List(PersonEntities)
///
/// Ошибки будет использоваться в нескольких методах и слоях приложения, папка core/error
class PersonRepositoryImpl implements PersonRepository {
  @override
  Future<Either<Failure, List<PersonEntities>>> getAllPersons(int page) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<PersonEntities>>> searchPerson(String query) {
    throw UnimplementedError();
  }
}
