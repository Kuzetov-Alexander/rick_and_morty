import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:rick_and_morty/common/app_colors.dart';
import 'package:rick_and_morty/feature/presentation/bloc/person_list_cubit/person_list_cubit.dart';
import 'package:rick_and_morty/feature/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:rick_and_morty/feature/presentation/pages/person_screen.dart';
import 'package:rick_and_morty/location_service.dart' as di;
import 'package:rick_and_morty/location_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => sl<PersonListCubit>()..loadPerson()),
          BlocProvider(create: (context) => sl<PersonSearchBloc>()),
        ],
        child: MaterialApp(
          color: AppColors.mainBackground,
          theme: ThemeData.dark().copyWith(
            scaffoldBackgroundColor: AppColors.mainBackground,
          ),
          home: const HomePage(),
        ));
  }
}
