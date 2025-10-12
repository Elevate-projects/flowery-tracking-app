import 'package:flowery_tracking_app/presentation/bottom_navigation/views_model/bottom_navigation_intent.dart';
import 'package:flowery_tracking_app/presentation/bottom_navigation/views_model/bottom_navigation_state.dart';
import 'package:flowery_tracking_app/presentation/home/views/home_view.dart';
import 'package:flowery_tracking_app/presentation/profile/views/profile_views.dart';
import 'package:flowery_tracking_app/presentation/orders/views/orders_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class BottomNavigationCubit extends Cubit<BottomNavigationState> {
  BottomNavigationCubit() : super(const BottomNavigationState());
  final PageController pageController = PageController();

  final List<Widget> pages = const [
    HomeView(),
    OrdersView(),
    ProfileView(),
  ];

  void doIntent(BottomNavigationIntent intent) {
    switch (intent) {
      case OnBottomTabsClick():
        _changeTapIndex(index: intent.index);
      case OnPageSwiped():
        _onPageChanged(index: intent.index);
    }
  }

  void _changeTapIndex({required int index}) {
    emit(state.copyWith(currentIndex: index));
  }

  void _onPageChanged({required int index}) {
    emit(state.copyWith(currentIndex: index));
  }

  @override
  Future<void> close() {
    pageController.dispose();
    return super.close();
  }
}
