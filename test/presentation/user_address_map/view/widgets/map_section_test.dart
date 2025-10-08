import 'package:flowery_tracking_app/presentation/user_address_map/view/widgets/map_section.dart';
import 'package:flowery_tracking_app/presentation/user_address_map/view_model/user_address_map_cubit.dart';
import 'package:flowery_tracking_app/presentation/user_address_map/view_model/user_address_map_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'map_section_test.mocks.dart';

// --- FAKES and HELPERS ---

// 1. A plain "stand-in" class for the address. It does NOT implement anything.
class TestShippingAddress {
  final String lat;
  final String long;

  TestShippingAddress({required this.lat, required this.long});
}

// 2. A plain "stand-in" class for the order. It does NOT implement anything.
class TestOrder {
  final TestShippingAddress shippingAddress;

  TestOrder({required this.shippingAddress});
}

// 3. The FakeFlutterMap is still needed to avoid native rendering issues in tests.
class FakeFlutterMap extends StatelessWidget {
  final MapOptions options;
  final List<Widget> children;

  const FakeFlutterMap({
    super.key,
    required this.options,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(children: children);
  }
}

@GenerateMocks([UserAddressMapCubit])
void main() {
  // Use the generated mock for the Cubit and a plain class for the order data
  late MockUserAddressMapCubit mockCubit;
  late TestOrder testOrder;

  // Define test data
  final userLocation = const LatLng(30.0444, 31.2357); // Cairo
  final driverLocation = const LatLng(29.9792, 31.1342); // Giza

  setUp(() {
    mockCubit = MockUserAddressMapCubit();

    // Directly create instances of our simple test classes.
    // This works because the widget accepts `dynamic orderData`.
    testOrder = TestOrder(
      shippingAddress: TestShippingAddress(
        lat: userLocation.latitude.toString(),
        long: userLocation.longitude.toString(),
      ),
    );

    when(mockCubit.mapController).thenReturn(MapController());
  });

  // A helper function to build the widget tree for tests
  Widget buildTestWidget() {
    return MaterialApp(
      home: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, _) => BlocProvider<UserAddressMapCubit>.value(
          value: mockCubit,
          child: Scaffold(body: MapSection(orderData: testOrder)),
        ),
      ),
    );
  }

  group('MapSection Widget Tests', () {
    testWidgets('calls initMap on initState and shows initial UI', (
      tester,
    ) async {
      // ARRANGE
      when(mockCubit.state).thenReturn(const UserAddressMapState());
      when(mockCubit.stream).thenAnswer((_) => const Stream.empty());

      when(
        mockCubit.initMap(userLocation: anyNamed('userLocation')),
      ).thenAnswer((_) async {});

      // ACT
      await tester.pumpWidget(buildTestWidget());

      // ASSERT
      verify(mockCubit.initMap(userLocation: userLocation)).called(1);
      expect(find.byIcon(Icons.arrow_back_ios), findsOneWidget);
    });

    testWidgets('renders markers and polylines when state is updated', (
      tester,
    ) async {
      // ARRANGE
      when(mockCubit.state).thenReturn(const UserAddressMapState());
      when(mockCubit.stream).thenAnswer(
        (_) => Stream.fromIterable([
          UserAddressMapState(
            userLocation: userLocation,
            driverLocation: driverLocation,
            polylinePoints: [userLocation, driverLocation],
          ),
        ]),
      );

      when(
        mockCubit.initMap(userLocation: anyNamed('userLocation')),
      ).thenAnswer((_) async {});

      // ACT
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      // ASSERT
      expect(find.byType(TileLayer), findsOneWidget);
      expect(find.byType(PolylineLayer), findsOneWidget);
      expect(find.byType(MarkerLayer), findsOneWidget);
    });
  });
}
