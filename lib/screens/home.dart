import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:lottie/lottie.dart';
import 'package:news_app/cubit/cubit.dart';
import 'package:news_app/cubit/states.dart';
import 'package:news_app/screens/web_view_screen.dart';
import 'package:news_app/widgets/post_widget.dart';
import 'package:news_app/widgets/theme_service.dart';

class Home extends StatelessWidget {
  static const String routeName = '/home';

  @override
  Widget build(BuildContext context) {
    AppCubit _cubit = AppCubit.get(context);
    return BlocConsumer<AppCubit, NewsStates>(
      listener: (context, state) {
        if(state is AppBottomNavState)
          _cubit.getBusinessData();
      },
      builder: (context, state) {

        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'اخــبــاري',
            ),
            centerTitle: true,
            actions: [
              IconButton(
                icon: const Icon(Icons.search),
                splashRadius: 24,
                onPressed: () {
                  showSearch(context: context, delegate: DataSearch());
                },
              ),
              IconButton(
                icon: _cubit.isDark
                    ? const Icon(Icons.brightness_2)
                    : const Icon(Icons.brightness_4),
                splashRadius: 24,
                onPressed: () => _cubit.changeTheme(),
              ),
            ],
          ),
          body: OfflineBuilder(
            connectivityBuilder: (
              BuildContext context,
              ConnectivityResult connectivity,
              Widget child,
            ) {
              final bool connected = connectivity != ConnectivityResult.none;
              if (connected) {
                return _cubit.screens[_cubit.currentIndex];
              } else {
                return Lottie.asset(
                  'assets/images/Wifi_conection.json',
                  repeat: true,
                  fit: BoxFit.cover,
                );
              }
            },
            child: const Center(
              child: LoadingIndicator(
                  indicatorType: Indicator.ballScaleMultiple,
                  colors: [
                    Colors.blue,
                    Colors.purpleAccent,
                    Colors.red,
                  ],
                  strokeWidth: 0.2,
                  backgroundColor: Colors.transparent,
                  pathBackgroundColor: Colors.white),
            ),
          ),
          bottomNavigationBar: BottomNavyBar(
            selectedIndex: _cubit.currentIndex,
            showElevation: true,
            items: [
              BottomNavyBarItem(
                icon: const Icon(Icons.business),
                title: const Text('Business'),
                activeColor: Colors.red,
              ),
              BottomNavyBarItem(
                icon: const Icon(Icons.science),
                title: const Text('Science'),
                activeColor: Colors.blue,
              ),
              BottomNavyBarItem(
                icon: const Icon(Icons.sports_rounded),
                title: const Text('Sports'),
                activeColor: Colors.green,
              ),
            ],
            onItemSelected: (index) => _cubit.changeBottomNavBar(index),
          ),
        );
      },
    );
  }
}

class DataSearch extends SearchDelegate {

  @override
  ThemeData appBarTheme(BuildContext context) {
    return AppCubit().isDark? ThemeService.dark(): ThemeService.light();
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(
          Icons.clear,
          color: Colors.black,
          size: 32,
        ),
        splashRadius: 24,
        onPressed: () {
          query = '';
          close(context, null);
        },
      ),
      const SizedBox(width: 10),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.arrow_back,
        color: Colors.black,
        size: 32,
      ),
      splashRadius: 24,
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return  BlocConsumer<AppCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state){
        AppCubit _cubit = AppCubit.get(context);
        _cubit.query = query;
        if(query.isEmpty)
          _cubit.searchedData.clear();
        else
          _cubit.getSearchedData();
        return Scaffold(
          backgroundColor: _cubit.isDark? Colors.black: Colors.white,
          body: _cubit.searchedData.isEmpty?
          Center(
            child: Lottie.asset(
              'assets/images/search-white.json',
              repeat: true,
              fit: BoxFit.cover,
            ),
          ):Padding(
            padding: const EdgeInsets.only(top: 16, left: 10, right: 10),
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemCount: _cubit.searchedData.length,
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              itemBuilder: (context, index) => PostWidget(
                data: _cubit.searchedData,
                index: index,
              ),
            ),
          ),
        );
      },
    );
  }
}
