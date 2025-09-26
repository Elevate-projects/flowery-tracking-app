import 'package:flowery_tracking_app/presentation/bottom_navigation/views/widgets/bottom_navigation_widget.dart';
import 'package:flowery_tracking_app/presentation/bottom_navigation/views/widgets/top_border_widget.dart';
import 'package:flowery_tracking_app/presentation/bottom_navigation/views_model/bottom_navigation_cubit.dart';
import 'package:flowery_tracking_app/presentation/bottom_navigation/views_model/bottom_navigation_intent.dart';
import 'package:flowery_tracking_app/presentation/bottom_navigation/views_model/bottom_navigation_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavigationViewBody extends StatelessWidget {
  const BottomNavigationViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavigationCubit, BottomNavigationState>(
      builder: (context, state) {
        final cubit = context.read<BottomNavigationCubit>();

        return Column(
          children: [
            Expanded(
              child: PageView(
                controller: cubit.pageController,
                onPageChanged: (index) =>
                    cubit.doIntent(OnPageSwiped(index: index)),
                children: cubit.pages,
              ),
            ),

            const TopBorderWidget(),
            BottomNavigationBarWidget(
              currentIndex: state.currentIndex,
              onTap: (index) {
                cubit.pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
                cubit.doIntent(OnBottomTabsClick(index: index));
              },
            ),
          ],
        );
      },
    );
  }
}
