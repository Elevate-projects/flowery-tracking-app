import 'package:connectivity_plus/connectivity_plus.dart';

abstract class ConnectionManager {
  static Connectivity connectivity = Connectivity();
  static Future<bool> checkConnection() async {
    final List<ConnectivityResult> connectivityResult = await (connectivity
        .checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.mobile)) {
      return true;
    } else if (connectivityResult.contains(ConnectivityResult.wifi)) {
      return true;
    } else {
      return false;
    }
  }
}
