
import 'package:flutter/material.dart';
import 'package:flutter_interceptor/src/interceptor_localizations.dart';
import 'dart:convert' as convert;

import 'package:flutter_interceptor/src/model/http_transaction.dart';
import 'package:flutter_interceptor/src/tools/copy_clipboard.dart';
import 'package:flutter_interceptor/src/tools/json_utils.dart';

class InterceptorDetail extends StatefulWidget {

  final HttpTransaction httpTransaction;
  InterceptorDetail({required this.httpTransaction});

  @override
  State<StatefulWidget> createState() => _InterceptorDetailState();
}

class _InterceptorDetailState extends State<InterceptorDetail> {


  @override
  Widget build(BuildContext context) {
    var local = InterceptorLocalizations.getInterceptorString(context);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text("${widget.httpTransaction.method} ${widget.httpTransaction.path}"),
          elevation: 0,
          bottom: TabBar(
            unselectedLabelColor: Colors.black38,
            indicatorColor: Colors.white,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorWeight: 3.0,
            tabs: <Widget>[
              Text(local.summary!,style: TextStyle(fontSize: 15,color: Colors.white),),
              Text(local.request!,style: TextStyle(fontSize: 15,color: Colors.white),),
              Text(local.response!,style: TextStyle(fontSize: 15,color: Colors.white),),
            ],
          ),
          actions: [
            PopupMenuButton(
              icon: Icon(Icons.share),
              onSelected: (value) {
                if(value == 'text'){
                }else{
                }
              },
              itemBuilder: (context) => [
                PopupMenuItem(
                  child: TextButton(child: Text(local.copy!),onPressed: (){
                    copyClipboard(context,widget.httpTransaction.toString());
                  },),
                  value: 'text',

                ),
              ],
            )
          ],
        ),
        body: TabBarView(
          children: [
            ContentDetialPage(httpTransaction: widget.httpTransaction,page : DetailPage.Content),
            ContentDetialPage(httpTransaction: widget.httpTransaction,page : DetailPage.Request),
            ContentDetialPage(httpTransaction: widget.httpTransaction,page : DetailPage.Resopnse),
          ],
        ),
      ),
    );
  }
}

enum DetailPage {
  Request,
  Resopnse,
  Content
}

class ContentDetialPage extends StatefulWidget {
  final HttpTransaction httpTransaction;
  final DetailPage page;
  ContentDetialPage({required this.httpTransaction,required this.page});

  @override
  State<StatefulWidget> createState() => _ContentDetialPageState();
}

class _ContentDetialPageState extends State<ContentDetialPage> {
  @override
  Widget build(BuildContext context) {
    var local = InterceptorLocalizations.getInterceptorString(context);

    switch(widget.page){
      case DetailPage.Content:
        return SingleChildScrollView(
          child: Column(children: [
            Row(children: [Text("URL："),Expanded(child: Text("${widget.httpTransaction.muri.toString()}",textAlign: TextAlign.left,))],),
            Row(children: [Text("${local.method!}:"),Text("${widget.httpTransaction.method}")],),
            Row(children: [Text("${local.requestTime!}:"),Text("${widget.httpTransaction.requestTime}")],),
            Row(children: [Text("${local.responseTime!}:"),Text("${widget.httpTransaction.responseTime}")],),
            Row(children: [Text("${local.duration!}:"),Text("${widget.httpTransaction.duration}ms")],)],),
          );
      case DetailPage.Request:
        List<Widget> list = [];
        widget.httpTransaction.requestHeaders?.forEach((key, value) {
          list.add(Row(children: [Text("$key:"),Expanded(child:Text(convert.jsonEncode(value)))],crossAxisAlignment: CrossAxisAlignment.start,));
        });
        list.add(Padding(padding: EdgeInsets.only(top: 25),child: Text(widget.httpTransaction.requestBody??"")));
        return SingleChildScrollView(
          child: Column(children:
            list,),
        );
      case DetailPage.Resopnse:
        List<Widget> list = [];
        widget.httpTransaction.responseHeaders?.forEach((key, value) {
          list.add(Row(children: [Text("$key:"),Expanded(child:Text(convert.jsonEncode(value)))],crossAxisAlignment: CrossAxisAlignment.start,));
        });
        list.add(Padding(padding: EdgeInsets.only(top: 25),child: Text(json(widget.httpTransaction.responseBody)),));
        return SingleChildScrollView(
          child: Column(children:
          list,),
        );
    }
  }
}
