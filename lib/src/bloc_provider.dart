import 'package:flutter/material.dart';

class BlocProvider<T> extends InheritedWidget {
  final T bloc;
  final Widget child;

  BlocProvider({Key key, @required this.bloc, @required this.child})
      : super(key: key);

  static T of<T>(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<BlocProvider<T>>().bloc;
  }

  @override
  bool updateShouldNotify(BlocProvider oldWidget) {
    return bloc != oldWidget.bloc;
  }
}
