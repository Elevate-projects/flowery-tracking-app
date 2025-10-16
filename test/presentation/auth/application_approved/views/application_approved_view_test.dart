import 'package:flowery_tracking_app/core/constants/app_text.dart';
import 'package:flowery_tracking_app/presentation/auth/application_approved/views/application_approved_view.dart';
import 'package:flowery_tracking_app/presentation/auth/application_approved/views/widgets/application_approved_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

void main (){
  Widget prepareWidget() {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return const MaterialApp(
          home: ApplicationApprovedView(),
        );
      },
    );
  }
  TestWidgetsFlutterBinding.ensureInitialized();
  testWidgets('verify application approved structure', (WidgetTester tester)async {
     await tester.pumpWidget(prepareWidget());
     await tester.pumpAndSettle();
     expect(find.byType(ApplicationApprovedView), findsOneWidget);
     expect(find.byKey(const Key('applicationApprovedTitle')), findsOneWidget);
     expect(find.byKey(const Key('applicationApprovedSubTitle')), findsOneWidget);
     expect(find.byKey(const Key('loginApproveButton')), findsOneWidget);
     expect(find.byType(ApplicationApprovedViewBody), findsOneWidget);
     expect(find.byType(Image), findsNWidgets(2));
     expect(find.byType(Text), findsNWidgets(3));

  });
}