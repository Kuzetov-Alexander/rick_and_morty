// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:rick_and_morty/feature/domain/entities/person_entities.dart';

abstract class PersonState extends Equatable {
  const PersonState();

  @override
  List<Object?> get props => [];
}

class PersonEmpty extends PersonState {
  @override
  List<Object?> get props => [];
}

class Personloading extends PersonState {
  final List<PersonEntities> oldPersonList;
  final bool isFirstFetch;

  const Personloading(this.oldPersonList, {this.isFirstFetch = false});

  @override
  List<Object?> get props => [oldPersonList];
}

class PersonLoaded extends PersonState {
  final List<PersonEntities> personList;

  const PersonLoaded({required this.personList});

  @override
  List<Object?> get props => [personList];
}

class PersonError extends PersonState {
  final String message;

  const PersonError({required this.message});

  @override
  List<Object?> get props => [message];
}
