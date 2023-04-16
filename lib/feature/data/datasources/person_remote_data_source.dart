import 'dart:convert';
import 'package:rick_and_morty/core/error/exception.dart';
import 'package:rick_and_morty/feature/data/models/person_model.dart';
import 'package:http/http.dart' as http;


/// Класс, который объявляет методы для https запроса и поиска персонажа
/// 
/// Контрактный класс
abstract class PersonRemoteDataSource {

  /// Вызывает https://rickandmortyapi.com/api/character/?page=1
  /// 
  /// Выдает [ServerException] - в core/error/exception для всех ошибок в коде
  Future<List<PersonModel>> getAllPersons(int age);

  /// Вызывает https://rickandmortyapi.com/api/character/?name=rick
  /// 
  /// Выдает [ServerException] для всех ошибок в коде
  Future<List<PersonModel>> searchPerson(String query);
}

/// Класс, который реализует https запрос и поиск персонажа
class PersonRemoteDataSourceImpl implements PersonRemoteDataSource {
  final http.Client client;

  PersonRemoteDataSourceImpl({required this.client});

/// Метод реализует https запрос
  @override
  Future<List<PersonModel>> getAllPersons(int age) async {
    final response = await client.get(
        Uri.parse('https://rickandmortyapi.com/api/character/?page=1'),
        headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      final persons = jsonDecode(response.body);
      return (persons['results'] as List)
          .map((person) => PersonModel.fromJson(person))
          .toList();
    } else {
      throw ServerException();
    }
  }

/// Метод реализует поисск персонажа
  @override
  Future<List<PersonModel>> searchPerson(String query) {
    throw UnimplementedError();
  }
}
