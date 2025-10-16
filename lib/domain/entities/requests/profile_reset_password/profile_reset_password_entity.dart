class ProfileResetPasswordRequestEntity {
  final String password;
  final String newPassword;

  const ProfileResetPasswordRequestEntity({
    required this.password,
    required this.newPassword,
  });
}
