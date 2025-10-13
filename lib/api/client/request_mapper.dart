import 'package:flowery_tracking_app/api/models/order/order_model.dart';
import 'package:flowery_tracking_app/api/models/order_item/order_item_model.dart';
import 'package:flowery_tracking_app/api/models/product/product_model.dart';
import 'package:flowery_tracking_app/api/models/shipping_address/shipping_address_model.dart';
import 'package:flowery_tracking_app/api/models/store/store_model.dart';
import 'package:flowery_tracking_app/api/models/user/user_model.dart';
import 'package:flowery_tracking_app/api/requests/edit_vehicle/edit_vehicle_request.dart';
import 'package:flowery_tracking_app/api/requests/forget_password_and_resend_code/forget_password_and_resend_code_request_model.dart';
import 'package:flowery_tracking_app/api/requests/login_request/login_request_model.dart';
import 'package:flowery_tracking_app/api/requests/order_details/update_order_status_request_model.dart';
import 'package:flowery_tracking_app/api/requests/profile%20_reset_password/profile_reset_password_request.dart';
import 'package:flowery_tracking_app/api/requests/reset_password/reset_password_request_model.dart';
import 'package:flowery_tracking_app/api/requests/verification/verify_request_model.dart';
import 'package:flowery_tracking_app/domain/entities/edit_vehicle/edit_vehicle_entity.dart';
import 'package:flowery_tracking_app/core/constants/const_keys.dart';
import 'package:flowery_tracking_app/domain/entities/order/order_entity.dart';
import 'package:flowery_tracking_app/domain/entities/requests/forget_password_and_resend_code_request/forget_password_and_resend_code_request_entity.dart';
import 'package:flowery_tracking_app/domain/entities/requests/login_request/login_request_entity.dart';
import 'package:flowery_tracking_app/domain/entities/requests/order_details/update_order_status_request_entity.dart';
import 'package:flowery_tracking_app/domain/entities/requests/profile_reset_password/profile_reset_password_entity.dart';
import 'package:flowery_tracking_app/domain/entities/requests/reset_password_request/reset_password_request_entity.dart';
import 'package:flowery_tracking_app/domain/entities/requests/verify_request/verify_requset_entity.dart';
import 'package:flowery_tracking_app/utils/flowery_driver_method_helper.dart';

abstract final class RequestMapper {
  static LoginRequestModel toLoginRequestModel({
    required LoginRequestEntity loginRequestEntity,
  }) {
    return LoginRequestModel(
      email: loginRequestEntity.email,
      password: loginRequestEntity.password,
    );
  }

  static ForgetPasswordAndResendCodeRequestModel
  toForgetPasswordAndResendCodeRequestModel({
    required ForgetPasswordAndResendCodeRequestEntity
    forgetPasswordRequestEntity,
  }) {
    return ForgetPasswordAndResendCodeRequestModel(
      email: forgetPasswordRequestEntity.email,
    );
  }

  static VerifyRequestModel verifyToModel(VerifyRequestEntity entity) {
    return VerifyRequestModel(resetCode: entity.resetCode);
  }

  static ResetPasswordRequestModel resetPasswordToModel(
    ResetPasswordRequestEntity entity,
  ) {
    return ResetPasswordRequestModel(
      email: entity.email,
      newPassword: entity.newPassword,
    );
  }

  static OrderModel orderEntityToModel({required OrderEntity orderEntity}) {
    return OrderModel(
      id: orderEntity.id,
      user: UserModel(
        id: orderEntity.user?.id,
        firstName: orderEntity.user?.firstName,
        lastName: orderEntity.user?.lastName,
        email: orderEntity.user?.email,
        photo: orderEntity.user?.photo,
        gender: orderEntity.user?.gender,
        phone: orderEntity.user?.phone,
      ),
      orderItems: orderEntity.orderItems
          ?.map(
            (orderItem) => OrderItemModel(
              id: orderItem.id,
              quantity: orderItem.quantity,
              price: orderItem.price,
              product: ProductModel(
                id: orderItem.product?.id,
                title: orderItem.product?.title,
                slug: orderItem.product?.slug,
                description: orderItem.product?.description,
                imgCover: orderItem.product?.imgCover,
                images: orderItem.product?.images,
                price: orderItem.product?.price,
                priceAfterDiscount: orderItem.product?.priceAfterDiscount,
                quantity: orderItem.product?.quantity,
                category: orderItem.product?.category,
                occasion: orderItem.product?.occasion,
                sold: orderItem.product?.sold,
              ),
            ),
          )
          .toList(),
      shippingAddress: ShippingAddressModel(
        street: orderEntity.shippingAddress?.street,
        city: orderEntity.shippingAddress?.city,
        phone: orderEntity.shippingAddress?.phone,
        lat: orderEntity.shippingAddress?.lat,
        long: orderEntity.shippingAddress?.long,
      ),
      totalPrice: orderEntity.totalPrice,
      paymentType: orderEntity.paymentType,
      isPaid: orderEntity.isPaid,
      isDelivered: orderEntity.isDelivered,
      state: "inProgress",
      orderNumber: orderEntity.orderNumber,
      store: StoreModel(
        name: orderEntity.store?.name,
        image: orderEntity.store?.image,
        address: orderEntity.store?.address,
        phoneNumber: orderEntity.store?.phoneNumber,
        latLong: orderEntity.store?.latLong,
      ),
    );
  }

  static ProfileResetPasswordRequestModel toProfileResetPasswordRequest({
    required ProfileResetPasswordRequestEntity entity,
  }) {
    return ProfileResetPasswordRequestModel(
      password: entity.password,
      newPassword: entity.newPassword,
    );
  }

  static UpdateOrderStatusRequestModel toUpdateOrderStatusRequestModel({
    required UpdateOrderStatusRequestEntity updateOrderStatusRequestEntity,
  }) {
    if (updateOrderStatusRequestEntity.orderStatus ==
        CurrentOrderState.completed.name) {
      return UpdateOrderStatusRequestModel(state: ConstKeys.completed);
    } else {
      return UpdateOrderStatusRequestModel(state: ConstKeys.inProgress);
    }
  }
  static EditVehicleRequest toEditVehicleRequest(EditVehicleEntity entity) {
    return EditVehicleRequest(
      vehicleLicense: entity.vehicleLicense,
      vehicleNumber: entity.vehicleNumber,
      vehicleType: entity.vehicleType,
    );
  }
}
