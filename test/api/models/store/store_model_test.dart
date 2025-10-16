import 'package:flowery_tracking_app/api/models/store/store_model.dart';
import 'package:flowery_tracking_app/domain/entities/store/store_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("test toStoreEntity", () {
    test(
      "when call toStoreEntity with null values it should return StoreEntity with null values",
      () {
        // Arrange
        final StoreModel storeModel = StoreModel(
          name: null,
          image: null,
          address: null,
          phoneNumber: null,
          latLong: null,
        );

        // Act
        final StoreEntity actualResult = storeModel.toStoreEntity();

        // Assert
        expect(actualResult.name, equals(storeModel.name));
        expect(actualResult.image, equals(storeModel.image));
        expect(actualResult.address, equals(storeModel.address));
        expect(actualResult.phoneNumber, equals(storeModel.phoneNumber));
        expect(actualResult.latLong, equals(storeModel.latLong));
      },
    );

    test(
      "when call toStoreEntity with non-nullable values it should return StoreEntity with correct values",
      () {
        // Arrange
        final StoreModel storeModel = StoreModel(
          name: "Flower Shop",
          image: "shop_image.png",
          address: "123 Main Street",
          phoneNumber: "01098765432",
          latLong: "30.0444,31.2357",
        );

        // Act
        final StoreEntity actualResult = storeModel.toStoreEntity();

        // Assert
        expect(actualResult.name, equals(storeModel.name));
        expect(actualResult.image, equals(storeModel.image));
        expect(actualResult.address, equals(storeModel.address));
        expect(actualResult.phoneNumber, equals(storeModel.phoneNumber));
        expect(actualResult.latLong, equals(storeModel.latLong));
      },
    );
  });

  group("test JSON serialization", () {
    test("toJson and fromJson should work correctly", () {
      // Arrange
      final storeModel = StoreModel(
        name: "Flower Shop",
        image: "shop_image.png",
        address: "123 Main Street",
        phoneNumber: "01098765432",
        latLong: "30.0444,31.2357",
      );

      // Act
      final json = storeModel.toJson();
      final fromJson = StoreModel.fromJson(json);

      // Assert
      expect(fromJson.name, equals(storeModel.name));
      expect(fromJson.image, equals(storeModel.image));
      expect(fromJson.address, equals(storeModel.address));
      expect(fromJson.phoneNumber, equals(storeModel.phoneNumber));
      expect(fromJson.latLong, equals(storeModel.latLong));
    });
  });
}
