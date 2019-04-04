import 'package:flutter/material.dart';
import 'package:pizza_ordering_app/data/cart.dart';
import 'package:pizza_ordering_app/data/cart_item.dart';

class CartPreview extends StatefulWidget {

  @override
  _CartPreviewState createState() => new _CartPreviewState();
}

class _CartPreviewState extends State<CartPreview> {

  List<CartItem> itemsList = new Cart().items;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white30,
      appBar: new AppBar(
        backgroundColor: Colors.white30,
        title: new Text("Cart"),
      ),
      body: createBody(),
    );
  }

  Widget createBody(){
    Widget list;
    if(itemsList.length > 0){
      list = new Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            new Container(
                child: new ListView.builder(
                    itemCount: itemsList.length,
                    itemBuilder: (BuildContext context, int index)
                      => createCartItemRow(index)
                ),
                color: Colors.grey,
                height: 450.0
            ),
            new Container(
              margin: const EdgeInsets.only(top: 6.0),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  new Container(
                    child: new Text(
                        'Total cost: ${new Cart().getTotalCost()} \$',
                        style: new TextStyle(color: Colors.white)
                    ),
                  ),
                  new Container(
                    child: new ButtonTheme(
                        minWidth: 100.0,
                        buttonColor: Colors.white,
                        child: new RaisedButton(
                            child: new Text("Make an order"),
                            onPressed: (){
                              Navigator.of(context).pushNamed("/OrderPreview");
                            }
                        )
                    ),
                  )
                ],
              ),
            )
          ]
      );
    } else {
      list = new Center(
          child: new Text('No items', style: new TextStyle(color: Colors.white))
      );
    }
    return list;
  }

  Widget createCartItemRow(int index){
    return new Card(
        child: new Container(
          color: new Color(itemsList.elementAt(index).pizza.backgroundColor),
          padding: const EdgeInsets.all(5.0),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              createPizzaImagePreview(index),
              createCounterField(index),
              createPriceAndWeightInfo(index),
              createRemoveImage(index)
            ],
          ),
        )
    );
  }

  Widget createPriceAndWeightInfo(int index){
    return new Container(
      child: new Column(
        children: <Widget>[
          new Text(
              "${new Cart().items.elementAt(index).totalCost} \$",
              style: new TextStyle(color: Colors.white, fontSize: 15.0)
          ),
          new Text(
              "${new Cart().items.elementAt(index).pizzaSize.description}",
              style: new TextStyle(color: Colors.white, fontSize: 10.0)
          )
        ],
      ),
    );
  }

  Widget createPizzaImagePreview(int index){
    return new Container(
        child: new Image.asset(
            new Cart().items.elementAt(index).pizza.imagePath,
            width: 100.0, height: 100.0
        )
    );
  }

  void removeItem(int index){
    setState(() {
      new Cart().items.removeAt(index);
    });
  }

  Widget createRemoveImage(int index){
    return new IconButton(
          icon: new Icon(Icons.delete),
          color: Colors.white,
          highlightColor: Colors.white,
          onPressed: (){
            removeItem(index);
          }
    );
  }

  Widget createCounterField(int index){
    return new Container(
        child: new Row(
          children: <Widget>[
            createRoundButton(index, false),
            new Text(
                itemsList.elementAt(index).count.toString(),
                style: new TextStyle(color: Colors.white, fontSize: 15.0)
            ),
            createRoundButton(index, true)
          ],
        )
    );
  }

  Widget createRoundButton(int index, bool isPositiveButton){
    return new Container(
      width: 20.0,
      height: 20.0,
      margin: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: new RawMaterialButton(
        onPressed: () {
          setState(() {
            if (isPositiveButton) {
              ++itemsList.elementAt(index).count;
            } else if (itemsList.elementAt(index).count > 1) {
              --itemsList.elementAt(index).count;
            }
          });
        },
        child: new Text(isPositiveButton ? "+" : "-", style: new TextStyle(color: Colors.black, fontSize: 12.0)),
        shape: new CircleBorder(),
        elevation: 2.0,
        fillColor: Colors.white,
      ),
    );
  }
}