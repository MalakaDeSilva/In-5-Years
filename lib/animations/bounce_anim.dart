import 'package:flutter/cupertino.dart';

// Code is referenced from https://www.youtube.com/watch?v=6vPF2IqCJ9Q&t=27s
class BouncePageRoute extends PageRouteBuilder {
  final Widget widget;

  BouncePageRoute({this.widget})
      : super(
            transitionDuration: Duration(seconds: 1),
            transitionsBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secAnimation,
                Widget child) {
              animation = CurvedAnimation(
                  parent: animation, curve: Curves.elasticInOut);

              return ScaleTransition(
                alignment: Alignment.center,
                scale: animation,
                child: child,
              );
            },
            pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secAnimation) {
              return widget;
            });
}
