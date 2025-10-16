import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking_app/core/constants/app_text.dart';
import 'package:flowery_tracking_app/core/di/di.dart';
import 'package:flowery_tracking_app/presentation/home/views/widgets/reject_order_button.dart';
import 'package:flowery_tracking_app/presentation/home/views_model/home_cubit.dart';
import 'package:flowery_tracking_app/presentation/home/views_model/home_intent.dart';
import 'package:flowery_tracking_app/presentation/home/views_model/home_state.dart';
import 'package:flowery_tracking_app/utils/common_widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'reject_order_button_test.mocks.dart';

@GenerateMocks([HomeCubit])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockHomeCubit mockHomeCubit;
  setUp(() {
    mockHomeCubit = MockHomeCubit();
    getIt.registerFactory<HomeCubit>(() => mockHomeCubit);
    provideDummy<HomeState>(const HomeState());
    when(mockHomeCubit.state).thenReturn(const HomeState());
    when(
      mockHomeCubit.stream,
    ).thenAnswer((_) => Stream.fromIterable([const HomeState()]));
  });
  // Arrange
  Widget prepareWidget({required String orderId}) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return MaterialApp(
          home: BlocProvider<HomeCubit>.value(
            value: mockHomeCubit
              ..doIntent(intent: const HomeInitializationIntent()),
            child: RejectOrderButton(orderId: orderId),
          ),
        );
      },
    );
  }

  testWidgets("Verifying RejectOrderButton Widget", (tester) async {
    // Act
    await tester.pumpWidget(prepareWidget(orderId: "order-1"));
    // Assert
    expect(find.byType(CustomElevatedButton), findsOneWidget);
    expect(find.text(AppText.reject.tr()), findsOneWidget);
  });
}
