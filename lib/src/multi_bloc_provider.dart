import 'package:flutter/material.dart';

import 'package:bloc_provider/bloc_provider.dart';

// STATEFULWIDGET

class MultiBlocProvider extends StatefulWidget {
  const MultiBlocProvider({
    Key? key,
    required this.blocs,
    required this.child,
  }) : super(key: key);

  final List<Bloc> blocs;
  final Widget child;

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
      newChild: widget.child,
    );
  }

  @override
  void dispose() {
    for (final bloc in widget.blocs) {
      bloc.dispose();
    }
    super.dispose();
  }
}

// INHERITEDWIDGET

class _MultiBlocProvider<T extends Bloc> extends InheritedWidget {
  const _MultiBlocProvider({
    required this.blocs,
    required this.newChild,
  }) : super(child: newChild);

  final List<T> blocs;
  final Widget newChild;

  static T of<T extends Bloc>(BuildContext context) {
    final bloc = context
        .dependOnInheritedWidgetOfExactType<_MultiBlocProvider<Bloc>>()!
        ._getBloc<T>();
    if (bloc == null) throw FlutterError('Unable to find BLoC of type $T');
    return bloc as T;
  }

  // ignore: avoid_shadowing_type_parameters
  Bloc? _getBloc<T extends Bloc>() {
    //ignore: return_of_invalid_type_from_closure
    return blocs.singleWhere((type) => (type is T), orElse: () => null);
  }

  @override
  bool updateShouldNotify(_MultiBlocProvider oldWidget) {
    return blocs != oldWidget.blocs;
  }
}
