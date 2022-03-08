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
import 'package:news_app/screens/setting_screen.dart';
import 'package:news_app/screens/sports_screen.dart';

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
            theme: ThemeData(
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: const AppBarTheme(
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.white,
                    statusBarIconBrightness: Brightness.dark,
                  ),
                  iconTheme: IconThemeData(
                    color: Colors.black87,
                    size: 24,
                  ),
                  actionsIconTheme: IconThemeData(
                    color: Colors.black87,
                    size: 24,
                  ),
                  backgroundColor: Colors.white,
                  elevation: 0.0,
                  titleTextStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  )
              ),
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                elevation: 10.0,
                unselectedItemColor: Colors.black,
              ),
              textTheme: const TextTheme(
                bodyText1: TextStyle(
                  fontSize:20,
                  color: Colors.black,
                ),
                headline1: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
                headline2:  TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
                headline3: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
            ),
            darkTheme: ThemeData(
              scaffoldBackgroundColor: Colors.black87,
              appBarTheme: const AppBarTheme(
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.black87,
                    statusBarIconBrightness: Brightness.light,
                  ),
                  iconTheme: IconThemeData(
                    color: Colors.white,
                    size: 24,
                  ),
                  actionsIconTheme: IconThemeData(
                    color: Colors.white,
                    size: 24,
                  ),
                  backgroundColor: Colors.black,
                  elevation: 0.0,
                  titleTextStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  )
              ),

              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                elevation: 10.0,
                unselectedItemColor: Colors.grey,
                backgroundColor: Colors.black87,
              ),
              textTheme: const TextTheme(
                bodyText1: TextStyle(
                  fontSize:20,
                  color: Colors.white,
                ),
                headline1: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
                headline2:  TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
                headline3: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            ),
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
              SettingScreen.routeName: (_) => SettingScreen(),
            },
          );
        },
      ),
    );
  }
}

