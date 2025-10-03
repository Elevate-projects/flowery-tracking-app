// test/api/models/order/order_model_test.dart

import 'package:flowery_tracking_app/api/models/order/order_model.dart';
import 'package:flowery_tracking_app/api/models/order_item/order_item_model.dart';
import 'package:flowery_tracking_app/api/models/product/product_model.dart';
import 'package:flowery_tracking_app/api/models/shipping_address/shipping_address_model.dart';
import 'package:flowery_tracking_app/api/models/store/store_model.dart';
import 'package:flowery_tracking_app/api/models/user/user_model.dart';
import 'package:flowery_tracking_app/domain/entities/order/order_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("test toOrderEntity", () {
    test(
      "when call toOrderEntity with null values it should return OrderEntity with null values (except shippingAddress uses dummy)",
      () {
        // Arrange
        final OrderModel orderModel = OrderModel(
          id: null,
          user: null,
          orderItems: null,
          totalPrice: null,
          shippingAddress: null,
          paymentType: null,
          isPaid: null,
          paidAt: null,
          isDelivered: null,
          state: null,
          createdAt: null,
          updatedAt: null,
          orderNumber: null,
          v: null,
          store: null,
        );

        // Act
        final OrderEntity actualResult = orderModel.toOrderEntity();

        // Assert
        expect(actualResult.id, equals(orderModel.id));
        expect(actualResult.user, equals(orderModel.user?.toUserEntity()));
        expect(
          actualResult.orderItems,
          equals(
            orderModel.orderItems?.map((e) => e.toOrderItemEntity()).toList(),
          ),
        );
        expect(actualResult.totalPrice, equals(orderModel.totalPrice));
        expect(actualResult.paymentType, equals(orderModel.paymentType));
        expect(actualResult.isPaid, equals(orderModel.isPaid));
        expect(actualResult.isDelivered, equals(orderModel.isDelivered));
        expect(actualResult.state, equals(orderModel.state));
        expect(actualResult.orderNumber, equals(orderModel.orderNumber));
        expect(actualResult.store, equals(orderModel.store?.toStoreEntity()));
        // shippingAddress should fallback to dummy
        expect(actualResult.shippingAddress, isNotNull);
        expect(actualResult.shippingAddress?.city, equals("Cairo"));
      },
    );

    test(
      "when call toOrderEntity with non-nullable values it should return OrderEntity with correct values",
      () {
        // Arrange
        final userModel = UserModel(
          id: "u1",
          firstName: "Ahmed",
          lastName: "Tarek",
          email: "ahmed@example.com",
          gender: "male",
          phone: "01012345678",
          photo: "photo_url",
          passwordChangedAt: "2023-09-30",
        );

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
          id: "oi1",
        );

        final shippingAddressModel = ShippingAddressModel(
          street: "Saqr-koresh",
          city: "Cairo",
          phone: "01010518802",
          lat: "31.7195459",
          long: "31.7195459",
        );

        final storeModel = StoreModel(
          name: "Flowery Store",
          image: "store.png",
          address: "Cairo Downtown",
          phoneNumber: "01000000000",
          latLong: "30.000,31.000",
        );

        final OrderModel orderModel = OrderModel(
          id: "o1",
          user: userModel,
          orderItems: [orderItemModel],
          totalPrice: 300,
          shippingAddress: shippingAddressModel,
          paymentType: "cash",
          isPaid: true,
          paidAt: "2023-01-05",
          isDelivered: false,
          state: "pending",
          createdAt: "2023-01-01",
          updatedAt: "2023-01-02",
          orderNumber: "12345",
          v: 1,
          store: storeModel,
        );

        // Act
        final OrderEntity actualResult = orderModel.toOrderEntity();

        // Assert
        expect(actualResult.id, equals(orderModel.id));
        expect(actualResult.user?.id, equals(orderModel.user?.id));
        expect(actualResult.orderItems?.length, equals(1));
        expect(
          actualResult.orderItems?.first.id,
          equals(orderModel.orderItems?.first.id),
        );
        expect(actualResult.totalPrice, equals(orderModel.totalPrice));
        expect(
          actualResult.shippingAddress?.city,
          equals(orderModel.shippingAddress?.city),
        );
        expect(actualResult.paymentType, equals(orderModel.paymentType));
        expect(actualResult.isPaid, equals(orderModel.isPaid));
        expect(actualResult.isDelivered, equals(orderModel.isDelivered));
        expect(actualResult.state, equals(orderModel.state));
        expect(actualResult.orderNumber, equals(orderModel.orderNumber));
        expect(actualResult.store?.name, equals(orderModel.store?.name));
      },
    );
  });

  group("test JSON serialization", () {
    test("toJson and fromJson should work correctly", () {
      // Arrange
      final userModel = UserModel(
        id: "u1",
        firstName: "Ahmed",
        lastName: "Tarek",
        email: "ahmed@example.com",
        gender: "male",
        phone: "01012345678",
        photo: "photo_url",
        passwordChangedAt: "2023-09-30",
      );

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
        id: "oi1",
      );

      final shippingAddressModel = ShippingAddressModel(
        street: "Saqr-koresh",
        city: "Cairo",
        phone: "01010518802",
        lat: "31.7195459",
        long: "31.7195459",
      );

      final storeModel = StoreModel(
        name: "Flowery Store",
        image: "store.png",
        address: "Cairo Downtown",
        phoneNumber: "01000000000",
        latLong: "30.000,31.000",
      );

      final orderModel = OrderModel(
        id: "o1",
        user: userModel,
        orderItems: [orderItemModel],
        totalPrice: 300,
        shippingAddress: shippingAddressModel,
        paymentType: "cash",
        isPaid: true,
        paidAt: "2023-01-05",
        isDelivered: false,
        state: "pending",
        createdAt: "2023-01-01",
        updatedAt: "2023-01-02",
        orderNumber: "12345",
        v: 1,
        store: storeModel,
      );

      // Act
      final json = orderModel.toJson();
      final fromJson = OrderModel.fromJson(json);

      // Assert
      expect(fromJson.id, equals(orderModel.id));
      expect(fromJson.user?.id, equals(orderModel.user?.id));
      expect(
        fromJson.orderItems?.first.id,
        equals(orderModel.orderItems?.first.id),
      );
      expect(fromJson.totalPrice, equals(orderModel.totalPrice));
      expect(
        fromJson.shippingAddress?.city,
        equals(orderModel.shippingAddress?.city),
      );
      expect(fromJson.paymentType, equals(orderModel.paymentType));
      expect(fromJson.isPaid, equals(orderModel.isPaid));
      expect(fromJson.isDelivered, equals(orderModel.isDelivered));
      expect(fromJson.state, equals(orderModel.state));
      expect(fromJson.orderNumber, equals(orderModel.orderNumber));
      expect(fromJson.store?.name, equals(orderModel.store?.name));
    });
  });
}
