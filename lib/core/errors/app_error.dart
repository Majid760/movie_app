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
}

class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

class CacheFailure extends Failure {
  const CacheFailure(super.message);
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
