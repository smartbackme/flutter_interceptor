
import 'dart:collection';

import 'package:flutter_interceptor/src/model/http_transaction.dart';


class InterceptorManager{
  ///请求日志存储
  late LinkedList<HttpTransaction> transactionList;

  late LinkedHashMap<int,DateTime> requestTime;
  late LinkedHashMap<int,DateTime> responseTime;

  ///存储请求最大数
  int maxCount = 50;

  InterceptorManager._(){
    transactionList = LinkedList();
    requestTime = LinkedHashMap();
    responseTime = LinkedHashMap();
  }

  ///The singleton for [InterceptorManager]
  static final InterceptorManager _instance = InterceptorManager._();

  static InterceptorManager get instance {
    return _instance;
  }

  void onSave(HttpTransaction httpTransaction) {
    if(transactionList.length>=maxCount){
      transactionList.remove(transactionList.first);
    }
    transactionList.add(httpTransaction);
  }

  void onResponseTime(int id,DateTime dateTime) {
    if(responseTime.length>=maxCount){
      responseTime.remove(responseTime.keys.first);
    }
    responseTime[id] = dateTime;
  }

  void onRequestTime(int id,DateTime dateTime) {
    if(requestTime.length>=maxCount){
      requestTime.remove(requestTime.keys.first);
    }
    requestTime[id] = dateTime;
  }

  ///日志清除
  void clear() {
    transactionList.clear();
    requestTime.clear();
    responseTime.clear();
  }
}