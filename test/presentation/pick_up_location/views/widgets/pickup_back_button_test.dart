import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flowery_tracking_app/presentation/pick_up_location/views/widgets/pickup_back_button.dart';

void main() {
  testWidgets('PickupBackButton renders and pops on tap', (WidgetTester tester) async {

    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, _) => MaterialApp(
          home: Builder(
            builder: (context) => Scaffold(
              body: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const Scaffold(
                        body: Stack(
                          children: [
                            PickupBackButton(),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                child: const Text('Go'),
              ),
            ),
          ),
        ),
      ),
    );

     await tester.tap(find.text('Go'));
    await tester.pumpAndSettle();

     expect(find.byType(CircleAvatar), findsOneWidget);
    expect(find.byIcon(Icons.arrow_back_ios_new), findsOneWidget);

     await tester.tap(find.byType(InkWell));
    await tester.pumpAndSettle();

     expect(find.byIcon(Icons.arrow_back_ios_new), findsNothing);
  });
}
