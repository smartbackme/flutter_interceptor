import 'dart:collection';
import 'dart:core';

import 'dart:convert' as convert;

import 'package:flutter_interceptor/src/tools/json_utils.dart';


enum Status {
  Requested,
  Complete,
  Failed
}

class HttpTransaction extends LinkedListEntry<HttpTransaction>{
  String? host;
  String? path ;
  String? scheme;
  Uri? muri;
  int? id;
  DateTime? requestTime;
  DateTime? responseTime;
  int? duration;


  int? statusCode;
  bool? redirect;
  String? responseBody;
  Map<String, dynamic>? responseHeaders;
  Uri? realUri;

  bool error = false;

  String? method;
  bool? followRedirects;

  String? responseType;
  int? connectTimeout;
  int? sendTimeout;
  int? receiveTimeout;
  bool? receiveDataWhenStatusError;
  String? requestBody;
  Map<String, dynamic>? requestHeaders;
  Map<String, dynamic>? extra;

  Status get status{
    if(error){
      return Status.Failed;
    }else if(statusCode==null){
      return Status.Requested;
    }else {
      return Status.Complete;
    }
  }

  set uri(Uri uri){
    muri = uri;
    host = uri.host;
    path = uri.path+ (uri.hasQuery?"?${uri.query}":"");
    scheme = uri.scheme;
  }

  @override
  String toString() {
    return 'url:${muri.toString()}\nmethod:$method\nrequestTime:$requestTime\nresponseTime:$responseTime\n'
        'duration:${duration ?? 0}ms\n'
        'statusCode:$statusCode'
        '\nrequestHeaders:${convert.jsonEncode(requestHeaders)}\n$requestBody'
        '\nresponseHeaders:${convert.jsonEncode(responseHeaders)}\n${json(responseBody)}';
  }

  // Map<String, dynamic>? getRequestHeaders() {
  //   if(requestHeaders!=null){
  //     Map<String, dynamic> header = convert.jsonDecode(requestHeaders!);
  //     return header;
  //   }
  //   return null;
  // }
  //
  // Map<String, dynamic>? getResponseHeaders() {
  //   if(responseHeaders!=null){
  //     Map<String, dynamic> header = convert.jsonDecode(responseHeaders!);
  //     return header;
  //   }
  //   return null;
  // }
  //
  // Map<String, dynamic>? getExtra() {
  //   if(extra!=null){
  //     Map<String, dynamic> header = convert.jsonDecode(extra!);
  //     return header;
  //   }
  //   return null;
  // }

}