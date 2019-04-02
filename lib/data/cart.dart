import 'cart_item.dart';

class Cart {
  static final Cart _singleton = new Cart._internal();
  List<CartItem> items = new List();
  double totalCost;

  factory Cart() {
    return _singleton;
  }

  Cart._internal();

}