import 'package:flutter/foundation.dart';
import 'package:mob1/Data/Models/Drink.dart';

class BuyedProducts extends ChangeNotifier {
  List<Product> _listOfBuyedProducts=[];

  List<Product> get list => _listOfBuyedProducts;

  void add_Product(int idBoisson,int quantity) {
    _listOfBuyedProducts.add(Product(idBoisson: idBoisson,quantity: quantity));
    notifyListeners();
  }
  void remove_Product(int idBoisson) {
    print(_listOfBuyedProducts);
    _listOfBuyedProducts.removeWhere((element) => element.idBoisson==idBoisson);
    notifyListeners();
  }
  void initialise_List(){
    _listOfBuyedProducts.clear();
    notifyListeners();
  }
  int total_Price(){
    int total=0;
    for(int i=0;i<_listOfBuyedProducts.length;i++){
      total=total+60;
    }
    return total;
  }
}
class Product{
  final int idBoisson;
  final int quantity;

  Product({required this.idBoisson,required this.quantity});
}