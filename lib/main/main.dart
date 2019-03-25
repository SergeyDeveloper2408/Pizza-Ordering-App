import 'package:flutter/material.dart';
import 'package:pizza_ordering_app/navigation/navigation.dart';


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
      backgroundColor: Colors.deepOrange[300],
      body: new Container(
        margin: const EdgeInsets.only(top: 32.0),
        child: new Center(
          child: new Column(
            children: <Widget>[
              new Image.asset(
                "images/logo/logo.png",
                width: 200.0,
                height: 200.0,
                fit: BoxFit.cover,
              ),
              new Text(
                "Pizza Ordering Demo Home Page",
              ),
              new Container(
                  margin: const EdgeInsets.only(top: 200.0),
                  child: new ButtonTheme(
                      minWidth: 200.0,
                      height: 50.0,
                      buttonColor: Colors.deepOrange[400],
                      child: new RaisedButton(
                          child: new Text("Choose"),
                          onPressed: (){
                            Navigator.of(context).pushNamed("/PizzaList");
                          }
                      )
                  )
              ),
            ],
          ),
        ),
      )
    );
  }
}