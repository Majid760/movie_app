import 'package:dio/dio.dart';

abstract class Failure {
  final String message;

  const Failure(this.message);
  @override
  String toString() {
    return message.toString();
  }
}

class FirebaseAuthFailure extends Failure {
  const FirebaseAuthFailure(super.message);

  @override
  String toString() {
    return 'FirebaseAuthFailure: An error occurred while trying to authenticate the user';
  }
}

class ServerFailure extends Failure {
  const ServerFailure(super.message);

  @override
  String toString() {
    return 'ServerFailure: An error occurred while trying to communicate with the server';
  }
}

class NetworkFailure extends Failure {
  const NetworkFailure(super.message);

  @override
  String toString() {
    return 'NetworkFailure: No internet connection!';
  }
}

class CacheFailure extends Failure {
  const CacheFailure(super.message);

  @override
  String toString() {
    return 'CacheFailure: An error occurred while trying to cache data';
  }
}

class ApiException implements Exception {
  final String url;
  final String message;
  final int? statusCode;
  final Response? response;

  ApiException({
    required this.url,
    required this.message,
    this.response,
    this.statusCode,
  });
}

// You can add more failure types as needed
