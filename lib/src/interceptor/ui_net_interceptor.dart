import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_interceptor/src/model/http_transaction.dart';
import 'dart:convert' as convert;

import 'package:flutter_interceptor/src/tools/interceptor_manager.dart';

class UiNetInterceptor extends Interceptor {


  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    InterceptorManager.instance.onRequestTime(options.hashCode, DateTime.now());
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    InterceptorManager.instance.onResponseTime(response.requestOptions.hashCode, DateTime.now());
    InterceptorManager.instance.onSave(setData(response, response.requestOptions));
    handler.next(response);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {

    if (err.response != null) {
      InterceptorManager.instance.onResponseTime(err.response!.requestOptions.hashCode, DateTime.now());
      InterceptorManager.instance.onSave(setData(err.response!, err.response!.requestOptions)..error = true);
    }else{
      InterceptorManager.instance.onSave(HttpTransaction()
        ..id = err.requestOptions.hashCode
        ..requestTime = InterceptorManager.instance.requestTime[err.requestOptions.hashCode]
        ..responseTime = InterceptorManager.instance.responseTime[err.requestOptions.hashCode]
        ..uri = err.requestOptions.uri
        ..error = true);
    }
    handler.next(err);
  }

  HttpTransaction setData(Response response,RequestOptions options){
    return HttpTransaction()
      ..id = options.hashCode
      ..uri = options.uri
      ..statusCode = response.statusCode
      ..method = options.method
      ..responseType = options.responseType.toString()
      ..followRedirects = options.followRedirects
      ..connectTimeout = options.connectTimeout
      ..sendTimeout = options.sendTimeout
      ..receiveTimeout = options.receiveTimeout
      ..receiveDataWhenStatusError = options.receiveDataWhenStatusError
      // ..extra = convert.jsonEncode(options.extra)
      ..extra = options.extra
      ..requestBody =  stringifyMessage(options.data)
      // ..requestHeaders = convert.jsonEncode(options.headers)
      ..requestHeaders = options.headers
      ..redirect = response.isRedirect
      ..realUri = response.realUri
      // ..responseHeaders = convert.jsonEncode(response.headers)
      ..responseHeaders = response.headers.map
      ..responseBody = response.toString()
      ..requestTime = InterceptorManager.instance.requestTime[options.hashCode]
      ..responseTime = InterceptorManager.instance.responseTime[options.hashCode]
      ..duration = InterceptorManager.instance.responseTime[options.hashCode]!.millisecondsSinceEpoch-InterceptorManager.instance.requestTime[options.hashCode]!.millisecondsSinceEpoch;
  }

  String stringifyMessage(dynamic message) {
    final finalMessage = message is Function ? message() : message;
    if (finalMessage is Map || finalMessage is Iterable) {
      return convert.jsonEncode(finalMessage);
    } else {
      return finalMessage.toString();
    }
  }
}