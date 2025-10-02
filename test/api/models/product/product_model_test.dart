import 'package:flowery_tracking_app/api/models/product/product_model.dart';
import 'package:flowery_tracking_app/domain/entities/product/product_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("test toProductEntity", () {
    test(
      "when call toProductEntity with null values it should return ProductEntity with null values",
      () {
        // Arrange
        final ProductModel model = ProductModel(
          id: null,
          title: null,
          slug: null,
          description: null,
          imgCover: null,
          images: null,
          price: null,
          priceAfterDiscount: null,
          quantity: null,
          category: null,
          occasion: null,
          createdAt: null,
          updatedAt: null,
          v: null,
          isSuperAdmin: null,
          sold: null,
        );

        // Act
        final ProductEntity actualResult = model.toProductEntity();

        // Assert
        expect(actualResult.id, equals(model.id));
        expect(actualResult.title, equals(model.title));
        expect(actualResult.slug, equals(model.slug));
        expect(actualResult.description, equals(model.description));
        expect(actualResult.imgCover, equals(model.imgCover));
        expect(actualResult.images, equals(model.images));
        expect(actualResult.price, equals(model.price));
        expect(
          actualResult.priceAfterDiscount,
          equals(model.priceAfterDiscount),
        );
        expect(actualResult.quantity, equals(model.quantity));
        expect(actualResult.category, equals(model.category));
        expect(actualResult.occasion, equals(model.occasion));
        expect(actualResult.sold, equals(model.sold));
      },
    );

    test(
      "when call toProductEntity with non-null values it should return ProductEntity with correct values",
      () {
        // Arrange
        final ProductModel model = ProductModel(
          id: "p1",
          title: "Rose Bouquet",
          slug: "rose-bouquet",
          description: "A bouquet of red roses",
          imgCover: "cover.jpg",
          images: ["img1.jpg", "img2.jpg"],
          price: 300,
          priceAfterDiscount: 250,
          quantity: 20,
          category: "flowers",
          occasion: "valentines",
          createdAt: "2024-01-01",
          updatedAt: "2024-01-02",
          v: 1,
          isSuperAdmin: false,
          sold: 10,
        );

        // Act
        final ProductEntity actualResult = model.toProductEntity();

        // Assert
        expect(actualResult.id, equals(model.id));
        expect(actualResult.title, equals(model.title));
        expect(actualResult.slug, equals(model.slug));
        expect(actualResult.description, equals(model.description));
        expect(actualResult.imgCover, equals(model.imgCover));
        expect(actualResult.images, equals(model.images));
        expect(actualResult.price, equals(model.price));
        expect(
          actualResult.priceAfterDiscount,
          equals(model.priceAfterDiscount),
        );
        expect(actualResult.quantity, equals(model.quantity));
        expect(actualResult.category, equals(model.category));
        expect(actualResult.occasion, equals(model.occasion));
        expect(actualResult.sold, equals(model.sold));
      },
    );
  });

  group("test JSON serialization", () {
    test("toJson and fromJson should work correctly", () {
      // Arrange
      final model = ProductModel(
        id: "p1",
        title: "Rose Bouquet",
        slug: "rose-bouquet",
        description: "A bouquet of red roses",
        imgCover: "cover.jpg",
        images: ["img1.jpg", "img2.jpg"],
        price: 300,
        priceAfterDiscount: 250,
        quantity: 20,
        category: "flowers",
        occasion: "valentines",
        createdAt: "2024-01-01",
        updatedAt: "2024-01-02",
        v: 1,
        isSuperAdmin: false,
        sold: 10,
      );

      // Act
      final json = model.toJson();
      final fromJson = ProductModel.fromJson(json);

      // Assert
      expect(fromJson.id, equals(model.id));
      expect(fromJson.title, equals(model.title));
      expect(fromJson.slug, equals(model.slug));
      expect(fromJson.description, equals(model.description));
      expect(fromJson.imgCover, equals(model.imgCover));
      expect(fromJson.images, equals(model.images));
      expect(fromJson.price, equals(model.price));
      expect(fromJson.priceAfterDiscount, equals(model.priceAfterDiscount));
      expect(fromJson.quantity, equals(model.quantity));
      expect(fromJson.category, equals(model.category));
      expect(fromJson.occasion, equals(model.occasion));
      expect(fromJson.sold, equals(model.sold));
    });
  });

  group("test ProductEntity equatable", () {
    test("two ProductEntity with same values should be equal", () {
      final entity1 = const ProductEntity(
        id: "p1",
        title: "Rose Bouquet",
        slug: "rose-bouquet",
        description: "A bouquet of red roses",
        imgCover: "cover.jpg",
        images: ["img1.jpg", "img2.jpg"],
        price: 300,
        priceAfterDiscount: 250,
        quantity: 20,
        category: "flowers",
        occasion: "valentines",
        sold: 10,
      );

      final entity2 = const ProductEntity(
        id: "p1",
        title: "Rose Bouquet",
        slug: "rose-bouquet",
        description: "A bouquet of red roses",
        imgCover: "cover.jpg",
        images: ["img1.jpg", "img2.jpg"],
        price: 300,
        priceAfterDiscount: 250,
        quantity: 20,
        category: "flowers",
        occasion: "valentines",
        sold: 10,
      );

      expect(entity1, equals(entity2));
    });
  });
}
