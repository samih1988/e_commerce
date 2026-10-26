import 'package:connectivity_plus/connectivity_plus.dart';

extension NetworkConnectivity on Connectivity {
  Future<bool> isConnected() async {
    final result = await Connectivity().checkConnectivity();
    return result.any((r) => r != ConnectivityResult.none);
  }
}