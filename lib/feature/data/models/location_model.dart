import 'package:rick_and_morty/feature/domain/entities/person_entities.dart';

/// Класс для дополнительной обработки параметров origin и location json файла 
/// Реализация
class LocationModel extends LocationEntity {
  LocationModel({name, url}) : super(name: name, url: url);

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(name: json['name'], url: json['url']);
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'url': url};
  }
}
