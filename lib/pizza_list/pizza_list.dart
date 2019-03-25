import 'package:flutter/material.dart';
import 'package:pizza_ordering_app/utils/util.dart';
import 'package:pizza_ordering_app/preview/preview.dart';

void main() => runApp(new PizzaList());

class PizzaList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new PizzaListScreen();
  }
}

class PizzaListScreen extends StatefulWidget {

  @override
  _PizzaListScreenState createState() => new _PizzaListScreenState();

}

class _PizzaListScreenState extends State<PizzaListScreen> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.deepOrange[300],
        title: new Text("Choose your pizza"),
      ),
      body: new Container(
        child: Column(
          children: <Widget>[
            new Expanded(
                child: _buildItemsList()
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.shopping_cart),
        onPressed: (){},
      ),
    );
  }

  Widget _buildItemsList() {
    var size = MediaQuery.of(context).size;
    final int itemHeight = ((size.height - kToolbarHeight + 65) / 3).round();
    final int itemWidth = (size.width / 2).round();

    Widget itemCards;

    Map<String, String> pizzaExamples = Util.pizzaExamplesPaths;

    if (pizzaExamples.length > 0) {
      itemCards =  new GridView.count(
        childAspectRatio: (itemWidth / itemHeight),
        scrollDirection: Axis.vertical,
        crossAxisCount: 2,
        children: new List.generate(pizzaExamples.length, (index){
          return new GestureDetector(
              child: new Container(
                padding: const EdgeInsets.only(top: 0.5, bottom: 0.5, left: 1.0, right: 1.0),
                child: new Column(
                  children: <Widget>[
                    new Image.asset(
                      pizzaExamples.values.elementAt(index),
                    ),
                  ],
                ),
            ),
            onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => new Preview(kindOfPizza: pizzaExamples.keys.elementAt(index)),
                    ));
            },
          );
        }),
      );
    } else {
      itemCards = new Container(
        child: new Text('No items'),
      );
    }
    return itemCards;
  }

//    var size = MediaQuery.of(context).size;
//    final int itemHeight = ((size.height - kToolbarHeight + 5) / 2).round();
//    final int itemWidth = (size.width / 2).round();

}