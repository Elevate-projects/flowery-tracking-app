import 'package:flowery_tracking_app/domain/entities/order/order_entity.dart';
import 'package:flowery_tracking_app/domain/entities/shipping_address/shipping_address_entity.dart';
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
  provideDummy<UserAddressMapState>(const UserAddressMapState());

  late MockUserAddressMapCubit mockCubit;
  late OrderEntity testOrder;

  // Define test data
  final userLocation = const LatLng(30.0444, 31.2357); // Cairo
  final driverLocation = const LatLng(29.9792, 31.1342); // Giza

  setUp(() {
    mockCubit = MockUserAddressMapCubit();

    testOrder = OrderEntity(
      shippingAddress: ShippingAddressEntity(
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
