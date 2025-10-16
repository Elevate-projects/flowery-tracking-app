import 'package:equatable/equatable.dart';
import 'package:flowery_tracking_app/domain/entities/order_item/order_item_entity.dart';
import 'package:flowery_tracking_app/domain/entities/shipping_address/shipping_address_entity.dart';
import 'package:flowery_tracking_app/domain/entities/store/store_entity.dart';
import 'package:flowery_tracking_app/domain/entities/user/user_entity.dart';

final class OrderEntity extends Equatable {
  final String? id;
  final UserEntity? user;
  final List<OrderItemEntity>? orderItems;
  final int? totalPrice;
  final ShippingAddressEntity? shippingAddress;
  final String? paymentType;
  final bool? isPaid;
  final bool? isDelivered;
  final String? state;
  final String? orderNumber;
  final StoreEntity? store;
  final String? driverName;
  final String? driverPhone;
  final num? driverLatitude;
  final num? driverLongitude;
  final String? orderAcceptedAt;
  final String? estimatedArrival;
  final String? preparingYourOrderAt;
  final String? outForDeliveryAt;
  final String? arrivedAt;
  final String? deliveredAt;

  const OrderEntity({
    this.id,
    this.user,
    this.orderItems,
    this.totalPrice,
    this.shippingAddress,
    this.paymentType,
    this.isPaid,
    this.isDelivered,
    this.state,
    this.orderNumber,
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

  @override
  List<Object?> get props => [
    id,
    user,
    orderItems,
    totalPrice,
    shippingAddress,
    paymentType,
    isPaid,
    isDelivered,
    state,
    orderNumber,
    store,
    driverName,
    driverPhone,
    driverLatitude,
    driverLongitude,
    orderAcceptedAt,
    estimatedArrival,
    preparingYourOrderAt,
    outForDeliveryAt,
    arrivedAt,
    deliveredAt,
  ];
}
