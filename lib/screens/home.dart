import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubit/cubit.dart';
import 'package:news_app/cubit/dio_helper.dart';
import 'package:news_app/cubit/states.dart';
import 'package:news_app/widgets/post_widget.dart';


class Home extends StatelessWidget {
 static const String routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, NewsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          AppCubit _cubit = AppCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'News App',
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.search),
                  splashRadius: 24,
                  onPressed: (){
                    showSearch(context: context, delegate: searchDelegate());
                  },
                ),
                IconButton(
                  icon: _cubit.isDark? const Icon(Icons.brightness_2): const Icon(Icons.brightness_4),
                  splashRadius: 24,
                  onPressed: () => _cubit.changeTheme(),
                ),
              ],
            ),
            body: _cubit.screens[_cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: _cubit.currentIndex,
              items: _cubit.navItems,
              onTap: (index) => _cubit.changeBottomNavBar(index),
            ),
          );
        },
      );
  }
}

class searchDelegate extends SearchDelegate {
  List searchData = [];

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
       IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            query = '';
          },
       ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        icon: const Icon(Icons.arrow_back_ios_rounded),
      onPressed: () {
      close(context, null);
    },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    AppCubit.get(context).getSearch(query);
    print(query);
    searchData = AppCubit.get(context).search;
    
    print(searchData);
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemCount: searchData.length,
      separatorBuilder: (context, index) => const Divider(
        thickness: 1,
        height: 1,
        indent: 10,
        endIndent: 10,
        color: Colors.grey,
      ),
      itemBuilder: (context, index) => PostWidget(
        data: searchData,
        index: index,
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
