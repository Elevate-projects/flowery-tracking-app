import 'package:flowery_tracking_app/api/requests/apply_request/apply_request_model.dart';
import 'package:flowery_tracking_app/api/requests/login_request/login_request_model.dart';
import 'package:flowery_tracking_app/domain/entities/requests/apply_request/apply_request_entity.dart';
import 'package:flowery_tracking_app/domain/entities/requests/login_request/login_request_entity.dart';

abstract class RequestMapper {
  static LoginRequestModel toLoginRequestModel({
    required LoginRequestEntity loginRequestEntity,
  }) {
    return LoginRequestModel(
      email: loginRequestEntity.email,
      password: loginRequestEntity.password,
    );
  }

  static ApplyRequestModel toApplyRequestModel({
    required ApplyRequestEntity applyRequestEntity,
  }) {
    return ApplyRequestModel(
      country: applyRequestEntity.country,
      firstName: applyRequestEntity.firstName,
      lastName: applyRequestEntity.lastName,
      vehicleType: applyRequestEntity.vehicleType,
      vehicleNumber: applyRequestEntity.vehicleNumber,
      vehicleLicense: applyRequestEntity.vehicleLicense,
      nid: applyRequestEntity.nid,
      nidImg: applyRequestEntity.nidImg,
      email: applyRequestEntity.email,
      password: applyRequestEntity.password,
      rePassword: applyRequestEntity.rePassword,
      gender: applyRequestEntity.gender,
      phone: applyRequestEntity.phone,
    );
  }
}
