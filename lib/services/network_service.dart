import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class NetworkService {
  final Connectivity _connectivity = Connectivity();

  // Check if device is connected to any network (wifi/mobile)
  Future<bool> hasNetwork() async {
    final result = await _connectivity.checkConnectivity();
    return result != ConnectivityResult.none;
  }

  // Check if device has actual internet access
  Future<bool> hasInternet() async {
    return await InternetConnectionChecker().hasConnection;
  }

  // Full check
  Future<bool> isConnected() async {
    final hasNetwork = await this.hasNetwork();
    if (!hasNetwork) return false;

    final hasInternet = await this.hasInternet();
    return hasInternet;
  }
}
