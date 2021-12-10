
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_interceptor/src/interceptor_localizations.dart';
import 'package:flutter_interceptor/src/model/http_transaction.dart';
import 'package:flutter_interceptor/src/tools/interceptor_manager.dart';
import 'package:flutter_interceptor/src/tools/time_utils.dart';

import 'interceptor_detail.dart';

class SimpleInterceptor extends StatefulWidget{
  @override
  State<StatefulWidget> createState() =>_SimpleInterceptorState();

}

class _SimpleInterceptorState extends State<SimpleInterceptor>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(InterceptorLocalizations.getInterceptorString(context).simpleInterception!),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            // tooltip: 'search',
            onPressed:() {
              InterceptorManager.instance.clear();
              setState(() {
              });
            },
          ),
        ],
      ),

      body: SafeArea(
        child: ListView(
          children: InterceptorManager.instance.transactionList.map((httpTransaction){
            return SimpleInterceptorCell(httpTransaction: httpTransaction);
          }).toList(),
        ),
      ),
    );
  }

}

class SimpleInterceptorCell extends StatelessWidget {
  final HttpTransaction httpTransaction;
  SimpleInterceptorCell({required this.httpTransaction}) ;

  Color statusGetColor(){
    if(httpTransaction.status == Status.Failed){
      return Color(0xffF44336);
    }
    if(httpTransaction.status == Status.Requested){
      return Color(0xff9E9E9E);
    }
    if(httpTransaction.statusCode! >= 500){
      return Color(0xffB71C1C);
    }
    if(httpTransaction.statusCode! >= 400){
      return Color(0xffFF9800);
    }
    if(httpTransaction.statusCode! >= 300){
      return Color(0xff0D47A1);
    }
    return Color(0xff212121);
  }

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: (){
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => InterceptorDetail(httpTransaction : httpTransaction)),
        );
      },
      child: Stack(
        children: [
          //内容布局
          Container(
            padding: EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(httpTransaction.statusCode.toString(),style: TextStyle(
                  fontSize: 17,
                  color: statusGetColor(),
                ),),
                SizedBox(width: 10,),
                Expanded(
                  child:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${httpTransaction.method} ${httpTransaction.path}",style: TextStyle(
                        fontSize: 17,
                        color: statusGetColor(),
                      ),textAlign: TextAlign.left,),
                      SizedBox(height: 10,),
                      Text(httpTransaction.host??"",style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey,
                      ),),
                      SizedBox(height: 10,),
                      Flex(
                        direction: Axis.horizontal,
                        children: [
                          Expanded(child:Text(getTimeStr1(httpTransaction.requestTime!),style: TextStyle(color: Colors.grey,fontSize: 13),),flex: 1,),
                          Expanded(child:Text("${httpTransaction.duration}ms",style: TextStyle(color: Colors.grey,fontSize: 13),),flex: 1,),
                        ],
                      ),
                      SizedBox(height: 10,),
                    ],
                  ),
                ),

              ],
            ),
          ),
          //线
          Positioned(
            child: Container(
              height: 1,
              color: Colors.grey,
            ),
            bottom: 1,
            left: 0,
            right: 0,
          ),
        ],
      ),
    );
  }
}
