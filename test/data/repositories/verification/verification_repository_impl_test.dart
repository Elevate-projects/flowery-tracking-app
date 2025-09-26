import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/api/responses/verification/verify_response.dart';
import 'package:flowery_tracking_app/data/data_source/verification/verification_data_source.dart';
import 'package:flowery_tracking_app/data/repositories/verification/verification_repository_impl.dart';
import 'package:flowery_tracking_app/domain/entities/requests/verify_request/verify_requset_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'verification_repository_impl_test.mocks.dart';

@GenerateMocks([VerificationDataSource])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test('verify calling  verification from dataSource ', () async {
    final mockDataSource = MockVerificationDataSource();
    final VerificationRepositoryImpl repo = VerificationRepositoryImpl(
      mockDataSource,
    );

    final verifyRequest = VerifyRequestEntity(resetCode: '123456');

    final expectedResponse = const VerifyResponse(
      message: 'Verification successful',
      status: 'success',
      code: 200,
    );

    final expectedResult = Success(expectedResponse);

    provideDummy<Result<VerifyResponse>>(expectedResult);

    when(
      mockDataSource.verify(verifyRequest),
    ).thenAnswer((_) async => expectedResult);

    final result = await repo.verify(verifyRequest);

    verify(mockDataSource.verify(verifyRequest)).called(1);

    expect(result, isA<Success<VerifyResponse>>());

    result as Success<VerifyResponse>;

    expect(result.data.message, equals(expectedResponse.message));
  });
}
