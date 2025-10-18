import 'package:flowery_tracking_app/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';

void main() {
  testWidgets('MapMarkers.buildMarker returns a marker with correct label', (tester) async {
     final marker = Marker(
      point: const LatLng(30.0444, 31.2357),
      width: 130,  // بدل 130.w
      height: 60,  // بدل 60.h
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.pink,
            ),
            child: const Text(
              'Test Label',
              style: TextStyle(color: AppColors.white),
            ),
          ),
        ],
      ),
    );

     await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: marker.child,
        ),
      ),
    );

    await tester.pumpAndSettle();

     expect(find.text('Test Label'), findsOneWidget);
    final container = tester.widget<Container>(find.byType(Container).first);
    final decoration = container.decoration as BoxDecoration;
    expect(decoration.color, Colors.pink);
  });
}
