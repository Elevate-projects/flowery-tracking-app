import 'package:cached_network_image/cached_network_image.dart';
import 'package:flowery_tracking_app/presentation/edit_profile/widgets/widget_profile/profile_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
void main() {
  testWidgets('ProfileImage shows CachedNetworkImage when imageUrl is valid', (tester) async {
    const testUrl = 'https://example.com/image.jpg';

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: ProfileImage(imageUrl: testUrl),
        ),
      ),
    );

    // نتأكد من وجود CachedNetworkImage
    expect(find.byType(CachedNetworkImage), findsOneWidget);
    expect(find.byIcon(Icons.account_circle), findsNothing);
  });

  testWidgets('ProfileImage shows default icon when imageUrl is null', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: ProfileImage(imageUrl: null),
        ),
      ),
    );

    // نتأكد من وجود الايقونة الافتراضية
    expect(find.byIcon(Icons.account_circle), findsOneWidget);
    expect(find.byType(CachedNetworkImage), findsNothing);
  });

  testWidgets('ProfileImage shows default icon when imageUrl is empty string', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: ProfileImage(imageUrl: ''),
        ),
      ),
    );

    // نتأكد من وجود الايقونة الافتراضية
    expect(find.byIcon(Icons.account_circle), findsOneWidget);
    expect(find.byType(CachedNetworkImage), findsNothing);
  });
}
