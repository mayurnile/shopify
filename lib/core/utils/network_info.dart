import 'package:data_connection_checker/data_connection_checker.dart';

class NetworkInfo {
  static Future<bool> get isConnected {
    DataConnectionChecker dataConnectionChecker = DataConnectionChecker();
    return dataConnectionChecker.hasConnection;
  }
}
