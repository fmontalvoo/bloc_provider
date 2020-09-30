import 'package:flutter/material.dart';

import 'package:bloc_provider/bloc_provider.dart';

// STATEFULWIDGET

class MultiBlocProvider<T extends Bloc> extends StatefulWidget {
  final List<T> blocs;
  final Widget child;

  MultiBlocProvider({Key key, @required this.blocs, @required this.child})
      : super(key: key);

  static T of<T extends Bloc>(BuildContext context) =>
      _MultiBlocProvider.of(context);

  @override
  State<StatefulWidget> createState() => _MultiBlocProviderState<T>();
}

// STATE

class _MultiBlocProviderState<T extends Bloc>
    extends State<MultiBlocProvider<T>> {
  @override
  Widget build(BuildContext context) {
    return _MultiBlocProvider(
      blocs: widget.blocs,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    widget.blocs.forEach((bloc) => bloc.dispose());
    super.dispose();
  }
}

// INHERITEDWIDGET

class _MultiBlocProvider<T extends Bloc> extends InheritedWidget {
  final List<T> blocs;
  final Widget child;

  _MultiBlocProvider({Key key, @required this.blocs, @required this.child})
      : super(key: key);

  static T of<T extends Bloc>(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<_MultiBlocProvider<Bloc>>()
        .getBloc<T>();
  }

  Bloc getBloc<T extends Bloc>() {
    final bloc = blocs.singleWhere((type) => (type is T), orElse: null);
    if (bloc == null) throw FlutterError('Unable to find BLoC of type $T.');
    return bloc;
  }

  @override
  bool updateShouldNotify(_MultiBlocProvider oldWidget) {
    return blocs != oldWidget.blocs;
  }
}
