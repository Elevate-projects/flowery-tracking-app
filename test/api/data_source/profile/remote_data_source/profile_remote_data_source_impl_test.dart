import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flowery_tracking_app/api/client/api_client.dart';
import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/api/data_source/profile/remote_data_source/profile_remote_data_source_impl.dart';
import 'package:flowery_tracking_app/api/models/driver_data/driver_data_model.dart';
import 'package:flowery_tracking_app/api/responses/profile_response/profile_response.dart';
import 'package:flowery_tracking_app/core/connection_manager/connection_manager.dart';
import 'package:flowery_tracking_app/domain/entities/driver_data/driver_data_entity.dart';
import 'package:flowery_tracking_app/utils/flowery_driver_method_helper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../forget_password_and_resend_code/forget_password_and_resend_code_data_source_impl_test.mocks.dart';

@GenerateMocks([ApiClient, Connectivity])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late ProfileRemoteDataSourceImpl remoteDataSource;
  late MockApiClient mockApiClient;
  late MockConnectivity mockedConnectivity;
  setUp(() {
    mockApiClient = MockApiClient();
    remoteDataSource = ProfileRemoteDataSourceImpl(mockApiClient);
    mockedConnectivity = MockConnectivity();
    FloweryDriverMethodHelper.currentUserToken = "fake_token";
    when(mockedConnectivity.checkConnectivity())
        .thenAnswer((_) async => [ConnectivityResult.wifi]);
  });

  test('fetchUserData returns success when api call succeeds', () async {
    ConnectionManager.connectivity = mockedConnectivity;

    final fakeDriver = DriverDataModel(
      id: "123",
      firstName: "Peter",
      lastName: "Rafek",
      email: "peter@gmail.com",
    );
    final fakeResponse = ProfileResponse(
      message: "Success",
      driver: fakeDriver,
    );
    when(
      mockApiClient.getUserData(token: anyNamed("token")),
    ).thenAnswer((_) async => fakeResponse);
    final result = await remoteDataSource.fetchUserData();

    expect(result, isA<Success<DriverDataEntity?>>());

    final success = result as Success<DriverDataEntity?>;
    expect(success.data?.firstName, equals("Peter"));
    expect(success.data?.email, equals("peter@gmail.com"));

    verify(mockApiClient.getUserData(token: "Bearer fake_token")).called(1);

  });

  test('fetchUserData returns failure when no internet', () async {
    ConnectionManager.connectivity = mockedConnectivity;
    when(mockedConnectivity.checkConnectivity())
        .thenAnswer((_) async => [ConnectivityResult.none]);

    final result = await remoteDataSource.fetchUserData();

    expect(result, isA<Failure>());
    final failure = result as Failure;
    expect(failure.responseException.message, contains("connection"));
  });
}
