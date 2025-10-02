import 'package:flowery_tracking_app/api/models/user/user_model.dart';
import 'package:flowery_tracking_app/domain/entities/user/user_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("test toUserEntity", () {
    test(
      "when call toUserEntity with null values it should return UserEntity with null values",
      () {
        // Arrange
        final UserModel userModel = UserModel(
          id: null,
          firstName: null,
          lastName: null,
          email: null,
          gender: null,
          phone: null,
          photo: null,
          passwordChangedAt: null,
        );

        // Act
        final UserEntity actualResult = userModel.toUserEntity();

        // Assert
        expect(actualResult.id, equals(userModel.id));
        expect(actualResult.firstName, equals(userModel.firstName));
        expect(actualResult.lastName, equals(userModel.lastName));
        expect(actualResult.email, equals(userModel.email));
        expect(actualResult.gender, equals(userModel.gender));
        expect(actualResult.phone, equals(userModel.phone));
        expect(actualResult.photo, equals(userModel.photo));
      },
    );

    test(
      "when call toUserEntity with non-nullable values it should return UserEntity with correct values",
      () {
        // Arrange
        final UserModel userModel = UserModel(
          id: "123",
          firstName: "Ahmed",
          lastName: "Tarek",
          email: "ahmed@example.com",
          gender: "male",
          phone: "01012345678",
          photo: "photo_url",
          passwordChangedAt: "2023-09-30",
        );

        // Act
        final UserEntity actualResult = userModel.toUserEntity();

        // Assert
        expect(actualResult.id, equals(userModel.id));
        expect(actualResult.firstName, equals(userModel.firstName));
        expect(actualResult.lastName, equals(userModel.lastName));
        expect(actualResult.email, equals(userModel.email));
        expect(actualResult.gender, equals(userModel.gender));
        expect(actualResult.phone, equals(userModel.phone));
        expect(actualResult.photo, equals(userModel.photo));
      },
    );
  });

  group("test JSON serialization", () {
    test("toJson and fromJson should work correctly", () {
      // Arrange
      final userModel = UserModel(
        id: "123",
        firstName: "Ahmed",
        lastName: "Tarek",
        email: "ahmed@example.com",
        gender: "male",
        phone: "01012345678",
        photo: "photo_url",
        passwordChangedAt: "2023-09-30",
      );

      // Act
      final json = userModel.toJson();
      final fromJson = UserModel.fromJson(json);

      // Assert
      expect(fromJson.id, equals(userModel.id));
      expect(fromJson.firstName, equals(userModel.firstName));
      expect(fromJson.lastName, equals(userModel.lastName));
      expect(fromJson.email, equals(userModel.email));
      expect(fromJson.gender, equals(userModel.gender));
      expect(fromJson.phone, equals(userModel.phone));
      expect(fromJson.photo, equals(userModel.photo));
      expect(fromJson.passwordChangedAt, equals(userModel.passwordChangedAt));
    });
  });
}
