import 'package:flutter/material.dart';

import 'package:bloc_provider/bloc_provider.dart';

// STATEFULWIDGET

class MultiBlocProvider extends StatefulWidget {
  final List<Bloc> blocs;
  final Widget child;

  MultiBlocProvider({Key key, @required this.blocs, @required this.child})
      : super(key: key);

  static T of<T extends Bloc>(BuildContext context) =>
      _MultiBlocProvider.of(context);

  @override
  State<StatefulWidget> createState() => _MultiBlocProviderState<Bloc>();
}

// STATE

class _MultiBlocProviderState<T extends Bloc> extends State<MultiBlocProvider> {
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

  _MultiBlocProvider({@required this.blocs, @required this.child})
      : super(child: child);

  static T of<T extends Bloc>(BuildContext context) {
    final bloc = context
        .dependOnInheritedWidgetOfExactType<_MultiBlocProvider<Bloc>>()
        ._getBloc<T>();
    if (bloc == null) throw FlutterError('Unable to find BLoC of type $T');
    return bloc;
  }

  Bloc _getBloc<T extends Bloc>() {
    return this.blocs.singleWhere((type) => (type is T), orElse: () => null);
  }

  @override
  bool updateShouldNotify(_MultiBlocProvider oldWidget) {
    return this.blocs != oldWidget.blocs;
  }
}
