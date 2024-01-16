// providers/drink_provider.dart
import 'package:flutter/material.dart';
import 'package:drink_water_reminder/models/drink.dart';


class DrinkProvider extends ChangeNotifier {
  List<Drink> _drinks = [
    Drink(name: 'Small Glass', milliliters: 150),
    Drink(name: 'Regular Glass', milliliters: 250),
    Drink(name: 'Big Glass', milliliters: 350),
  ];

  List<Drink> get drinks => _drinks;
}
