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

  String _dropdownValue;
  final List<String> _dropdownValues = ["Small", "Middle", "Large"];

  void _onDropDownButtonItemChanged(String value){
    setState(() {
      _dropdownValue = value;
    });
  }

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
              child: createPreviewImage()
            ),
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
      margin: EdgeInsets.only(top: 30.0),
      padding: const EdgeInsets.only(left: 40.0, right: 40.0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          new Container(
            alignment: Alignment.bottomRight,
            child: new Text(
              "150 \$",
              style: new TextStyle(fontSize: 25.0, color: Colors.white,),
            ),
          ),
          new Container(
            alignment: Alignment.bottomRight,
            margin: const EdgeInsets.only(left: 20.0),
            child: new Text(
              "650 g",
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
                  Navigator.of(context).pushNamed("/PizzaList");
                }
            )
        )
    );
  }

  Widget createPreviewImage(){
    return new Image.asset(
      "images/pizza_examples/newyork_style_pizza_example.jpg",
      width: 200.0,
      height: 200.0,
    );
  }

  Widget createDropDownButton(){
    return new Container(
      margin: EdgeInsets.only(top: 20.0),
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
                  canvasColor: Colors.blue
              ),
              child: new DropdownButton(
                style: new TextStyle(color: Colors.white, decorationColor: Colors.white),
                value: _dropdownValue,
                items: _dropdownValues.map((String item){
                  return new DropdownMenuItem(
                      value: item,
                      child: new Row(
                        children: <Widget>[
                          new Icon(Icons.local_pizza, color: Colors.white,),
                          new Text(" Size:  $item", style: new TextStyle(color: Colors.white))
                        ],
                      )
                  );
                }).toList(),
                onChanged: (String value) {_onDropDownButtonItemChanged(value);},
                hint: new Text('DropdownButton Hint', style: new TextStyle(color: Colors.white)),
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
        'Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese '
            'Alps. Situated 1,578 meters above sea level, it is one of the '
            'enjoyed here include rowing.',
        softWrap: true,
        style: new TextStyle(color: Colors.white),
      ),
    );
  }

}