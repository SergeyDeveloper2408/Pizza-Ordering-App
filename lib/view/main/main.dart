import 'package:flutter/material.dart';
import 'package:pizza_ordering_app/view/navigation/navigation.dart';

void main() => runApp(new PizzaOrderingApp());

class PizzaOrderingApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Pizza Ordering",
      home: new MyHomePage(
          title: "Pizza Ordering Demo Home Page"
      ),
      routes: Navigation.routes,
      theme: ThemeData(fontFamily: 'Handlee-Regular'),
    );
  }

}

class MyHomePage extends StatefulWidget {

  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Color(0xFFF15E61),
        body: new Container(
        margin: const EdgeInsets.only(top: 32.0),
        child: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text(
                "The best pizza",
                style: new TextStyle(color: Colors.white, fontSize: 26.0, fontFamily: 'Kalam-Regular')
              ),
              new Image.asset(
                "images/logo/logo.gif",
                width: 250.0,
                height: 250.0,
                fit: BoxFit.cover,
              ),
              new Text(
                "Loading...",
                style: new TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      )
    );
  }

  @override
  void initState() {
    super.initState();
    new Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacementNamed("/PizzaList");
    });
  }

}