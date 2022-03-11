import 'package:bloc/bloc.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubit/cache_helper.dart';
import 'package:news_app/cubit/states.dart';
import 'package:news_app/screens/business_screen.dart';
import 'package:news_app/screens/science_screen.dart';
import 'package:news_app/screens/sports_screen.dart';

import 'dio_helper.dart';


class AppCubit extends Cubit<NewsStates>{
  AppCubit() : super(InitialState());
  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  bool isDark = false;
  String? query;

  List<Widget> screens = [
    BusinessScreen(),
    ScienceScreen(),
    SportsScreen(),
  ];

  void changeBottomNavBar(int index){
    currentIndex = index;
    if(currentIndex == 1)
      getScienceData();
    if(currentIndex == 2)
      getSportsData();
    emit(AppBottomNavState());
  }

  List<dynamic> business = [];
  List<dynamic> science = [];
  List<dynamic> sports = [];
  List<dynamic> allData = [];
  List<dynamic> searchedData = [];

  void getBusinessData(){
    emit(AppLoadingState());
    DioHelper.getData(
      url:'v2/top-headlines',
      query: {
        'country': 'eg',
        'category': 'business',
        'apiKey': '642384f5283a4018a6958df5c4d195c5'
      },
    ).then((value) {
      business = value.data['articles'];
      business.forEach((element) => allData.add(element));
      emit(AppGetBusinessSuccessState());
    }).catchError((error){
      emit(AppGetBusinessErrorState(error.toString()));
      },
    );
  }

  void getScienceData(){
    if(science.length == 0){
      emit(AppLoadingState());
      DioHelper.getData(
        url:'v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'science',
          'apiKey': '642384f5283a4018a6958df5c4d195c5'
        },
      ).then((value) {
        science = value.data['articles'];
        science.forEach((element) => allData.add(element));
        emit(AppGetScienceSuccessState());
      }).catchError((error){
        emit(AppGetScienceErrorState(error.toString()));
      },
      );
    }else{
      emit(AppGetScienceSuccessState());
    }
  }

  void getSportsData(){
    if(sports.length == 0){
      emit(AppLoadingState());
      DioHelper.getData(
        url:'v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'sports',
          'apiKey': '642384f5283a4018a6958df5c4d195c5'
        },
      ).then((value) {
        sports = value.data['articles'];
        sports.forEach((element) => allData.add(element));
        print(allData.length);
        emit(AppGetSportsSuccessState());
      }).catchError((error){
        emit(AppGetSportsErrorState(error.toString()));
      },
      );
    } else{
      emit(AppGetSportsSuccessState());
    }
  }

  void changeTheme(){
    isDark = !isDark;
    CacheHelper.putData(key: 'isDark', value: isDark).then((value) {
      emit(AppChangeThemeModeState());
    });
  }

  void getSharedData({required String key}){
    bool? currentTheme = CacheHelper.getData(key: key);
    if(currentTheme != null)
    {
      isDark = currentTheme;
    }
    emit(AppGetSharedPrefsDataState());
  }

  getSearchedData() {
    searchedData = allData.where((element) => element['title']!.toLowerCase().startsWith(query!.toLowerCase())).toList();
    emit(AppGetSearchDataState());
  }
}