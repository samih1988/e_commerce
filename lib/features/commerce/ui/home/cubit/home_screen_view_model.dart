import 'package:e_commerce_app/features/commerce/ui/home/cubit/home_screen_states.dart';
import 'package:e_commerce_app/features/commerce/ui/home/tabs/favorite_tab/favorite_tab.dart';
import 'package:e_commerce_app/features/commerce/ui/home/tabs/home_tab/home_tab.dart';
import 'package:e_commerce_app/features/commerce/ui/home/tabs/products_tab/products_tab.dart';
import 'package:e_commerce_app/features/commerce/ui/home/tabs/user_tab/user_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class HomeScreenViewModel extends Cubit<HomeScreenStates> {
  HomeScreenViewModel() : super(HomeScreenInitialState());

  int selectedIndex = 0;

  List<Widget> bodyList = [
    HomeTab(),
    ProductsTab(),
    FavoriteTab(),
    const UserTab(),
  ];

  void bottomNavOnTap(int index) {
    selectedIndex = index;
    emit(ChangeSelectedIndexState());
  }
}
