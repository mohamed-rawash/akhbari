import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubit/cache_helper.dart';
import 'package:news_app/cubit/dio_helper.dart';
import 'package:news_app/screens/business_screen.dart';
import 'package:news_app/screens/home.dart';
import 'package:news_app/screens/science_screen.dart';
import 'package:news_app/screens/sports_screen.dart';
import 'package:news_app/widgets/theme_service.dart';

import 'cubit/bloc_observer.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..getSharedData(key: 'isDark')..getBusinessData(),
      child: BlocConsumer<AppCubit, NewsStates>(
        listener: (context, state) {},
        builder: (context, state) {

          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeService.light(),
            darkTheme: ThemeService.dark(),
            themeMode:AppCubit.get(context).isDark? ThemeMode.dark: ThemeMode.light,
            home: Directionality(
              textDirection: TextDirection.ltr,
              child: Home(),
            ),
            routes: {
              Home.routeName: (_) => Home(),
              BusinessScreen.routeName: (_) => BusinessScreen(),
              ScienceScreen.routeName: (_) => ScienceScreen(),
              SportsScreen.routeName: (_) => SportsScreen(),
            },
          );
        },
      ),
    );
  }
}

