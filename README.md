# rick_and_morty

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


# Architecture

## Presentation 

   Уровень содержит виджеты для отображения их на экране, а также их состояния .
   Виджеты будут отправлять события в блок и прослушавать состояния, в зависимости от события будет отображаться то или иное состояние, которое будет вляет на отображение пользовательского интерфейса. 
   Bloc - для управления состоянием.

   presentation -> 
     bloc
     pages
     widgets

## Domain

   Первозданный центр приложения, полностью самодостаточен и не зависит от других уровней. Но все остальные уровни зависят от него.
   Ему должно быть все равно изменю ли я firebase на RestApi или перейду с базы данных Hive на SQLite.

   Содержит только основную бизнес логику UseCase и бизнес объекты Entities.
   UseCase - инкапсулируют всю бизнес логику приложения каждого конкретного сценария приложения. Получение списка персонажей, поиск персонажей, также реализуют поток данных в и из Entities для реализации бизнес правил.

   Repositories - абстрактный класс в Domain, а фактическая реализация находится в Data уровне. Будет создан как бы контракт для передачи данных через границу уровней данных, это и есть принцип зависимостей. 
   Работает по принципу инверсии зависимостей - границы между уровнями должны обрабатываться с помощью интерфейсов - асбтрактные классы.
   
   
   Failures - Уровень является местом сбоев, которые нужно обработать.

   domain -> 
   entities
   usecases
   repositories

## Data

   Уровень данных состоит из репозитория, в котором реализуем контракт из доменного уровня, а также содержит источники данных для: получения API с сервера, а другой для кэширования данных.
   Репозиторий - это место, где вы решаете возвращать свежие данные или кэшированные, когда их возвращать и тд.
   model - расширяют сущности и добавляют методы toJson(), fromJson и поля.
   Информацию о персонажей будем получать в json, поэтому источники данных - модели, ведь для преобразования не обработанных данных требуется код сериализаации, десериализации Json, чтобы он не находился в DomainEntities.
   Политика КЭШирования - если есть интернет, то всегда будем получать данные из API и кэшировать их, если нет сети - возвращаем последние кэш данные.

   data -> 
     models
     datasources
     repositories

   
   


