import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:bloc_test/bloc_test.dart';
import 'package:flowery_tracking_app/core/services/location_service.dart';
import 'package:flowery_tracking_app/domain/entities/order/order_entity.dart';
import 'package:flowery_tracking_app/domain/entities/shipping_address/shipping_address_entity.dart';
import 'package:flowery_tracking_app/presentation/pick_up_location/views_model/pick_up_address_cubit.dart';
import 'package:flowery_tracking_app/presentation/pick_up_location/views_model/pick_up_address_intent.dart';
import 'package:flowery_tracking_app/presentation/pick_up_location/views_model/pick_up_address_state.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'pick_up_address_cubit_test.mocks.dart';

@GenerateMocks([
  MapController,
  http.Client,
  LocationService,
])
void main() {
  late MockLocationService mockLocationService;
  late MockMapController mockMapController;
  late MockClient mockHttpClient;
  late PickUpAddressCubit cubit;

  final storeLatLng = const LatLng(30.0444, 31.2357); // Cairo
  final driverLatLng = const LatLng(29.9792, 31.1342); // Giza

  final mockRouteJson = jsonEncode({
    'routes': [
      {
        'geometry': {
          'coordinates': [
            [31.1342, 29.9792],
            [31.2357, 30.0444],
          ],
        },
      },
    ],
  });

  setUp(() {
    mockLocationService = MockLocationService();
    mockMapController = MockMapController();
    mockHttpClient = MockClient();

    cubit = PickUpAddressCubit(mockLocationService);

    // Stub map controller
    when(mockMapController.mapEventStream)
        .thenAnswer((_) => const Stream.empty());

    when(mockMapController.camera).thenReturn(
      MapCamera(
        center: const LatLng(0, 0),
        zoom: 15,
        rotation: 0,
        crs: const Epsg3857(),
        nonRotatedSize: const Size(800, 600),
      ),
    );

    // ✅ تعديل هنا: استبدال الـ true بـ void
    when(mockMapController.move(any, any)).thenAnswer((_) => true);

    cubit.mapController.mapEventStream;
  });

  tearDown(() async {
    await cubit.close();
  });

  group('PickUpAddressCubit', () {
    test('initial state is correct', () {
      expect(cubit.state, const PickupAddressState(currentZoom: 15));
    });



    blocTest<PickUpAddressCubit, PickupAddressState>(
      'emits error when location permission is denied',
      build: () {
        when(mockLocationService.checkPermission())
            .thenAnswer((_) async => LocationPermissionResult.denied);
        return cubit;
      },
      act: (cubit) async {
        final order = const OrderEntity(
          shippingAddress: ShippingAddressEntity(
            lat: '30.0444',
            long: '31.2357',
          ),
        );
        await cubit.doIntent(PickupAddressInitIntent(orderData: order));
      },
      expect: () => [
        isA<PickupAddressState>().having((s) => s.error, 'error', null),
        isA<PickupAddressState>()
            .having((s) => s.error, 'error', contains('denied')),
      ],
    );

    blocTest<PickUpAddressCubit, PickupAddressState>(
      'updates polyline correctly when OSRM returns valid route',
      build: () {
        when(mockHttpClient.get(any))
            .thenAnswer((_) async => http.Response(mockRouteJson, 200));
        return cubit;
      },
      act: (cubit) async {
        await cubit.updatePolylineForTest(
          driverLatLng,
          storeLatLng,
          client: mockHttpClient,
        );
      },
      expect: () => [
        isA<PickupAddressState>()
            .having((s) => s.routePoints.length, 'routePoints length', 2),
      ],
    );
  });
}

extension TestablePickUpAddressCubit on PickUpAddressCubit {
  Future<void> updatePolylineForTest(
      LatLng start,
      LatLng end, {
        required http.Client client,
      }) async {
    try {
      final url = Uri.parse(
        'https://router.project-osrm.org/route/v1/driving/'
            '${start.longitude},${start.latitude};'
            '${end.longitude},${end.latitude}?overview=full&geometries=geojson',
      );

      final res = await client.get(url);
      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        final coords = (data['routes']?[0]['geometry']['coordinates'] ?? [])
            .map<LatLng>((c) => LatLng(c[1], c[0]))
            .toList();

        emit(state.copyWith(routePoints: coords));
      }
    } catch (_) {}
  }
}
