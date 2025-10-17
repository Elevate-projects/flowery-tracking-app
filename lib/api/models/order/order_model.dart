import 'package:flowery_tracking_app/api/models/order_item/order_item_model.dart';
import 'package:flowery_tracking_app/api/models/shipping_address/shipping_address_model.dart';
import 'package:flowery_tracking_app/api/models/store/store_model.dart';
import 'package:flowery_tracking_app/api/models/user/user_model.dart';
import 'package:flowery_tracking_app/domain/entities/order/order_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_model.g.dart';

@JsonSerializable(explicitToJson: true)
final class OrderModel {
  @JsonKey(name: "_id")
  final String? id;
  @JsonKey(name: "user")
  final UserModel? user;
  @JsonKey(name: "orderItems")
  final List<OrderItemModel>? orderItems;
  @JsonKey(name: "totalPrice")
  final int? totalPrice;
  @JsonKey(name: "shippingAddress")
  final ShippingAddressModel? shippingAddress;
  @JsonKey(name: "paymentType")
  final String? paymentType;
  @JsonKey(name: "isPaid")
  final bool? isPaid;
  @JsonKey(name: "paidAt")
  final String? paidAt;
  @JsonKey(name: "isDelivered")
  final bool? isDelivered;
  @JsonKey(name: "state")
  final String? state;
  @JsonKey(name: "createdAt")
  final String? createdAt;
  @JsonKey(name: "updatedAt")
  final String? updatedAt;
  @JsonKey(name: "orderNumber")
  final String? orderNumber;
  @JsonKey(name: "__v")
  final int? v;
  @JsonKey(name: "store")
  final StoreModel? store;
  @JsonKey(name: "DriverName")
  final String? driverName;
  @JsonKey(name: "DriverPhone")
  final String? driverPhone;
  @JsonKey(name: "DriverLatitude")
  final num? driverLatitude;
  @JsonKey(name: "DriverLongitude")
  final num? driverLongitude;
  @JsonKey(name: "OrderAcceptedAt")
  final String? orderAcceptedAt;
  @JsonKey(name: "EstimatedArrival")
  final String? estimatedArrival;
  @JsonKey(name: "PreparingYourOrderAt")
  final String? preparingYourOrderAt;
  @JsonKey(name: "OutForDeliveryAt")
  final String? outForDeliveryAt;
  @JsonKey(name: "ArrivedAt")
  final String? arrivedAt;
  @JsonKey(name: "DeliveredAt")
  final String? deliveredAt;

  OrderModel({
    this.id,
    this.user,
    this.orderItems,
    this.totalPrice,
    this.shippingAddress,
    this.paymentType,
    this.isPaid,
    this.paidAt,
    this.isDelivered,
    this.state,
    this.createdAt,
    this.updatedAt,
    this.orderNumber,
    this.v,
    this.store,
    this.driverName,
    this.driverPhone,
    this.driverLatitude,
    this.driverLongitude,
    this.orderAcceptedAt,
    this.estimatedArrival,
    this.preparingYourOrderAt,
    this.outForDeliveryAt,
    this.arrivedAt,
    this.deliveredAt,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return _$OrderModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$OrderModelToJson(this);
  }

  OrderEntity toOrderEntity() {
    return OrderEntity(
      id: id,
      user: user?.toUserEntity(),
      orderItems: orderItems?.map((item) => item.toOrderItemEntity()).toList(),
      totalPrice: totalPrice,
      shippingAddress:
          shippingAddress?.toShippingAddressEntity() ??
          ShippingAddressModel.dummy().toShippingAddressEntity(),
      paymentType: paymentType,
      isPaid: isPaid,
      isDelivered: isDelivered,
      state: state,
      orderNumber: orderNumber,
      store: store?.toStoreEntity(),
      deliveredAt: deliveredAt,
      arrivedAt: arrivedAt,
      driverLatitude: driverLatitude,
      driverLongitude: driverLongitude,
      driverName: driverName,
      driverPhone: driverPhone,
      estimatedArrival: estimatedArrival,
      orderAcceptedAt: orderAcceptedAt,
      outForDeliveryAt: outForDeliveryAt,
      preparingYourOrderAt: preparingYourOrderAt,
    );
  }
}
