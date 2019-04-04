import 'package:flutter/material.dart';
import 'package:pizza_ordering_app/data/pizza.dart';
import 'package:pizza_ordering_app/data/pizza_size.dart';
import 'package:pizza_ordering_app/data/cart.dart';
import 'package:pizza_ordering_app/data/cart_item.dart';

class OrderPreview extends StatefulWidget {
  @override
  _OrderPreviewState createState() => new _OrderPreviewState();
}

class _OrderPreviewState extends State<OrderPreview> {

  DateTime _date = new DateTime.now();
  TimeOfDay _time = new TimeOfDay.now();
  bool isDeliveryTimeSpecific = false;
  bool isPaymentTypeCash = true;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.deepOrangeAccent,
      appBar: new AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        title: new Text("Fill order info"),
      ),

      body: new SingleChildScrollView(
          child: Stack(
              children: <Widget>[
                new Container(
                  child: new Column(
                    children: <Widget>[

                      createLabelText("Personal info"),
                      createInfoTextField("Put your name here", Icons.person),
                      createInfoTextField("Put your phone here", Icons.phone),

                      createLabelText("Delivery place info"),
                      createInfoTextField("Put your adress here", Icons.place),
                      createInfoTextField(
                          "Put delievery comments here",
                          Icons.comment,
                          mMaxLines: 3
                      ),

                      createLabelText("Delivery time info"),
                      createDeliveryTimeInfoListTile(
                        text: "Deliver soon",
                        mGroupValue: isDeliveryTimeSpecific,
                        onChanged: deliveryTimeInfoChanged
                      ),
                      createDeliveryTimeInfoListTile(
                          text: "Deliver at specific time",
                          initialValue: true,
                          mGroupValue: isDeliveryTimeSpecific,
                          onChanged: deliveryTimeInfoChanged
                      ),
                      isDeliveryTimeSpecific
                          ? createSpecificTimeFields() : new Container(),

                      createLabelText("Payment"),
                      createDeliveryTimeInfoListTile(
                          text: "Cash",
                          initialValue: true,
                          mGroupValue: isPaymentTypeCash,
                          onChanged: paymentTypeChanged
                      ),
                      isPaymentTypeCash
                          ? createInfoTextField("Rest from ", Icons.attach_money)
                          : new Container(),
                      createDeliveryTimeInfoListTile(
                          text: "Card",
                          mGroupValue: isPaymentTypeCash,
                          onChanged: paymentTypeChanged
                      ),
                      new Divider(color: Colors.white),
                      createTotalCostRow(),
                      createOrderButton()
                    ],
                  ),
                ),
              ]
          )
      )
    );
  }

  void deliveryTimeInfoChanged(bool value){
    setState(() {
      isDeliveryTimeSpecific = value;
    });
  }

  void paymentTypeChanged(bool value){
    setState(() {
      isPaymentTypeCash = value;
    });
  }

  Widget createOrderButton(){
    return new Container(
        margin: const EdgeInsets.only(top: 30.0, bottom: 30.0),
        child: new ButtonTheme(
            minWidth: 350.0,
            height: 50.0,
            buttonColor: Colors.white,
            child: new RaisedButton(
                child: new Text("Order"),
                onPressed: (){}
            )
        )
    );
  }

  Widget createSpecificTimeFields(){
    return new Container(
      margin: const EdgeInsets.only(top: 6.0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          createDateTimeInfoFlatButton("Time: 11:00"),
          createDateTimeInfoFlatButton("Date: 03/04/2019")
        ]
      )
    );
  }

  Widget createDateTimeInfoFlatButton(String text){
    return new Container(
        child: new FlatButton(
          textColor: Colors.white,
          onPressed: () {},
          child: new Text(text),
          shape: new RoundedRectangleBorder(
              side: new BorderSide(
                  color: Colors.white,
                  style: BorderStyle.solid
              ),
              borderRadius: BorderRadius.circular(5.0)
          ),
        )
    );
  }

  Widget createTotalCostRow(){
    return new Container(
      margin: const EdgeInsets.only(top: 20.0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          new Container(
            margin: const EdgeInsets.only(left: 20.0),
            child: new Text(
                "Total: ",
                style: new TextStyle(color: Colors.white, fontSize: 20.0)
            ),
          ),
          new Container(
            margin: const EdgeInsets.only(right: 20.0),
            child: new Text(
                "220 \$",
                style: new TextStyle(color: Colors.white, fontSize: 20.0)
            ),
          )
        ],
      ),
    );
  }

//  Future<Null> selectDate(BuildContext context) async {
//    final DateTime picked = await showDatePicker(
//        context: context,
//        initialDate: _date,
//        firstDate: new DateTime(_date.year, _date.month, _date.day),
//        lastDate: new DateTime(new DateTime.now().year)
//    );
//  }

//  Widget createDatePicker(){
//    return new Container(
//      alignment: Alignment.centerLeft,
//      margin: const EdgeInsets.only(top: 20.0, left: 20.0),
//      child:
//    );
//  }

  Widget createDeliveryTimeInfoListTile({String text, bool initialValue = false,
      bool mGroupValue, Function onChanged}){
    return new Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.only(top: 20.0),
      child: new RadioListTile(
          groupValue: mGroupValue,
          title: new Text(
              text,
              style: new TextStyle(color: Colors.white)
          ),
          value: initialValue,
          onChanged: onChanged,
      )
    );
  }

  Widget createLabelText(String text){
    return new Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.only(top: 20.0, left: 20.0),
      child: new Text(
          text,
          style: new TextStyle(color: Colors.white)
      ),
    );
  }

  Widget createInfoTextField(String mLabelText, IconData icon, {int mMaxLines = 1}){
    return new Container(
      child: new Theme(
        data: new ThemeData(
          primaryColor: Colors.white,
          primaryColorDark: Colors.white,
        ),
        child: new TextField(
          maxLines: mMaxLines,
          cursorColor: Colors.white,
          cursorWidth: 1.0,
          decoration: new InputDecoration(
            enabledBorder: const OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white),
            ),
            labelText: mLabelText,
            labelStyle: new TextStyle(color: Colors.white),
            prefixIcon: new Icon(icon, color: Colors.white,
            ),
          ),
        ),
      ),
      margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
    );
  }
 }