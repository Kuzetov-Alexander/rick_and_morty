import 'dart:convert';
import 'package:rick_and_morty/core/error/exception.dart';
import 'package:rick_and_morty/feature/data/models/person_model.dart';
import 'package:http/http.dart' as http;

/// Класс, который объявляет методы для https запроса и поиска персонажа
///
/// Контрактный класс
///
/// ![Архитектура](https://camo.githubusercontent.com/34a0c4190b51874546bc4260e6dee4bb6d8d67045fb08deb4ae78e84b94e7b31/68747470733a2f2f6d69726f2e6d656469756d2e636f6d2f6d61782f3535362f302a7a55745a59694a3162445475674f5959)
abstract class PersonRemoteDataSource {
  /// Вызывает https://rickandmortyapi.com/api/character/?page=1
  ///
  /// Выдает [ServerException] - в core/error/exception для всех ошибок в коде
  Future<List<PersonModel>> getAllPersons(int page);

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
  ///
  /// Можно легко заменить URL на другой и приложение не пострадает или поменять на запрос GraphQL
  @override
  Future<List<PersonModel>> getAllPersons(int page) => _getPersonFromUrl(
      'https://rickandmortyapi.com/api/character/?page=$page');

  /// Метод реализует поисск персонажа
  @override
  Future<List<PersonModel>> searchPerson(String query) => _getPersonFromUrl(
      'https://rickandmortyapi.com/api/character/?name=$query');

  Future<List<PersonModel>> _getPersonFromUrl(String url) async {
    print(url);
    final response = await client
        .get(Uri.parse(url), headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      final persons = json.decode(response.body);
      return (persons['results'] as List)
          .map((person) => PersonModel.fromJson(person))
          .toList();
    } else {
      throw ServerException();
    }
  }
}
