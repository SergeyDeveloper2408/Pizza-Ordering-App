import 'cart_item.dart';

class Cart {
  static final Cart _singleton = new Cart._internal();
  List<CartItem> items = new List();

  factory Cart() {
    return _singleton;
  }

  Cart._internal();

  double getTotalCost(){
    double totalCost = 0.0;
    for(var item in items){
      totalCost += item.totalCost;
    }
    return totalCost;
  }

}