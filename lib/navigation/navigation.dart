import "package:flutter/material.dart";
import "package:pizza_ordering_app/pizza_list/pizza_list.dart";
import "package:pizza_ordering_app/preview/preview.dart";

class Navigation {
  static final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
    "/PizzaList": (BuildContext context) => new PizzaList(),
  };
}