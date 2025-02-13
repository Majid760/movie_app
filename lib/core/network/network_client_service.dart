import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../errors/app_error.dart';

class BaseClientService {
  String noInternetConnection = 'No internet connection';
  String serverNotResponding = 'Server not responding';
  String serverError = 'Server error';
  String nullResponse = 'Null response';

  BaseClientService({required this.dio});

  final Dio dio;

  // GET request
  Future<dynamic> get(String url,
      {Map<String, dynamic>? headers,
      Map<String, dynamic>? queryParameters,
      required Function(Response response) onSuccess,
      Function(ApiException)? onError,
      Function(int value, int progress)? onReceiveProgress,
      Function? onLoading}) async {
    try {
      // 1) indicate loading state
      onLoading?.call();
      // 2) try to perform http request
      var response = await dio.get(url, onReceiveProgress: onReceiveProgress, queryParameters: queryParameters);
      // 3) return response (api done successfully)
      return await onSuccess(response);
    } on DioException catch (error) {
      // dio error (api reach the server but not performed successfully
      // no internet connection
      if (error.message?.toLowerCase().contains('socket') ?? false) {
        return onError?.call(ApiException(message: noInternetConnection, url: url)) ??
            _handleError(noInternetConnection);
      }

      // no response
      if (error.response == null) {
        var exception = ApiException(url: url, message: error.message ?? nullResponse);
        return onError?.call(exception) ?? handleApiError(exception);
      }

      // check if the error is 500 (server problem)
      if (error.response?.statusCode == 500) {
        var exception = ApiException(message: serverError, url: url, statusCode: 500);
        return onError?.call(exception) ?? handleApiError(exception);
      }
    } on SocketException {
      // No internet connection
      return onError?.call(ApiException(message: noInternetConnection, url: url)) ?? _handleError(noInternetConnection);
    } on TimeoutException {
      // Api call went out of time
      return onError?.call(ApiException(message: serverNotResponding, url: url)) ?? _handleError(serverNotResponding);
    } catch (error) {
      // unexpected error for example (parsing json error)
      return onError?.call(ApiException(message: error.toString(), url: url)) ?? _handleError(error.toString());
    }
  }

  // POST request
  Future<dynamic> post(String url,
      {Map<String, dynamic>? headers,
      Map<String, dynamic>? queryParameters,
      required Function(Response response) onSuccess,
      Function(ApiException)? onError,
      Function(int total, int progress)? onSendProgress, // while sending (uploading) progress
      Function(int total, int progress)? onReceiveProgress, // while receiving data(response)
      Function? onLoading,
      dynamic data}) async {
    try {
      // 1) indicate loading state
      onLoading?.call();
      // 2) try to perform http request
      var response = await dio.post(
        url,
        data: data,
        onReceiveProgress: onReceiveProgress,
        onSendProgress: onSendProgress,
        queryParameters: queryParameters,
      );
      // 3) return response (api done successfully)
      return await onSuccess.call(response);
    } on DioException catch (error) {
      // dio error (api reach the server but not performed successfully
      // no internet connection
      if (error.message?.toLowerCase().contains('socket') ?? false) {
        return onError?.call(ApiException(message: noInternetConnection, url: url)) ??
            _handleError(noInternetConnection);
      }

      // no response
      if (error.response == null) {
        var exception = ApiException(url: url, message: error.message ?? nullResponse);
        return onError?.call(exception) ?? handleApiError(exception);
      }

      // check if the error is 500 (server problem)
      if (error.response?.statusCode == 500) {
        var exception = ApiException(message: serverError, url: url, statusCode: 500);
        return onError?.call(exception) ?? handleApiError(exception);
      }

      var exception =
          ApiException(message: error.message ?? nullResponse, url: url, statusCode: error.response?.statusCode ?? 404);
      return onError?.call(exception) ?? handleApiError(exception);
    } on SocketException {
      // No internet connection
      return onError?.call(ApiException(message: noInternetConnection, url: url)) ?? _handleError(noInternetConnection);
    } on TimeoutException {
      // Api call went out of time
      return onError?.call(ApiException(message: serverNotResponding, url: url)) ?? _handleError(serverNotResponding);
    } catch (error) {
      // unexpected error for example (parsing json error)
      return onError?.call(ApiException(message: error.toString(), url: url)) ?? _handleError(error.toString());
    }
  }

  // PUT request
  Future<dynamic> put(String url,
      {Map<String, dynamic>? headers,
      Map<String, dynamic>? queryParameters,
      required Function(Response response) onSuccess,
      Function(ApiException)? onError,
      Function(int total, int progress)? onSendProgress, // while sending (uploading) progress
      Function(int total, int progress)? onReceiveProgress, // while receiving data(response)
      Function? onLoading,
      dynamic data}) async {
    try {
      // 1) indicate loading state
      onLoading?.call();
      // 2) try to perform http request
      var response = await dio.put(
        url,
        data: data,
        onReceiveProgress: onReceiveProgress,
        onSendProgress: onSendProgress,
        queryParameters: queryParameters,
      );
      // 3) return response (api done successfully)
      return await onSuccess.call(response);
    } on DioException catch (error) {
      // dio error (api reach the server but not performed successfully
      // no internet connection
      if (error.message?.toLowerCase().contains('socket') ?? false) {
        onError?.call(ApiException(message: noInternetConnection, url: url)) ?? _handleError(noInternetConnection);
      }

      // no response
      if (error.response == null) {
        var exception = ApiException(url: url, message: error.message ?? nullResponse);
        return onError?.call(exception) ?? handleApiError(exception);
      }

      // check if the error is 500 (server problem)
      if (error.response?.statusCode == 500) {
        var exception = ApiException(message: serverError, url: url, statusCode: 500);
        return onError?.call(exception) ?? handleApiError(exception);
      }

      var exception =
          ApiException(message: error.message ?? nullResponse, url: url, statusCode: error.response?.statusCode ?? 404);
      return onError?.call(exception) ?? handleApiError(exception);
    } on SocketException {
      // No internet connection
      onError?.call(ApiException(message: noInternetConnection, url: url)) ?? _handleError(noInternetConnection);
    } on TimeoutException {
      // Api call went out of time
      onError?.call(ApiException(message: serverNotResponding, url: url)) ?? _handleError(serverNotResponding);
    } catch (error) {
      // unexpected error for example (parsing json error)
      onError?.call(ApiException(message: error.toString(), url: url)) ?? _handleError(error.toString());
    }
  }

  // DELETE request
  Future<dynamic> delete(String url,
      {Map<String, dynamic>? headers,
      Map<String, dynamic>? queryParameters,
      required Function(Response response) onSuccess,
      Function(ApiException)? onError,
      Function? onLoading,
      dynamic data}) async {
    try {
      // 1) indicate loading state
      onLoading?.call();
      // 2) try to perform http request
      var response = await dio.delete(
        url,
        data: data,
        queryParameters: queryParameters,
      );
      // 3) return response (api done successfully)
      await onSuccess.call(response);
    } on DioException catch (error) {
      // dio error (api reach the server but not performed successfully
      // no internet connection
      if (error.message?.toLowerCase().contains('socket') ?? false) {
        onError?.call(ApiException(message: noInternetConnection, url: url)) ?? _handleError(noInternetConnection);
      }

      // no response
      if (error.response == null) {
        var exception = ApiException(url: url, message: error.message ?? nullResponse);
        return onError?.call(exception) ?? handleApiError(exception);
      }

      // check if the error is 500 (server problem)
      if (error.response?.statusCode == 500) {
        var exception = ApiException(message: serverError, url: url, statusCode: 500);
        return onError?.call(exception) ?? handleApiError(exception);
      }

      var exception =
          ApiException(message: error.message ?? nullResponse, url: url, statusCode: error.response?.statusCode ?? 404);
      return onError?.call(exception) ?? handleApiError(exception);
    } on SocketException {
      // No internet connection
      onError?.call(ApiException(message: noInternetConnection, url: url)) ?? _handleError(noInternetConnection);
    } on TimeoutException {
      // Api call went out of time
      onError?.call(ApiException(message: serverNotResponding, url: url)) ?? _handleError(serverNotResponding);
    } catch (error) {
      // unexpected error for example (parsing json error)
      onError?.call(ApiException(message: error.toString(), url: url)) ?? _handleError(error.toString());
    }
  }

  /// handle error automatically (if user didn't pass onError) method
  /// it will try to show the message from api if there is no message
  /// from api it will show the reason
  handleApiError(ApiException apiException) {
    String msg = apiException.response?.data?['message'] ?? apiException.message;
    debugPrint('api error is =>$msg');
  }

  /// handle errors without response (500, out of time, no internet,..etc)
  _handleError(String msg) {
    debugPrint('Api error: $msg');
    // CustomSnackBar.showCustomErrorToast(message: msg);
  }
}
