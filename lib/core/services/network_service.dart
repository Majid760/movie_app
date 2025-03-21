import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

sealed class NetworkInfo {
  bool get isConnect;
  Stream<bool> get connectivityStream;
}

// 2. Implement it in the infrastructure layer
class NetworkService implements NetworkInfo {
  final Connectivity _connectivity;
  final _connectionStatusController = StreamController<bool>.broadcast();
  bool _hasConnection = false;

  NetworkService(this._connectivity) {
    // Start listening to connectivity changes when created
    _initConnectivityListener();
  }

  void _initConnectivityListener() {
    _connectivity.onConnectivityChanged.listen((connectivityResults) async {
      _hasConnection = await _checkRealConnection(connectivityResults);
      _connectionStatusController.add(_hasConnection);
    });
  }

  Future<bool> _checkRealConnection(List<ConnectivityResult> results) async {
    try {
      if (results.isEmpty || (results.length == 1 && results.contains(ConnectivityResult.none))) {
        return false;
      }
      //CHECK DATA INSTEAD OF RADIO STATUS
      final result = await InternetAddress.lookup('www.google.com');
      return (result.isNotEmpty && result[0].rawAddress.isNotEmpty);
    } catch (error) {
      debugPrint('something went wrong! in connection${error.toString()}');
      return false;
    }
  }

  @override
  bool get isConnect => _hasConnection;

  @override
  Stream<bool> get connectivityStream => _connectionStatusController.stream;
}
