import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/src/form_data.dart';
import 'package:flowery_tracking_app/api/client/api_client.dart';
import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/api/client/request_maper.dart';
import 'package:flowery_tracking_app/api/data_source/apply/remote_data_source/apply_remote_data_source_impl.dart';
import 'package:flowery_tracking_app/core/connection_manager/connection_manager.dart';
import 'package:flowery_tracking_app/domain/entities/requests/apply_request/apply_request_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:path/path.dart' as p;

import 'apply_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([ApiClient, Connectivity])
void main() {
  test('when call apply from apiclient it succeeds', () async {
    // Arrange
    final mockApiClient = MockApiClient();
    final mockConnectivity = MockConnectivity();
    ConnectionManager.connectivity = mockConnectivity;
    final dataSource = ApplyRemoteDataSourceImpl(mockApiClient);

    final tempDir = Directory.systemTemp.createTempSync();
    final nidFile = File(p.join(tempDir.path, 'nid.jpg'))
      ..writeAsStringSync('dummy');
    final licenseFile = File(p.join(tempDir.path, 'license.jpg'))
      ..writeAsStringSync('dummy');

    addTearDown(() {
      tempDir.deleteSync(recursive: true);
    });
    final ApplyRequestEntity applyRequestEntity = ApplyRequestEntity(
      firstName: 'John',
      lastName: 'Doe',
      email: 'john.doe@example.com',
      phone: '1234567890',
      password: 'password123',
      rePassword: 'password123',
      country: 'USA',
      gender: 'male',
      nid: '12345678901234',
      nidImg: nidFile,
      vehicleType: 'Sedan',
      vehicleNumber: 'ABC-123',
      vehicleLicense: licenseFile,
    );

    when(
      mockConnectivity.checkConnectivity(),
    ).thenAnswer((_) async => [ConnectivityResult.wifi]);
    when(mockApiClient.apply(any)).thenAnswer((_) async => Future.value());

    // Act
    final result = await dataSource.apply(
      applyRequestEntity: applyRequestEntity,
    );

    // Assert
    expect(result, isA<Success<void>>());
    verify(mockApiClient.apply(any)).called(1);
  });
}
