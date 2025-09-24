import 'package:flowery_tracking_app/presentation/bottom_navigation/views_model/bottom_navigation_cubit.dart';
import 'package:flowery_tracking_app/presentation/bottom_navigation/views_model/bottom_navigation_intent.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

void main() {
  group('BottomNavigationCubit Tests', () {
    late BottomNavigationCubit cubit;

    setUp(() {
      cubit = BottomNavigationCubit();
    });

    tearDown(() {
      cubit.close();
    });
    test('initial state should have currentIndex = 0', () {
      cubit.doIntent(OnBottomTabsClick(index: 0));
      expect(cubit.state.currentIndex, equals(0));
    });
    test('doIntent(OnBottomTabsClick) should update currentIndex', () {
      cubit.doIntent(OnBottomTabsClick(index: 1));
      expect(cubit.state.currentIndex, equals(1));
      cubit.doIntent(OnBottomTabsClick(index: 2));
      expect(cubit.state.currentIndex, equals(2));
    });
    test('doIntent(OnPageSwiped) should update currentIndex', () {
      cubit.doIntent(OnPageSwiped(index: 1));
      expect(cubit.state.currentIndex, equals(1));
      cubit.doIntent(OnPageSwiped(index: 0));
      expect(cubit.state.currentIndex, equals(0));
    });
    test('pageController should not be null and have initialPage = 0', () {
      expect(cubit.pageController, isA<PageController>());
      expect(cubit.pageController.initialPage, equals(0));
    });
  });
}
