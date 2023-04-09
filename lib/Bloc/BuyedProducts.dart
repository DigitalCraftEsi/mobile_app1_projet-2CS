import 'package:flutter/foundation.dart';

class BuyedProducts extends ChangeNotifier {
  List<Product> _listOfBuyedProducts=[];

  List<Product> get list => _listOfBuyedProducts;

  void add_Product() {
    _listOfBuyedProducts.add(Product("lib/UI/assets/images/cappochino.png", "Cappuchino", 1, 60));
    notifyListeners();
  }
  void remove_Product() {
    _listOfBuyedProducts.removeAt(_listOfBuyedProducts.length-1);
    notifyListeners();
  }
  void initialise_List(){
    _listOfBuyedProducts.clear();
    notifyListeners();
  }
  int total_Price(){
    int total=0;
    for(int i=0;i<_listOfBuyedProducts.length;i++){
      total=total+_listOfBuyedProducts[i].price;
    }
    return total;
  }
}
class Product{
  final String image;
  final String name;
  final int quantity;
  final int price;

  Product(this.image, this.name, this.quantity, this.price);
}