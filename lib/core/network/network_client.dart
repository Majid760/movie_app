import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:movie_app_assessment/core/network/network_config.dart';

class NetworkClient {
  Map<String, int> maxRetryURL = {};

  // Create a Dio client with configurations
  String token = NetworkConfigs.apiToken;
  Dio createDioClient() {
    final Dio dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
          'key': NetworkConfigs.apiKey,
          // Add API key or any other default headers if needed
        },
      ),
    );
    dio.options.baseUrl = NetworkConfigs.apiBaseUrl;
    dio.transformer = CustomBackgroundTransformer();
    // (dio.transformer as BackgroundTransformer).jsonDecodeCallback = parseJson;
    // dio.interceptors.clear();  //for bearer token in case of refresh token

    // Optionally, add interceptors for logging, authentication, etc.
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (requestOpts, handler) {
        debugPrint(
          '''
          **************************
          requestType: ${requestOpts.method},
          url: ${requestOpts.path.toString()}, 
          queryParams: ${requestOpts.queryParameters}
          data: ${requestOpts.data} 
          url: ${requestOpts.baseUrl}  
          ************************
          ''',
        );
        debugPrint('Request to: ${requestOpts.baseUrl}${requestOpts.path}');
        return handler.next(requestOpts); // Continue
      },
      onResponse: (response, handler) {
        debugPrint('Response: ${response.statusCode}');
        return handler.next(response); // Continue
      },
      onError: (DioException e, handler) async {
        debugPrint("error INTERCEPTOR: errCode: ${e.response?.statusCode} ${e.response?.data}");
        if (e.response?.statusCode == 400 ||
            e.response?.statusCode == 406 ||
            e.response?.statusCode == 401 ||
            e.response?.statusCode == 403) {
          debugPrint("error INTERCEPTOR: errCode: ${e.response?.statusCode} ${e.response?.data}");
          return handler.reject(e);
        }

        /// fetch URL without queryParams
        /// Reject if tried more than 2 times
        Uri originalUri = Uri.parse(e.requestOptions.path);
        if (maxRetryURL[originalUri.path] == null) {
          maxRetryURL[originalUri.path] = 1;
        } else if (maxRetryURL[originalUri.path]! < 2) {
          maxRetryURL[originalUri.path] = maxRetryURL[originalUri.path]! + 1;
          debugPrint("Retrying URL: ${originalUri.path} - ${maxRetryURL[originalUri.path]}");
        } else {
          if ((e.response?.statusCode ?? 501) >= 500) {
            /// [CRASHLYTICS] - Max Retries
            // CrashlyticsService.instance.recordError(e, stackTrace: StackTrace.current, reason: "Server 500 Status Code or null");
          }

          debugPrint("Max Retries: ${originalUri.path} - ${maxRetryURL[originalUri.path]}");

          /// [RETURNING] reject the request - no more retries
          return handler.reject(e);
        }

        /// INTERNET ISSUE check if the error is a retry-able error (timeout, cancel, etc)
        if (e.type == DioExceptionType.connectionTimeout ||
            e.type == DioExceptionType.receiveTimeout ||
            e.type == DioExceptionType.sendTimeout ||
            e.type == DioExceptionType.cancel) {
          debugPrint("INTERNET ISSUE");

          /// retry the request again
          return handler.resolve(await dio.fetch(e.requestOptions));
        }
        return handler.next(e);
      },
    ));

    return dio;
  }

  // Must be top-level function
  _parseAndDecode(String response) {
    return jsonDecode(response);
  }

  // get parse json
  parseJson(String text) {
    return compute(_parseAndDecode, text);
  }
}

class CustomBackgroundTransformer extends BackgroundTransformer {
  @override
  Future<dynamic> transformResponse(RequestOptions options, ResponseBody responseBody) async {
    // Decode JSON in the background using a custom parse function

    // Check if the content type is JSON by using the options object
    if (options.responseType == ResponseType.json || options.contentType?.contains('application/json') == true) {
      // Decode JSON in the background using a custom parse function
      return await parseJson(responseBody);
    } else {
      return super.transformResponse(options, responseBody);
    }
  }

  Future<dynamic> parseJson(ResponseBody response) async {
    // Collect the response stream into a list of bytes, then decode it into a string
    final List<int> bytes = await response.stream.toList().then((list) => list.expand((x) => x).toList());
    final String jsonString = utf8.decode(bytes);

    // Parse the JSON string
    return jsonDecode(jsonString);
  }
}
