import 'dart:convert';
import 'package:rick_and_morty/core/error/exception.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rick_and_morty/feature/data/models/person_model.dart';

/// Класс для получения кеша
abstract class PersonLocalDataSource {
  Future<List<PersonModel>> getLastPersonFromCache();
  Future<dynamic> personsToCache(List<PersonModel> persons);
}

const cachedPersonsList = 'cached_persons_list';

class PersonLocalDataSourceImpl implements PersonLocalDataSource {
  final SharedPreferences sharedPreferences;

  PersonLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<PersonModel>> getLastPersonFromCache() {
    final jsonPersonsList = sharedPreferences.getStringList(cachedPersonsList);
    if (jsonPersonsList != null) {
      return Future.value(jsonPersonsList
          .map((person) => PersonModel.fromJson(json.decode(person)))
          .toList());
    } else {
      throw CacheException();
    }
  }

  @override
  Future<dynamic> personsToCache(List<PersonModel> persons) async {
    final List<String> jsonPersonsList =
        persons.map((persons) => json.encode(persons.toJson())).toList();

    sharedPreferences.setStringList(cachedPersonsList, jsonPersonsList);
    print('Персонажи записываются в кэш ${jsonPersonsList.length}');
    return Future.value(jsonPersonsList);
  }
}
