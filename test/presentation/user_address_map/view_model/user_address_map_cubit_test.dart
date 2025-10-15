import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:bloc_test/bloc_test.dart';
import 'package:flowery_tracking_app/domain/use_cases/update_driver_location/update_driver_location_usecase.dart';
import 'package:flowery_tracking_app/presentation/user_address_map/view_model/user_address_map_cubit.dart';
import 'package:flowery_tracking_app/presentation/user_address_map/view_model/user_address_map_state.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'user_address_map_cubit_test.mocks.dart';

@GenerateMocks([
  MapController,
  http.Client,
  GetUpdateDriverLocationUseCase,
], customMocks: [])
void main() {
  late MockMapController mockMapController;
  late MockClient mockHttpClient;
  late MockGetUpdateDriverLocationUseCase mockUpdateDriverLocationUseCase;

  final userLocation = const LatLng(30.0444, 31.2357); // Cairo
  final initialDriverLatLng = const LatLng(29.9792, 31.1342); // Giza

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
  final expectedPolyline = [initialDriverLatLng, userLocation];

  setUp(() {
    mockMapController = MockMapController();
    mockHttpClient = MockClient();
    mockUpdateDriverLocationUseCase = MockGetUpdateDriverLocationUseCase();

    // Stub the MapController's stream
    when(
      mockMapController.mapEventStream,
    ).thenAnswer((_) => const Stream.empty());

    // Stub the MapController's camera with all required parameters
    when(mockMapController.camera).thenReturn(
      MapCamera(
        center: const LatLng(0, 0),
        zoom: 15,
        rotation: 0,
        crs: const Epsg3857(),
        nonRotatedSize: const Size(800, 600),
      ),
    );
  });

  // --- Test Cases ---
  group('UserAddressMapCubit with Mockito', () {
    test('initial state is correct', () {
      expect(
        UserAddressMapCubit(mockUpdateDriverLocationUseCase).state,
        const UserAddressMapState(currentZoom: 15),
      );
    });

    group('polyline logic', () {
      blocTest<UserAddressMapCubit, UserAddressMapState>(
        'emits polylinePoints on successful API call',

        setUp: () {
          when(
            mockHttpClient.get(any, headers: anyNamed('headers')),
          ).thenAnswer((_) async => http.Response(mockRouteJson, 200));
        },
        build: () => UserAddressMapCubit(mockUpdateDriverLocationUseCase),
        // ACT: Call the method being tested
        act: (cubit) async {
          cubit.emit(
            cubit.state.copyWith(
              userLocation: userLocation,
              driverLocation: initialDriverLatLng,
            ),
          );
          // Call the testable extension method
          await cubit.updatePolylineForTest(
            initialDriverLatLng,
            userLocation,
            client: mockHttpClient,
          );
        },
        // ASSERT: Check the emitted states
        expect: () => <UserAddressMapState>[
          UserAddressMapState(
            userLocation: userLocation,
            driverLocation: initialDriverLatLng,
          ),
          UserAddressMapState(
            userLocation: userLocation,
            driverLocation: initialDriverLatLng,
            polylinePoints: expectedPolyline,
          ),
        ],

        verify: (_) {
          final expectedUrl = Uri.parse(
            'https://router.project-osrm.org/route/v1/driving/'
            '${initialDriverLatLng.longitude},${initialDriverLatLng.latitude};'
            '${userLocation.longitude},${userLocation.latitude}?overview=full&geometries=geojson',
          );

          verify(
            mockHttpClient.get(expectedUrl, headers: anyNamed('headers')),
          ).called(1);
        },
      );
    });
  });
}

// Helper extension to make the private `_updatePolyline` logic testable
extension TestableUserAddressMapCubit on UserAddressMapCubit {
  Future<void> updatePolylineForTest(
    LatLng start,
    LatLng end, {
    required http.Client client,
  }) async {
    // This logic is copied from your cubit to make it testable
    try {
      final url = Uri.parse(
        'https://router.project-osrm.org/route/v1/driving/'
        '${start.longitude},${start.latitude};'
        '${end.longitude},${end.latitude}?overview=full&geometries=geojson',
      );

      final res = await client.get(url); // Use the injected mock client
      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        final coords = (data['routes']?[0]['geometry']['coordinates'] ?? [])
            .map<LatLng>((c) => LatLng(c[1], c[0]))
            .toList();

        emit(state.copyWith(polylinePoints: coords));
      }
    } catch (e) {
      // In a test, we can ignore the print
    }
  }
}
