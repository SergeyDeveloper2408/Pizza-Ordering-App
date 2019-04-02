import 'package:pizza_ordering_app/data/pizza.dart';
import 'package:pizza_ordering_app/data/pizza_size.dart';

class GeneratePizzaUtil {

  static List<PizzaSize> getPizzaSizes(){
    return [
      new PizzaSize(
        description: "25 cm",
        price: 25.0,
        weight: "350 g"
      ),
      new PizzaSize(
        description: "30 cm",
        price: 30.0,
        weight: "680 g"
      ),
      new PizzaSize(
        description: "35 cm",
        price: 35.0,
        weight: "930 g"
      ),
    ];
  }

  static List<Pizza> getPizzaList(){
    return [
      new Pizza(
        name: "Bianca",
        imagePath: "images/pizza_examples/bianca_pizza_example.jpg",
        description: "Mozzarella cheese, parmesan, cream, tomato sauce, spices",
        cost: 0.1,
        backgroundColor: 0xFF84676b
      ),
      new Pizza(
        name: "Chicago style",
        imagePath: "images/pizza_examples/chicago_style_pizza_example.jpg",
        description: "Pesto Sauce, Mushrooms, Broccoli, Olives, "
            "Bulgarian Peppers, Tomatoes, Onions, Pizza Sauce, spices",
        cost: 0.2,
        backgroundColor: 0xFF9c7a55
      ),
      new Pizza(
        name: "Funghi",
        imagePath: "images/pizza_examples/funghi_pizza_example.jpg",
        description: "Salmon, tomatoes, olives, feta cheese, sauce based on ol."
            "butter with basil, cream sauce, mozzarella cheese, spices",
        cost: 0.3,
        backgroundColor: 0xFF497d4c
      ),
      new Pizza(
        name: "Hawaiian",
        imagePath: "images/pizza_examples/hawaiian_pizza_example.jpg",
        description: "Bacon, Champignons, Sausages hunting, pickled cucumber,"
            "onion, garlic, pizza sauce, Mozzarella cheese, spices",
        cost: 0.4,
        backgroundColor: 0xFF1e6d7c
      ),
      new Pizza(
        name: "Margherita",
        imagePath: "images/pizza_examples/margherita_pizza_example.jpg",
        description: "Barbecue sauce, bacon, chicken fillet, champignons,"
            " bell pepper, onion, pizza sauce, Mozzarella cheese, spices",
        cost: 0.5,
        backgroundColor: 0xFF49a57e
      ),
      new Pizza(
        name: "Marinara",
        imagePath: "images/pizza_examples/marinara_pizza_example.jpg",
        description: "Chicken fillet, pineapple, pizza sauce, mozzarella cheese,"
            " spices",
        cost: 0.6,
        backgroundColor: 0xFF746429
      ),
      new Pizza(
        name: "Mexicana",
        imagePath: "images/pizza_examples/mexicana_pizza_example.jpg",
        description: "Shrimps, mussels, olives, cream sauce, Mozzarella cheese,"
            " spices, lemon slice",
        cost: 0.7,
        backgroundColor: 0xFF9e384d
      ),
      new Pizza(
        name: "Napoli",
        imagePath: "images/pizza_examples/napoli_pizza_example.jpg",
        description: "Bacon, hunting sausages, champignons, green beans,"
            " tomatoes, pizza sauce, mozzarella cheese, onions, spices",
        cost: 0.8,
        backgroundColor: 0xFFb13f35
      ),
      new Pizza(
        name: "Newyork style",
        imagePath: "images/pizza_examples/newyork_style_pizza_example.jpg",
        description: "Feta cheese, tomatoes, Bulgarian pepper, olives,"
            " sauce based on ol. butter with basil, cream sauce,"
            " mozzarella cheese, spices",
        cost: 0.7,
        backgroundColor: 0xFF205d9c
      ),
      new Pizza(
        name: "Pepperoni",
        imagePath: "images/pizza_examples/pepperoni_pizza_example.jpg",
        description: "Salami 'Pepperoni', pizza sauce, mozzarella cheese, spices",
        cost: 0.6,
        backgroundColor: 0xFF136d47
      ),
      new Pizza(
        name: "Quattro formaggi",
        imagePath: "images/pizza_examples/quattro_formaggi_pizza_example.jpg",
        description: "Bacon, pepperoni, onions, mushrooms, jalapeno peppers,"
            " mozzarella cheese, red sauce",
        cost: 0.5,
        backgroundColor: 0xFF712a30
      ),
      new Pizza(
        name: "Supreme style",
        imagePath: "images/pizza_examples/supreme_style_pizza_example.jpg",
        description: "Prosciutto (Parma ham), tomatoes, parmesan, cream, "
            "tomato sauce, mozzarella cheese, spices",
        cost: 0.4,
        backgroundColor: 0xFFb04f2e
      )
    ];
  }
}