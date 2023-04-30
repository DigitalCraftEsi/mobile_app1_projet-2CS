import 'package:flutter/foundation.dart';
import 'package:mob1/Data/Models/Drink.dart';
import 'package:mob1/Data/Services/DrinksService.dart';

class Drinks extends ChangeNotifier {
  List<Drink> _listOfDrinks = [];

  List<Drink> get list => _listOfDrinks;

  Future<void> LoadDrinks(String distUID) async {
    _listOfDrinks= await DrinkServices.getDrinks(distUID);
    notifyListeners();
  }
  Drink getDrink(int id){
    return _listOfDrinks.firstWhere((element) => element.IdBoisson==id);
    notifyListeners();
  }
}