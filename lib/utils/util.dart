import 'package:pizza_ordering_app/data/cart.dart';
import 'package:pizza_ordering_app/data/cart_item.dart';

class Util {
  static int getCartAllItemsLength(){
    int length = 0;
    for(int i = 0; i < new Cart().items.length; i++){
      length += new Cart().items.elementAt(i).count;
    }
    return length;
  }
}