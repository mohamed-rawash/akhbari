abstract class NewsStates {}

class InitialState extends NewsStates {}

class AppBottomNavState extends NewsStates {}

class AppLoadingState extends NewsStates {}

class AppGetBusinessSuccessState extends NewsStates {}

class AppGetBusinessErrorState extends NewsStates {
  final String error;
  AppGetBusinessErrorState(this.error);
}

class AppGetScienceSuccessState extends NewsStates {}

class AppGetScienceErrorState extends NewsStates {
  final String error;
  AppGetScienceErrorState(this.error);
}

class AppGetSportsSuccessState extends NewsStates {}

class AppGetSportsErrorState extends NewsStates {
  final String error;
  AppGetSportsErrorState(this.error);
}

class AppChangeThemeModeState extends NewsStates {}

class AppGetSharedPrefsDataState extends NewsStates {}

class AppGetSearchDataState extends NewsStates {}
