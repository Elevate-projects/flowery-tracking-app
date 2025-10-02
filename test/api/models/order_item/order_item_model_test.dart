// test/api/models/order_item/order_item_model_test.dart

import 'package:flowery_tracking_app/api/models/order_item/order_item_model.dart';
import 'package:flowery_tracking_app/api/models/product/product_model.dart';
import 'package:flowery_tracking_app/domain/entities/order_item/order_item_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("test toOrderItemEntity", () {
    test(
      "when call toOrderItemEntity with null values it should return OrderItemEntity with null values",
      () {
        // Arrange
        final OrderItemModel orderItemModel = OrderItemModel(
          product: null,
          price: null,
          quantity: null,
          id: null,
        );

        // Act
        final OrderItemEntity actualResult = orderItemModel.toOrderItemEntity();

        // Assert
        expect(actualResult.id, equals(orderItemModel.id));
        expect(actualResult.price, equals(orderItemModel.price));
        expect(actualResult.quantity, equals(orderItemModel.quantity));
        expect(
          actualResult.product,
          equals(orderItemModel.product?.toProductEntity()),
        );
      },
    );

    test(
      "when call toOrderItemEntity with non-nullable values it should return OrderItemEntity with correct values",
      () {
        // Arrange
        final productModel = ProductModel(
          id: "p1",
          title: "Rose Bouquet",
          slug: "rose-bouquet",
          description: "Fresh red roses",
          imgCover: "img.jpg",
          images: ["img1.jpg", "img2.jpg"],
          price: 200,
          priceAfterDiscount: 150,
          quantity: 10,
          category: "Flowers",
          occasion: "Valentine",
          createdAt: "2023-01-01",
          updatedAt: "2023-01-02",
          v: 1,
          isSuperAdmin: false,
          sold: 5,
        );

        final OrderItemModel orderItemModel = OrderItemModel(
          product: productModel,
          price: 150,
          quantity: 2,
          id: "o1",
        );

        // Act
        final OrderItemEntity actualResult = orderItemModel.toOrderItemEntity();

        // Assert
        expect(actualResult.id, equals(orderItemModel.id));
        expect(actualResult.price, equals(orderItemModel.price));
        expect(actualResult.quantity, equals(orderItemModel.quantity));
        expect(actualResult.product?.id, equals(orderItemModel.product?.id));
        expect(
          actualResult.product?.title,
          equals(orderItemModel.product?.title),
        );
        expect(
          actualResult.product?.price,
          equals(orderItemModel.product?.price),
        );
      },
    );
  });

  group("test JSON serialization", () {
    test("toJson and fromJson should work correctly", () {
      // Arrange
      final productModel = ProductModel(
        id: "p1",
        title: "Rose Bouquet",
        slug: "rose-bouquet",
        description: "Fresh red roses",
        imgCover: "img.jpg",
        images: ["img1.jpg", "img2.jpg"],
        price: 200,
        priceAfterDiscount: 150,
        quantity: 10,
        category: "Flowers",
        occasion: "Valentine",
        createdAt: "2023-01-01",
        updatedAt: "2023-01-02",
        v: 1,
        isSuperAdmin: false,
        sold: 5,
      );

      final orderItemModel = OrderItemModel(
        product: productModel,
        price: 150,
        quantity: 2,
        id: "o1",
      );

      // Act
      final json = orderItemModel.toJson();
      final fromJson = OrderItemModel.fromJson(json);

      // Assert
      expect(fromJson.id, equals(orderItemModel.id));
      expect(fromJson.price, equals(orderItemModel.price));
      expect(fromJson.quantity, equals(orderItemModel.quantity));
      expect(fromJson.product?.id, equals(orderItemModel.product?.id));
      expect(fromJson.product?.title, equals(orderItemModel.product?.title));
      expect(fromJson.product?.price, equals(orderItemModel.product?.price));
    });
  });
}
