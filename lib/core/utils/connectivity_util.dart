import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityUtil {
  final Connectivity _connectivity = Connectivity();

  Future<bool> isConnected() async {
    final result = await _connectivity.checkConnectivity();
    return !result.contains(ConnectivityResult.none);
  }
}
