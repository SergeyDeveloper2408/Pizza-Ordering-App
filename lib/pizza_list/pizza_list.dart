import 'package:flutter/material.dart';
import 'package:pizza_ordering_app/utils/generate_pizza_util.dart';
import 'package:pizza_ordering_app/preview/preview.dart';
import 'package:pizza_ordering_app/data/pizza.dart';

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
      floatingActionButton: new FloatingActionButton(
        child: new Icon(Icons.shopping_cart),
        onPressed: (){},
      ),
    );
  }

  Widget _buildItemsList() {
    Widget itemCards;
    List<Pizza> pizzaList = GeneratePizzaUtil.getPizzaList();

    if (pizzaList.length > 0) {
      itemCards = new GridView.count(
        childAspectRatio: 0.96,
        scrollDirection: Axis.vertical,
        crossAxisCount: 2,
        children: new List.generate(pizzaList.length, (index){
          return new GestureDetector(
              child: new Container(
                padding: const EdgeInsets.only(
                    top: 0.5, bottom: 0.5,
                    left: 1.0, right: 1.0),
                child: new Column(
                  children: <Widget>[
                    new Image.asset(
                      pizzaList.elementAt(index).imagePath,
                    ),
                  ],
                ),
            ),
            onTap: (){
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                      builder: (context) => new Preview(
                          pizza: pizzaList.elementAt(index)),
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
}