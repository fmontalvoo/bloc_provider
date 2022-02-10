import 'package:flutter/material.dart';

import 'package:bloc_provider/src/bloc.dart';

// STATEFULWIDGET

class BlocProvider<T extends Bloc> extends StatefulWidget {
  final T bloc;
  final Widget child;

  const BlocProvider({
    Key? key,
    required this.bloc,
    required this.child,
  }) : super(key: key);

  static T of<T extends Bloc>(BuildContext context) =>
      _BlocProvider.of(context);

  @override
  State<StatefulWidget> createState() => _BlocProviderState<T>();
}

// STATE

class _BlocProviderState<T extends Bloc> extends State<BlocProvider<T>> {
  @override
  Widget build(BuildContext context) {
    return _BlocProvider(
      bloc: widget.bloc,
      newChild: widget.child,
    );
  }

  @override
  void dispose() {
    widget.bloc.dispose();
    super.dispose();
  }
}

// INHERITEDWIDGET

class _BlocProvider<T extends Bloc> extends InheritedWidget {
  const _BlocProvider({required this.bloc, required this.newChild})
      : super(child: newChild);

  final T bloc;
  final Widget newChild;

  static T of<T extends Bloc>(BuildContext context) {
    final bloc = context.dependOnInheritedWidgetOfExactType<_BlocProvider<T>>();
    if (bloc == null) throw FlutterError('Unable to find BLoC of type $T.');
    return bloc.bloc;
  }

  @override
  bool updateShouldNotify(_BlocProvider oldWidget) {
    return bloc != oldWidget.bloc;
  }
}
