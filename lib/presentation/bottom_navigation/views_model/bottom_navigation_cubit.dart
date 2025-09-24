import 'package:flowery_tracking_app/presentation/bottom_navigation/views_model/bottom_navigation_intent.dart';
import 'package:flowery_tracking_app/presentation/bottom_navigation/views_model/bottom_navigation_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavigationCubit extends Cubit<BottomNavigationState> {
  BottomNavigationCubit() : super(const BottomNavigationState());
  final PageController pageController = PageController();


  //  These are only for testing the BottomNavigation functionality.
  final List<Widget> pages = const [
    Center(child: Text("Home")),
    Center(child: Text("Orders")),
    Center(child: Text("Profile")),
  ];



  // Uncomment these once the actual screens are ready
  // final List<Widget> pages = [
  //   const HomeView(),
  //   const OrderView(),
  //   const ProfileView(),
  //
  // ];

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
