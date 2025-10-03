abstract class Endpoints {
  static const String baseUrl = 'https://flower.elevateegy.com';
  static const String login = '/api/v1/drivers/signin';
  static const String forgetPasswordAndResendCode =
      '/api/v1/drivers/forgotPassword';
  static const String verification = '/api/v1/drivers/verifyResetCode';
  static const String resetPassword = '/api/v1/drivers/resetPassword';
  static const String profileResetPassword = '/api/v1/drivers/change-password';
  static const String driverPendingOrders = '/api/v1/orders/pending-orders';
  static const String startOrder = '/api/v1/orders/start/{orderId}';
  static const String editVehicle = '/api/v1/drivers/editProfile';
}
