import 'package:flowery_tracking_app/api/models/order_item/order_item_model.dart';
import 'package:flowery_tracking_app/api/models/shipping_address/shipping_address_model.dart';
import 'package:flowery_tracking_app/api/models/store/store_model.dart';
import 'package:flowery_tracking_app/api/models/user/user_model.dart';
import 'package:flowery_tracking_app/domain/entities/order/order_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_model.g.dart';

@JsonSerializable()
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
      shippingAddress: shippingAddress?.toShippingAddressEntity(),
      paymentType: paymentType,
      isPaid: isPaid,
      isDelivered: isDelivered,
      state: state,
      orderNumber: orderNumber,
      store: store?.toStoreEntity(),
    );
  }
}
