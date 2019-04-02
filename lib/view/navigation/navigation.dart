import "package:flutter/material.dart";
import "package:pizza_ordering_app/view/pizza_list/pizza_list.dart";
import 'package:pizza_ordering_app/view/preview/cart_preview.dart';

class Navigation {
  static final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
    "/PizzaList": (BuildContext context) => new PizzaList(),
    "/CartPreview": (BuildContext context) => new CartPreview()
  };
}