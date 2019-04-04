import 'package:flutter/material.dart';
import 'package:pizza_ordering_app/data/pizza.dart';
import 'package:pizza_ordering_app/data/pizza_size.dart';
import 'package:pizza_ordering_app/utils/generate_pizza_util.dart';
import 'package:pizza_ordering_app/data/cart.dart';
import 'package:pizza_ordering_app/data/cart_item.dart';
import 'package:badges/badges.dart';

class Preview extends StatefulWidget {

  final Pizza pizza;

  Preview({Key key, @required this.pizza}) : super(key: key);

  @override
  _PreviewState createState() => new _PreviewState(pizza);
}

class _PreviewState extends State<Preview> {

  final Pizza pizza;
  final List<PizzaSize> _pizzaSizes = GeneratePizzaUtil.getPizzaSizes();
  PizzaSize _pizzaSize;

  double _pizzaPrice;
  String _pizzaWeight;

  _PreviewState(this.pizza);

  @override
  void initState() {
    super.initState();
    _setPriceAndWeight(_pizzaSizes.elementAt(2));
  }

  void _setPriceAndWeight(PizzaSize pizzaSize){
    setState(() {
      _pizzaSize = pizzaSize;
      _pizzaPrice = (pizza.cost * pizzaSize.price);
      _pizzaWeight = pizzaSize.weight;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: new Color(pizza.backgroundColor),
      appBar: new AppBar(
        backgroundColor: new Color(pizza.backgroundColor),
        title: new Text(pizza.name),
        actions: <Widget>[
          new Container(
            margin: const EdgeInsets.only(right: 10.0),
            child: new BadgeIconButton(
                itemCount: new Cart().items.length, // required
                icon: new Icon(Icons.shopping_cart), // required
                badgeColor: Colors.red, // default: Colors.red
                badgeTextColor: Colors.white, // default: Colors.white
                hideZeroCount: true, // default: true
                onPressed: (){
                  Navigator.of(context).pushNamed("/CartPreview");
                }),
          )
        ],
      ),
      body: new Container(
        child: new Column(
          children: <Widget>[
            createPreviewImage(),
            createDescriptionText(),
            createDropDownButton(),
            createPriceRow(),
            createOrderButton()
          ],
        ),
      ),
    );
  }

  Widget createPriceRow(){
    return new Container(
      height: 30.0,
      margin: const EdgeInsets.only(top: 30.0),
      padding: const EdgeInsets.only(left: 40.0, right: 40.0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          new Container(
            alignment: Alignment.bottomRight,
            child: new Text(
              "${_pizzaPrice.toString()} \$",
              style: new TextStyle(fontSize: 25.0, color: Colors.white),
            ),
          ),
          new Container(
            alignment: Alignment.bottomRight,
            margin: const EdgeInsets.only(left: 10.0),
            child: new Text(
              _pizzaWeight,
              style: new TextStyle(fontSize: 15.0, color: Colors.white),
            )
          )
        ],
      ),
    );
  }

  Widget createOrderButton(){
    return new Container(
        margin: const EdgeInsets.only(top: 30.0),
        child: new ButtonTheme(
            minWidth: 300.0,
            height: 50.0,
            buttonColor: Colors.white,
            child: new RaisedButton(
                child: new Text("Add to cart"),
                onPressed: (){

                  List<CartItem> cartItems = new Cart().items;
                  CartItem cartItem = new CartItem(
                      pizza: pizza,
                      count: 1,
                      pizzaSize: _pizzaSize
                  );

                  if (cartItems.isEmpty){
                    cartItems.add(cartItem);
                  } else {
                    if(cartItems.contains(cartItem)){
                      ++cartItems.elementAt(cartItems.indexOf(cartItem)).count;
                    } else {
                      cartItems.add(cartItem);
                    }
                  }
                  setState((){});
                }
            )
        )
    );
  }

  Widget createPreviewImage(){
    return new Center(
        child: new Image.asset(pizza.imagePath, width: 200.0, height: 200.0)
    );
  }

  Widget createDropDownButton(){
    return new Container(
      margin: const EdgeInsets.only(top: 20.0),
        decoration: new ShapeDecoration(
          shape: new RoundedRectangleBorder(
            side: new BorderSide(width: 1.0, style: BorderStyle.solid, color: Colors.white),
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
          ),
        ),
      width: 300.0,
      child: new DropdownButtonHideUnderline(
          child: new ButtonTheme(
            alignedDropdown: true,
            child: new Theme(
              data: Theme.of(context).copyWith(
                  brightness: Brightness.dark,
                  canvasColor: new Color(pizza.backgroundColor)
              ),
              child: new DropdownButton(
                style: new TextStyle(color: Colors.white, decorationColor: Colors.white),
                value: _pizzaSize,
                items: _pizzaSizes.map((PizzaSize pizzaSize){
                  return new DropdownMenuItem(
                      value: pizzaSize,
                      child: new Row(
                        children: <Widget>[
                          new Icon(Icons.local_pizza, color: Colors.white,),
                          new Text(" Size:  ${pizzaSize.description}", style: new TextStyle(color: Colors.white))
                        ],
                      )
                  );
                }).toList(),
                onChanged: (PizzaSize value) {_setPriceAndWeight(value);},
                hint: new Text('Choose size', style: new TextStyle(color: Colors.white)),
              ),
            ),
          )
      )
    );
  }

  Widget createDescriptionText(){
    return new Container(
      padding: const EdgeInsets.only(left: 40.0, right: 40.0),
      child: new Text(
        pizza.description,
        softWrap: true,
        style: new TextStyle(color: Colors.white),
      ),
    );
  }

}