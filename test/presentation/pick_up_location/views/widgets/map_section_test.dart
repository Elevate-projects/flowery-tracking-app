import 'package:flowery_tracking_app/domain/entities/order/order_entity.dart';
import 'package:flowery_tracking_app/domain/entities/shipping_address/shipping_address_entity.dart';
import 'package:flowery_tracking_app/presentation/pick_up_location/views/widgets/map_section.dart';
import 'package:flowery_tracking_app/presentation/pick_up_location/views_model/pick_up_address_cubit.dart';
import 'package:flowery_tracking_app/presentation/pick_up_location/views_model/pick_up_address_state.dart';
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

@GenerateMocks([PickUpAddressCubit])
void main() {
  provideDummy<PickupAddressState>(const PickupAddressState());

  late MockPickUpAddressCubit mockCubit;
  late OrderEntity testOrder;

  // Define test data
  const driverLocation = LatLng(30.0444, 31.2357);
  const storeLocation = LatLng(29.9792, 31.1342);

  setUp(() {
    mockCubit = MockPickUpAddressCubit();

    testOrder = const OrderEntity(
      shippingAddress: ShippingAddressEntity(
        lat: '30.0444',
        long: '31.2357',
      ),
    );

    when(mockCubit.mapController).thenReturn(MapController());
  });

   Widget buildTestWidget() {
    return MaterialApp(
      home: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, _) => BlocProvider<PickUpAddressCubit>.value(
          value: mockCubit,
          child: Scaffold(
            body: MapSection(orderData: testOrder),
          ),
        ),
      ),
    );
  }

  group('MapSection Widget Tests', () {
    testWidgets('renders markers and polyline when state updates', (tester) async {
      // ARRANGE
      when(mockCubit.state).thenReturn(const PickupAddressState());
      when(mockCubit.stream).thenAnswer(
            (_) => Stream.fromIterable([
          const PickupAddressState(
            driverLocation: driverLocation,
            storeLocation: storeLocation,
            routePoints: [driverLocation, storeLocation],
          ),
        ]),
      );

       await tester.pumpWidget(buildTestWidget());
      await tester.pump();

       expect(find.byType(TileLayer), findsOneWidget);
      expect(find.byType(PolylineLayer), findsOneWidget);
      expect(find.byType(MarkerLayer), findsOneWidget);
    });

    testWidgets('shows dialog when error exists', (tester) async {

      when(mockCubit.state).thenReturn(
        const PickupAddressState(error: 'Something went wrong'),
      );
      when(mockCubit.stream).thenAnswer((_) => const Stream.empty());


      await tester.pumpWidget(buildTestWidget());
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));
      await tester.pumpAndSettle();

       expect(find.text('Something went wrong'), findsOneWidget);
     });

  });
}
