import 'dart:io';

import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/domain/entities/requests/apply_request/apply_request_entity.dart';
import 'package:flowery_tracking_app/domain/repositories/apply/apply_repository.dart';
import 'package:flowery_tracking_app/domain/use_cases/apply/apply_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:path/path.dart' as p;

import 'apply_use_case_test.mocks.dart';
@GenerateMocks([ApplyRepository])
void main (){
  test('when call apply from use case it succeeds', () async {
    // Arrange
    final mockRepository = MockApplyRepository();
    final useCase = ApplyUseCase(mockRepository);

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
      mockRepository.apply(applyRequestEntity: anyNamed('applyRequestEntity')),
    ).thenAnswer((_) async => Success<void>(null));

    // Act
    final result = await useCase.invoke(
     request: applyRequestEntity,
    );

    // Assert
    expect(result, isA<Success<void>>());
    verify(
      mockRepository.apply(applyRequestEntity: applyRequestEntity),
    ).called(1);
  });
}