# Bloc Provider

**Autor:** Frank Montalvo Ochoa

## Example of BlocProvider

```dart
void main() => runApp(MyApp());

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
```

## Example of MultiBlocProvider

```dart
void main() => runApp(MyApp());

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
```