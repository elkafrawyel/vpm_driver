import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../../app/config/environment.dart';
import '../../../app/util/network_helper.dart';
import '../../../app/util/operation_reply.dart';
import '../../../app/util/util.dart';
import '../storage/local_provider.dart';

enum DioMethods { get, post, patch, put, delete }

class APIProvider {
  static const _requestTimeOut = Duration(seconds: 30);

  /// private constructor
  APIProvider._();

  /// the one and only instance of this singleton
  static final instance = APIProvider._();

  final Dio _client = Dio(
    BaseOptions(
      baseUrl: Environment.url(),
      headers: {
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.cacheControlHeader: 'no-Cache',
        HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
        HttpHeaders.authorizationHeader: 'Bearer ${LocalProvider().getUser()?.token ?? 'No Token Found'}',
        HttpHeaders.acceptLanguageHeader: LocalProvider().getAppLanguage()
      },
      followRedirects: false,
      validateStatus: (status) => status! <= 500,
      connectTimeout: _requestTimeOut,
      receiveTimeout: _requestTimeOut,
    ),
  )..interceptors.add(
      PrettyDioLogger(
        request: true,
        requestBody: true,
        requestHeader: true,
        error: true,
        maxWidth: 1000,
      ),
    );

  void updateAcceptedLanguageHeader(String language) {
    _client.options.headers[HttpHeaders.acceptLanguageHeader] = language;
  }

  void updateTokenHeader(String? token, {String? tokenType}) {
    if (token == null) {
      _client.options.headers.remove(HttpHeaders.authorizationHeader);
      return;
    }
    _client.options.headers[HttpHeaders.authorizationHeader] =
        '${tokenType ?? 'Bearer'} $token';
  }

  Future<OperationReply<T>> get<T>({
    required String endPoint,
    required T Function(dynamic) fromJson,
  }) async {
    if (await NetworkHelper.isConnected()) {
      try {
        Response response = await _client.get(endPoint);
        if (NetworkHelper.isSuccess(response)) {
          return OperationReply.success(result: fromJson(response.data));
        } else {
          return NetworkHelper.handleCommonNetworkCases(response).as<T>();
        }
      } catch (error) {
        return OperationReply.failed(message: error.toString());
      }
    } else {
      return OperationReply.connectionDown();
    }
  }

  Future<OperationReply<T>> post<T>({
    required String endPoint,
    required T Function(dynamic) fromJson,
    required Map<String, dynamic> requestBody,
    List<MapEntry<String, File>> files = const [],
    Function(double percentage)? onUploadProgress,
    Function(double percentage)? onDownloadProgress,
  }) async {
    if (await NetworkHelper.isConnected()) {
      try {
        bool haveFiles = false;
        FormData formData = FormData.fromMap({});
        if (files.isNotEmpty) {
          haveFiles = true;
          formData = FormData.fromMap(requestBody);
          formData.files.addAll(files
              .map(
                (e) => MapEntry(
                  e.key,
                  MultipartFile.fromFileSync(e.value.path,
                      filename: e.value.path.split("/").last),
                ),
              )
              .toList());
        }
        Response response = await _client.post(
          endPoint,
          data: haveFiles ? formData : requestBody,
          onReceiveProgress: (received, total) {
            int percentage = ((received / total) * 100).floor();

            if (onDownloadProgress != null) {
              onDownloadProgress((received / total));
            }
            Utils.logMessage('Downloading ....$percentage');
          },
          onSendProgress: (sent, total) {
            int percentage = ((sent / total) * 100).floor();
            if (onUploadProgress != null) {
              onUploadProgress((sent / total));
            }
            Utils.logMessage('Uploading ....$percentage');
          },
        );
        if (NetworkHelper.isSuccess(response)) {
          return OperationReply.success(result: fromJson(response.data));
        } else {
          return NetworkHelper.handleCommonNetworkCases(response).as<T>();
        }
      } catch (error) {
        return OperationReply.failed(message: error.toString());
      }
    } else {
      return OperationReply.connectionDown();
    }
  }

  Future<OperationReply<T>> put<T>({
    required String endPoint,
    required T Function(dynamic) fromJson,
    required Map<String, dynamic> requestBody,
    List<MapEntry<String, File>> files = const [],
  }) async {
    if (await NetworkHelper.isConnected()) {
      try {
        bool haveFiles = false;
        FormData formData = FormData.fromMap({});
        if (files.isNotEmpty) {
          haveFiles = true;
          formData = FormData.fromMap(requestBody);
          formData.files.addAll(files
              .map(
                (e) => MapEntry(
                  e.key,
                  MultipartFile.fromFileSync(e.value.path,
                      filename: e.value.path.split("/").last),
                ),
              )
              .toList());
        }
        Response response = await _client.put(
          endPoint,
          data: haveFiles ? formData : requestBody,
          onReceiveProgress: (received, total) {
            int percentage = ((received / total) * 100).floor();
            Utils.logMessage('Downloading ....$percentage');
          },
          onSendProgress: (sent, total) {
            int percentage = ((sent / total) * 100).floor();
            Utils.logMessage('Uploading ....$percentage');
          },
        );
        if (NetworkHelper.isSuccess(response)) {
          return OperationReply.success(result: fromJson(response.data));
        } else {
          return NetworkHelper.handleCommonNetworkCases(response).as<T>();
        }
      } catch (error) {
        return OperationReply.failed(message: error.toString());
      }
    } else {
      return OperationReply.connectionDown();
    }
  }

  Future<OperationReply<T>> delete<T>({
    required String endPoint,
    required T Function(dynamic) fromJson,
    required Map<String, dynamic> requestBody,
    List<MapEntry<String, File>> files = const [],
  }) async {
    if (await NetworkHelper.isConnected()) {
      try {
        Response response = await _client.delete(endPoint, data: requestBody);
        if (NetworkHelper.isSuccess(response)) {
          return OperationReply.success(result: fromJson(response.data));
        } else {
          return NetworkHelper.handleCommonNetworkCases(response).as<T>();
        }
      } catch (error) {
        return OperationReply.failed(message: error.toString());
      }
    } else {
      return OperationReply.connectionDown();
    }
  }

  Future<OperationReply<T>> patch<T>({
    required String endPoint,
    required T Function(dynamic) fromJson,
    required Map<String, dynamic> requestBody,
    List<MapEntry<String, File>> files = const [],
  }) async {
    if (await NetworkHelper.isConnected()) {
      try {
        Response response = await _client.patch(endPoint, data: requestBody);
        if (NetworkHelper.isSuccess(response)) {
          return OperationReply.success(result: fromJson(response.data));
        } else {
          return NetworkHelper.handleCommonNetworkCases(response).as<T>();
        }
      } catch (error) {
        return OperationReply.failed(message: error.toString());
      }
    } else {
      return OperationReply.connectionDown();
    }
  }
}
