// import 'package:flowery_app/api/client/api_client.dart';
// import 'package:flowery_app/api/client/api_result.dart';
// import 'package:flowery_app/api/client/request_maper.dart';
// import 'package:flowery_app/core/secure_storage/secure_storage.dart';
// import 'package:flowery_app/data/data_source/login/remote_data_source/login_remote_data_source.dart';
// import 'package:flowery_app/domain/entities/requests/login_request/login_request_entity.dart';
// import 'package:flowery_app/domain/entities/user_data/user_data_entity.dart';
// import 'package:flowery_app/utils/flowery_method_helper.dart';
// import 'package:injectable/injectable.dart';
//
// @Injectable(as: LoginRemoteDataSource)
// class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
//   final ApiClient _apiClient;
//   final SecureStorage _secureStorage;
//   const LoginRemoteDataSourceImpl(this._apiClient, this._secureStorage);
//   @override
//   Future<Result<UserDataEntity?>> login({
//     required LoginRequestEntity request,
//   }) async {
//     return executeApi(() async {
//       final response = await _apiClient.login(
//         request: RequestMapper.toLoginRequestModel(loginRequestEntity: request),
//       );
//       await _secureStorage.saveUserToken(token: response.token);
//       FloweryMethodHelper.currentUserToken = response.token;
//       final userData = response.userData?.toUserDataEntity();
//       return userData;
//     });
//   }
// }
