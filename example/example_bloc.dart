import 'dart:async';

import 'package:flutter/material.dart';

import 'package:bloc_provider/bloc_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: MyBloc(),
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
    final myBloc = BlocProvider.of<MyBloc>(context);
    return Scaffold(
      appBar: AppBar(),
      body: Container(
          child: StreamBuilder(
        stream: myBloc.getData,
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

class MyBloc extends Bloc {
  final _streamController = StreamController<String>();
  void setData(String data) => _streamController.sink.add(data);
  Stream<String> get getData => _streamController.stream;

  @override
  void dispose() {
    _streamController?.close();
  }
}
