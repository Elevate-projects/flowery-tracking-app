import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/api/responses/verification/verify_response.dart';
import 'package:flowery_tracking_app/domain/entities/requests/verify_request/verify_requset_entity.dart';
import 'package:flowery_tracking_app/domain/repositories/verification/verification_repository.dart';
import 'package:flowery_tracking_app/domain/use_cases/verification/verification_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'verification_usecase_test.mocks.dart';

@GenerateMocks([VerificationRepository])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test('verify calling  resendCode from dataSource ', () async {
    final mockRepo = MockVerificationRepository();
    final GetVerificationUseCase useCase = GetVerificationUseCase(mockRepo);

    final verifyRequest = VerifyRequestEntity(resetCode: '123456');

    final expectedResponse = const VerifyResponse(
      message: 'Verification successful',
      status: 'success',
      code: 200,
    );

    final expectedResult = Success(expectedResponse);

    provideDummy<Result<VerifyResponse>>(expectedResult);

    when(
      mockRepo.verify(verifyRequest),
    ).thenAnswer((_) async => expectedResult);

    final result = await useCase.execute(verifyRequest);

    verify(mockRepo.verify(verifyRequest)).called(1);

    expect(result, isA<Success<VerifyResponse>>());

    result as Success<VerifyResponse>;

    expect(result.data.message, equals(expectedResponse.message));
  });
}
