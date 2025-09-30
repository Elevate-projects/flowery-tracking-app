import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking_app/core/constants/app_text.dart';
import 'package:flowery_tracking_app/presentation/profile/reset_password/views/widgets/profile_reset_password_app_bar.dart';
import 'package:flowery_tracking_app/utils/common_widgets/custom_app_bar.dart';
import 'package:flowery_tracking_app/utils/common_widgets/custom_back_arrow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget prepareWidget() {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return const MaterialApp(home: ProfileResetPasswordAppBar());
      },
    );
  }

  group('ResetPasswordAppBar', () {
    testWidgets(
      'should render CustomAppBar with back arrow and translated title',
      (WidgetTester tester) async {
        await tester.pumpWidget(prepareWidget());

        await tester.pumpAndSettle();

        expect(find.byType(CustomAppBar), findsOneWidget);

        expect(find.byType(CustomBackArrow), findsOneWidget);

        expect(find.text(AppText.resetPasswordTitle.tr()), findsOneWidget);
      },
    );
  });
}
