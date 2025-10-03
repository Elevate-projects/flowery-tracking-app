import 'dart:io';

import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/data/data_source/apply/remote_data_source/apply_remote_data_source.dart';
import 'package:flowery_tracking_app/data/repositories/apply/apply_repository_impl.dart';
import 'package:flowery_tracking_app/domain/entities/requests/apply_request/apply_request_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:path/path.dart' as p;

import 'apply_repository_impl_test.mocks.dart';

@GenerateMocks([ApplyRemoteDataSource])
void main() {
  test('when call apply from repository it succeeds', () async {
    // Arrange
    final mockDataSource = MockApplyRemoteDataSource();
    final repository = ApplyRepositoryImpl(mockDataSource);

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
     provideDummy<Result<void>>(Success(null));
    when(
      mockDataSource.apply(applyRequestEntity: anyNamed('applyRequestEntity')),
    ).thenAnswer((_) async => Success<void>(null));

    // Act
    final result = await repository.apply(
      applyRequestEntity: applyRequestEntity,
    );

    // Assert
    expect(result, isA<Success<void>>());
    verify(
      mockDataSource.apply(applyRequestEntity: applyRequestEntity),
    ).called(1);
  });
}
