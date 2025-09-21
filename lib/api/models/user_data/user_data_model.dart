// import 'package:flowery_app/api/models/address/address_model.dart';
// import 'package:flowery_app/domain/entities/user_data/user_data_entity.dart';
// import 'package:json_annotation/json_annotation.dart';
//
// part 'user_data_model.g.dart';
//
// @JsonSerializable()
// class UserDataModel {
//   @JsonKey(name: "_id")
//   final String? id;
//   @JsonKey(name: "firstName")
//   final String? firstName;
//   @JsonKey(name: "lastName")
//   final String? lastName;
//   @JsonKey(name: "email")
//   final String? email;
//   @JsonKey(name: "gender")
//   final String? gender;
//   @JsonKey(name: "phone")
//   final String? phone;
//   @JsonKey(name: "photo")
//   final String? photo;
//   @JsonKey(name: "role")
//   final String? role;
//   @JsonKey(name: "wishlist")
//   final List<String>? wishlist;
//   @JsonKey(name: "addresses")
//   final List<AddressModel>? addresses;
//   @JsonKey(name: "createdAt")
//   final String? createdAt;
//   @JsonKey(name: "passwordResetCode")
//   final String? passwordResetCode;
//   @JsonKey(name: "passwordResetExpires")
//   final String? passwordResetExpires;
//   @JsonKey(name: "resetCodeVerified")
//   final bool? resetCodeVerified;
//
//   UserDataModel({
//     this.id,
//     this.firstName,
//     this.lastName,
//     this.email,
//     this.gender,
//     this.phone,
//     this.photo,
//     this.role,
//     this.wishlist,
//     this.addresses,
//     this.createdAt,
//     this.passwordResetCode,
//     this.passwordResetExpires,
//     this.resetCodeVerified,
//   });
//
//   factory UserDataModel.fromJson(Map<String, dynamic> json) {
//     return _$UserDataModelFromJson(json);
//   }
//
//   Map<String, dynamic> toJson() {
//     return _$UserDataModelToJson(this);
//   }
//
//   UserDataEntity toUserDataEntity() {
//     return UserDataEntity(
//       id: id,
//       firstName: firstName,
//       lastName: lastName,
//       email: email,
//       gender: gender,
//       phone: phone,
//       photo: photo,
//       role: role,
//       wishlist: wishlist,
//       addresses:
//           addresses?.map((address) => address.toAddressEntity()).toList() ?? [],
//       passwordResetCode: passwordResetCode,
//     );
//   }
// }
