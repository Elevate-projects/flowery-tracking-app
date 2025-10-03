import 'package:equatable/equatable.dart';
import 'package:flowery_tracking_app/domain/entities/product/product_entity.dart';

final class OrderItemEntity extends Equatable {
  final ProductEntity? product;

  final int? price;

  final int? quantity;

  final String? id;

  const OrderItemEntity({this.product, this.price, this.quantity, this.id});

  @override
  List<Object?> get props => [product, price, quantity, id];
}
