import 'package:flutter/material.dart';
import 'package:pizza_ordering_app/data/cart.dart';
import 'package:pizza_ordering_app/data/cart_item.dart';
import 'package:pizza_ordering_app/view/navigation/backdrop.dart';
import 'package:uuid/uuid.dart';

class CartPreview extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      Scaffold(backgroundColor: new Color(0xFF294F6D), body: SafeArea(child: Panels()));
}

class Panels extends StatefulWidget {
  @override
  _PanelsState createState() => new _PanelsState();
}

class _PanelsState extends State<Panels> {

  final frontPanelVisible = ValueNotifier<bool>(false);
  final updateData = ValueNotifier<int>(1);

  @override
  Widget build(BuildContext context) {
    return Backdrop(
      frontLayer: FrontPanel(),
      backLayer: BackPanel(
        updateData: updateData,
        frontPanelOpen: frontPanelVisible,
      ),
      frontHeader: FrontPanelTitle(
          updateData: updateData,
          frontPanelOpen: frontPanelVisible
      ),
      panelVisible: frontPanelVisible,
      frontPanelOpenHeight: kToolbarHeight,
      frontHeaderHeight: 80.0,
      frontHeaderVisibleClosed: new Cart().items.isNotEmpty,
    );
  }


  @override
  void didUpdateWidget(Panels oldWidget) {
    super.didUpdateWidget(oldWidget);
    updateData.removeListener(_subscribeToValueIsDataUpdatedNotifier);
    updateData.addListener(_subscribeToValueIsDataUpdatedNotifier);
  }

  @override
  initState() {
    super.initState();
    updateData.addListener(_subscribeToValueIsDataUpdatedNotifier);
  }

  void _subscribeToValueIsDataUpdatedNotifier() {
    setState((){});
  }
}

class FrontPanelTitle extends StatefulWidget {
  FrontPanelTitle({@required this.frontPanelOpen, @required this.updateData});

  final ValueNotifier<bool> frontPanelOpen;
  final ValueNotifier<int> updateData;

  @override
  _FrontPanelTitleState createState() => new _FrontPanelTitleState();
}

class _FrontPanelTitleState extends State<FrontPanelTitle> {
  bool panelOpen;
  int isDataUpdated;

  @override
  initState() {
    super.initState();
    isDataUpdated = widget.updateData.value;
    panelOpen = widget.frontPanelOpen.value;
    widget.updateData.addListener(_subscribeToValueIsDataUpdatedNotifier);
    widget.frontPanelOpen.addListener(_subscribeToValueNotifier);
  }

  void _subscribeToValueIsDataUpdatedNotifier() {
    setState((){});
  }

  void _subscribeToValueNotifier() =>
      setState(() => panelOpen = widget.frontPanelOpen.value);

  /// Required for resubscribing when hot reload occurs
  @override
  void didUpdateWidget(FrontPanelTitle oldWidget) {
    super.didUpdateWidget(oldWidget);
    oldWidget.updateData.removeListener(_subscribeToValueIsDataUpdatedNotifier);
    oldWidget.frontPanelOpen.removeListener(_subscribeToValueNotifier);
    widget.updateData.addListener(_subscribeToValueIsDataUpdatedNotifier);
    widget.frontPanelOpen.addListener(_subscribeToValueNotifier);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          new Container(
            child: new Text(
                'Total cost: ${new Cart().getTotalCost()} \$',
                style: new TextStyle(color: Color(0xFF454545))
            ),
            alignment: Alignment.center,
          ),
          new Container(
            child: new Icon(panelOpen ? Icons.arrow_downward : Icons.arrow_upward, color: Color(0xFF454545)),
            margin: const EdgeInsets.only(top: 15.0),
          ),
          new Container(
            child: new Text(
                "Make an order",
                style: new TextStyle(color: Color(0xFF454545))
            ),
            alignment: Alignment.center,
          )
        ],
      ),
    );
  }
}

class FrontPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Theme.of(context).cardColor,
        child: Center(child: Text('Hello world')));
  }
}

class BackPanel extends StatefulWidget {
  BackPanel({@required this.frontPanelOpen, @required this.updateData});

  final ValueNotifier<bool> frontPanelOpen;
  final ValueNotifier<int> updateData;

  @override
  createState() => _BackPanelState();
}

class _BackPanelState extends State<BackPanel> {
  bool panelOpen;
  List<CartItem> itemsList = new Cart().items;

  @override
  initState() {
    super.initState();
    panelOpen = widget.frontPanelOpen.value;
    widget.frontPanelOpen.addListener(_subscribeToValueNotifier);
  }

  void _subscribeToValueNotifier() =>
      setState(() => panelOpen = widget.frontPanelOpen.value);

  /// Required for resubscribing when hot reload occurs
  @override
  void didUpdateWidget(BackPanel oldWidget) {
    super.didUpdateWidget(oldWidget);
    oldWidget.frontPanelOpen.removeListener(_subscribeToValueNotifier);
    widget.frontPanelOpen.addListener(_subscribeToValueNotifier);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: new Color(0xFF294F6D),
      appBar: new AppBar(
        backgroundColor: new Color(0xFF294F6D),
        elevation: 0.0,
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
            createList(),
          ]
      );
    } else {
      list = new Center(
          child: new Text('No items', style: new TextStyle(color: Colors.white))
      );
    }
    return list;
  }

  Widget createList(){
    return new Container(
        child: new ListView.builder(
            itemCount: itemsList.length,
            itemBuilder: (BuildContext context, int index)
            => createCartItemRow(index)
        ),
        height: MediaQuery.of(context).size.height-kToolbarHeight-104.0
    );
  }

  Widget createCartItemRow(int index){
    return Dismissible(
      key: Key(new Uuid().v1()),
      child: new Container(
          margin: const EdgeInsets.all(10.0),
          child: new ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: new Container(
                padding: const EdgeInsets.all(5.0),
                color: new Color(itemsList.elementAt(index).pizza.backgroundColor),
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
          )
      ),
      onDismissed: (direction) {
        removeItem(index);
      },
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
      widget.updateData.value = index;
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
          widget.updateData.value = itemsList.elementAt(index).count;
        },
        child: new Text(isPositiveButton ? "+" : "-", style: new TextStyle(color: Colors.black, fontSize: 12.0)),
        shape: new CircleBorder(),
        elevation: 2.0,
        fillColor: Colors.white,
      ),
    );
  }

}
