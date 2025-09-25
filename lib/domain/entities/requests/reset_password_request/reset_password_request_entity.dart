class ResetPasswordRequestEntity {
  final String email;
  final String newPassword;

  const ResetPasswordRequestEntity({
    required this.email,
    required this.newPassword,
  });
}
