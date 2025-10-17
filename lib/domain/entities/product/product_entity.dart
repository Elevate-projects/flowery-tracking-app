import 'package:equatable/equatable.dart';

final class ProductEntity extends Equatable {
  final String? id;
  final String? title;
  final String? slug;
  final String? description;
  final String? imgCover;
  final List<String>? images;
  final int? price;
  final int? priceAfterDiscount;
  final int? quantity;
  final String? category;
  final String? occasion;
  final int? sold;

  const ProductEntity({
    this.id,
    this.title,
    this.slug,
    this.description,
    this.imgCover,
    this.images,
    this.price,
    this.priceAfterDiscount,
    this.quantity,
    this.category,
    this.occasion,
    this.sold,
  });

  @override
  List<Object?> get props => [
    id,
    price,
    title,
    imgCover,
    quantity,
    sold,
    category,
    occasion,
    description,
    images,
    priceAfterDiscount,
    slug,
  ];
}
