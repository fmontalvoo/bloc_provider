import 'dart:async';

import 'package:flutter/material.dart';

import 'package:bloc_provider/bloc_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      blocs: [BlocA(), BlocB(), BlocC()],
      child: MaterialApp(
        title: 'Flutter Demo',
        home: HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final blocA = MultiBlocProvider.of<BlocA>(context);
    final blocB = MultiBlocProvider.of<BlocB>(context);
    final blocC = MultiBlocProvider.of<BlocC>(context);
    return Scaffold(
      appBar: AppBar(),
      body: Container(
          child: StreamBuilder(
        stream: blocB.getDataB,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Center(child: Text(snapshot.data));
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return CircularProgressIndicator();
        },
      )),
    );
  }
}

class BlocA extends Bloc {
  final _streamController = StreamController<String>();
  void setDataA(String data) => _streamController.sink.add(data);
  Stream<String> get getDataA => _streamController.stream;

  @override
  void dispose() {
    _streamController?.close();
  }
}

class BlocB extends Bloc {
  final _streamController = StreamController<String>();
  void setDataB(String data) => _streamController.sink.add(data);
  Stream<String> get getDataB => _streamController.stream;

  @override
  void dispose() {
    _streamController?.close();
  }
}

class BlocC extends Bloc {
  final _streamController = StreamController<String>();
  void setDataC(String data) => _streamController.sink.add(data);
  Stream<String> get getDataC => _streamController.stream;

  @override
  void dispose() {
    _streamController?.close();
  }
}
