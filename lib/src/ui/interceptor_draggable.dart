
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'simple_interceptor.dart';

class InterceptorDraggable extends StatefulWidget{
  @override
  State<StatefulWidget> createState() =>_InterceptorDraggableState();
}

class _InterceptorDraggableState extends State<InterceptorDraggable>{
  double left = 100;
  double top = 100;
  double btnSize = 50;
  late double screenWidth;
  late double screenHeight;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    ///计算偏移量限制
    if (left < 1) {
      left = 1;
    }
    if (left > screenWidth - btnSize) {
      left = screenWidth - btnSize;
    }

    if (top < 1) {
      top = 1;
    }
    if (top > screenHeight - btnSize) {
      top = screenHeight - btnSize;
    }
    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => SimpleInterceptor(),
          ),
        );
      },
      onPanUpdate: _dragUpdate,
      child:Container(
        alignment: Alignment.topLeft,
        margin: EdgeInsets.only(left: left, top: top),
        child: SizedBox(
          width: btnSize,
          height: btnSize,
          child: CircleAvatar(
            backgroundColor: Color(0x5f6495ed),
            child: Text(
              "Http",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _dragUpdate(DragUpdateDetails detail) {
    Offset offset = detail.delta;
    left = left + offset.dx;
    top = top + offset.dy;
    setState(() {

    });
  }
}