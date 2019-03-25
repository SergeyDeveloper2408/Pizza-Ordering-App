import 'package:flutter/material.dart';

void main() => runApp(new Preview());

class Preview extends StatefulWidget {

  final String kindOfPizza;

  Preview({Key key, @required this.kindOfPizza}) : super(key: key);

  @override
  _PreviewState createState() => new _PreviewState(kindOfPizza);
}

class _PreviewState extends State<Preview> {

  final String kindOfPizza;

  _PreviewState(this.kindOfPizza);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Color(0xFF205d9c),
      appBar: new AppBar(
        backgroundColor: Color(0xFF205d9c),
        title: new Text(kindOfPizza),
      ),
      body: new Container(
        child: new Column(
          children: <Widget>[
            new Center(
              child: new Image.asset(
                "images/pizza_examples/newyork_style_pizza_example.jpg",
                width: 250.0,
                height: 250.0,
              )
            ),
          ],
        ),
      ),

    );
  }
}