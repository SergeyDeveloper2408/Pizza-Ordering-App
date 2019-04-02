import 'package:pizza_ordering_app/data/pizza.dart';
import 'package:pizza_ordering_app/data/pizza_size.dart';

class CartItem {

  Pizza pizza;
  PizzaSize pizzaSize;
  int count;

  CartItem({this.pizza, this.count, this.pizzaSize});

  double get totalCost => pizza.cost * pizzaSize.price * count;

  @override
  bool operator == (Object other) =>
      identical(this, other) ||
          other is CartItem &&
              runtimeType == other.runtimeType &&
              pizza.name == other.pizza.name &&
              pizzaSize.description == other.pizzaSize.description;

  @override
  int get hashCode => pizza.name.hashCode;

}