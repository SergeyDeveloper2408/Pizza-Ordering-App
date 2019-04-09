import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:pizza_ordering_app/data/pizza.dart';
import 'package:pizza_ordering_app/data/pizza_size.dart';
import 'package:pizza_ordering_app/utils/generate_pizza_util.dart';
import 'package:pizza_ordering_app/data/cart.dart';
import 'package:pizza_ordering_app/data/cart_item.dart';
import 'package:badges/badges.dart';
import 'package:pizza_ordering_app/utils/util.dart';

class Preview extends StatefulWidget {

  final Pizza pizza;

  Preview({Key key, @required this.pizza}) : super(key: key);

  @override
  _PreviewState createState() => new _PreviewState(pizza);
}

class _PreviewState extends State<Preview> {

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final Pizza pizza;
  final List<PizzaSize> _pizzaSizes = GeneratePizzaUtil.getPizzaSizes();
  PizzaSize _pizzaSize;

  double _pizzaPrice;
  String _pizzaWeight;

  List<CartItem> cartItems = new Cart().items;
  CartItem cartItem;

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
      key: _scaffoldKey,
      backgroundColor: new Color(pizza.backgroundColor),
      appBar: new AppBar(
        backgroundColor: new Color(pizza.backgroundColor),
        elevation: 0.0,
        title: new Text(pizza.name),
        actions: <Widget>[
          new Container(
            margin: const EdgeInsets.only(right: 10.0),
            child: new BadgeIconButton(
                itemCount: Util.getCartAllItemsLength(), // required
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
            createOrderButton(context)
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

  Widget createOrderButton(BuildContext context){
    return new Container(
        margin: const EdgeInsets.only(top: 30.0),
        child: new ButtonTheme(
            minWidth: 300.0,
            height: 50.0,
            buttonColor: Colors.white,
            child: new RaisedButton(
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0)
                ),
                elevation: 0.0,
                disabledElevation: 0.0,
                highlightElevation: 0.0,
                child: new Text("Add to cart"),
                onPressed: (){
                  addPizzaToCart();
                  displayDialog();
                }
            )
        )
    );
  }

  CartItem getNewItem(){
    return new CartItem(
        pizza: pizza,
        pizzaSize: _pizzaSize
    );
  }

  void removePizzaFromCart(){

    cartItem = getNewItem();

    if(cartItems.elementAt(cartItems.indexOf(cartItem)).count > 1){
      --cartItems.elementAt(cartItems.indexOf(cartItem)).count;
    } else {
      cartItems.remove(cartItem);
    }
    setState((){});
  }

  void addPizzaToCart(){

    cartItem = getNewItem();

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

  void displayDialog() {
    _scaffoldKey.currentState.showSnackBar(
        new SnackBar(
          backgroundColor: Colors.white,
          duration: Duration(milliseconds: 3000),
          content: Text(
              'You succesfully added one more pizza!',
              style: new TextStyle(
                  color: Color(0xFF454545),
                  fontFamily: "Handlee-Regular"
              )
          ),
          action: SnackBarAction(
            textColor: Color(0xFF454545),
            label: 'Undo',
            onPressed: () {
              removePizzaFromCart();
            },
          ),
        )
    );

//    showDialog(
//      context: context,
//      builder: (BuildContext context) => new CupertinoAlertDialog(
//        title: new Text("Added!"),
//        content: new Text("You succesfully added one more pizza."),
//        actions: [
//          CupertinoDialogAction(
//              isDefaultAction: true,
//              onPressed: () {
//                Navigator.of(context).pop();
//              },
//              child: new Text("Ok")
//          )
//        ],
//      ),
//    );
  }

  Widget createPreviewImage(){
    return new Center(
        child: new Image.asset(pizza.imagePath, width: 200.0, height: 200.0)
    );
  }

  Widget createDropDownButton(){
    return new Container(
      padding: const EdgeInsets.only(right: 15.0, left: 15.0),
      margin: const EdgeInsets.only(top: 20.0),
        decoration: new ShapeDecoration(
          shape: new RoundedRectangleBorder(
            side: new BorderSide(width: 1.0, style: BorderStyle.solid, color: Colors.white),
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
          ),
        ),
      width: 305.0,
      child: new DropdownButtonHideUnderline(
          child: new ButtonTheme(
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
                          new Icon(Icons.local_pizza, color: Colors.white),
                          new Container(
                            margin: const EdgeInsets.only(left: 10.0),
                            child: new Text(
                              "Size:  ${pizzaSize.description}",
                              style: new TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Handlee-Regular"
                              ),
                            )
                          )
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
      margin: const EdgeInsets.only(left: 35.0, right: 35.0),
      child: new Text(
        pizza.description,
        textAlign: TextAlign.center,
        softWrap: true,
        style: new TextStyle(color: Colors.white),
      ),
    );
  }

}