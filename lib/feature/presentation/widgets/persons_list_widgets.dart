import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/feature/domain/entities/person_entities.dart';
import 'package:rick_and_morty/feature/presentation/bloc/person_list_cubit/person_list_cubit.dart';
import 'package:rick_and_morty/feature/presentation/bloc/person_list_cubit/person_list_state.dart';
import 'package:rick_and_morty/feature/presentation/widgets/person_card_widget.dart';

/// Класс отображения индикатора загрузки для картинок
class PersonsList extends StatelessWidget {
  final scrollController = ScrollController();
  PersonsList({super.key});

  void setupScrollController(BuildContext context) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          context.read<PersonListCubit>().loadPerson();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    setupScrollController(context);
    return BlocBuilder<PersonListCubit, PersonState>(builder: (context, state) {
      List<PersonEntities> persons = [];
      bool isLoading = false;
      if (state is Personloading && state.isFirstFetch) {
        return _loadingIndicator();
      } else if (state is Personloading) {
        persons = state.oldPersonList;
        isLoading = true;
      } else if (state is PersonLoaded) {
        persons = state.personList;
      } else if (state is PersonError) {
        return Text(
          state.message,
          style: const TextStyle(fontSize: 25),
        );
      }
      return ListView.separated(
        controller: scrollController,
        itemBuilder: (context, index) {
          if (index < persons.length) {
            return PersonCard(person: persons[index]);
          } else {
            Timer(const Duration(milliseconds: 30), () {
              scrollController
                  .jumpTo(scrollController.position.maxScrollExtent);
            });
            return _loadingIndicator();
          }
        },
        separatorBuilder: (context, index) {
          return Divider(color: Colors.grey.shade400);
        },
        itemCount: persons.length + (isLoading ? 1 : 0),
      );
    });
  }

  Widget _loadingIndicator() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(child: CircularProgressIndicator()),
    );
  }
}
