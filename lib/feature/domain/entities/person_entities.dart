import 'package:equatable/equatable.dart';

/// Независимый уровень приложения.
///
/// Пишем тут бизнес объект с его параметрами.
///
/// [API с сайта](https://rickandmortyapi.com/documentation/#filter-characters)
///
///![Архитектура](https://camo.githubusercontent.com/34a0c4190b51874546bc4260e6dee4bb6d8d67045fb08deb4ae78e84b94e7b31/68747470733a2f2f6d69726f2e6d656469756d2e636f6d2f6d61782f3535362f302a7a55745a59694a3162445475674f5959)

class PersonEntities extends Equatable {
  final int id;
  final String name;
  final String status;
  final String species;
  final String type;
  final String gender;
  final LocationEntity? origin;
  final LocationEntity? location;
  final String image;
  final List<String> episode;
  final DateTime created;

  const PersonEntities({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.origin,
    required this.location,
    required this.image,
    required this.episode,
    required this.created,
  });

  /// Equatable пакет, метод, чтобы сравнивать объекты класса [==]
  /// в зависимости от изменения его парметров
  @override
  List<Object?> get props => [
        id,
        name,
        status,
        species,
        type,
        gender,
        origin,
        location,
        image,
        episode,
        created,
      ];
}

/// Класс, чтобы дополнительно распарсить json [origin] и [location]
/// по идее нам нужен только параметр name
class LocationEntity {
  final String name;
  final String url;

  const LocationEntity({required this.name, required this.url});
}
