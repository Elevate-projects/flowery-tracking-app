import 'package:flowery_tracking_app/api/models/shipping_address/shipping_address_model.dart';
import 'package:flowery_tracking_app/domain/entities/shipping_address/shipping_address_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("test toShippingAddressEntity", () {
    test(
      "when call toShippingAddressEntity with null values it should return ShippingAddressEntity with null values",
      () {
        // Arrange
        final ShippingAddressModel model = ShippingAddressModel(
          street: null,
          city: null,
          phone: null,
          lat: null,
          long: null,
        );

        // Act
        final ShippingAddressEntity actualResult = model
            .toShippingAddressEntity();

        // Assert
        expect(actualResult.street, equals(model.street));
        expect(actualResult.city, equals(model.city));
        expect(actualResult.phone, equals(model.phone));
        expect(actualResult.lat, equals(model.lat));
        expect(actualResult.long, equals(model.long));
      },
    );

    test(
      "when call toShippingAddressEntity with non-null values it should return ShippingAddressEntity with correct values",
      () {
        // Arrange
        final ShippingAddressModel model = ShippingAddressModel(
          phone: "+201116211489",
          city: "Cairo",
          street: "Saqr-koresh",
          lat: "29.98508582119217",
          long: "31.27334386662929",
        );

        // Act
        final ShippingAddressEntity actualResult = model
            .toShippingAddressEntity();

        // Assert
        expect(actualResult.street, equals(model.street));
        expect(actualResult.city, equals(model.city));
        expect(actualResult.phone, equals(model.phone));
        expect(actualResult.lat, equals(model.lat));
        expect(actualResult.long, equals(model.long));
      },
    );
  });

  group("test JSON serialization", () {
    test("toJson and fromJson should work correctly", () {
      // Arrange
      final model = ShippingAddressModel(
        phone: "+201116211489",
        city: "Cairo",
        street: "Saqr-koresh",
        lat: "29.98508582119217",
        long: "31.27334386662929",
      );

      // Act
      final json = model.toJson();
      final fromJson = ShippingAddressModel.fromJson(json);

      // Assert
      expect(fromJson.street, equals(model.street));
      expect(fromJson.city, equals(model.city));
      expect(fromJson.phone, equals(model.phone));
      expect(fromJson.lat, equals(model.lat));
      expect(fromJson.long, equals(model.long));
    });
  });

  group("test dummy factory", () {
    test("dummy should return predefined values", () {
      // Act
      final dummy = ShippingAddressModel.dummy();

      // Assert
      expect(dummy.phone, equals("+201116211489"));
      expect(dummy.city, equals("Cairo"));
      expect(dummy.street, equals("Saqr-koresh"));
      expect(dummy.lat, equals("29.98508582119217"));
      expect(dummy.long, equals("31.27334386662929"));
    });
  });
}
