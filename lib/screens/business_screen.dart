import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubit/cubit.dart';
import 'package:news_app/cubit/states.dart';
import 'package:news_app/widgets/post_widget.dart';


class BusinessScreen extends StatelessWidget {
  static const String routeName = '/business_screen';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, NewsStates>(
      listener: (context, state){},
      builder: (context, state) {
        AppCubit _cubit = AppCubit.get(context);
        var data = _cubit.business;
        if(state is AppLoadingState)
          return Center(
            child: const CircularProgressIndicator(),
          );
         return ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemCount: _cubit.business.length,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) => PostWidget(
              data: data,
              index: index,
            ),
          );
      }
    );
  }
}
