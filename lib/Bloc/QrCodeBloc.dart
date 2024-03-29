import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mob1/Bloc/BuyedProducts.dart';


class QrCodeBloc extends ChangeNotifier {
  String Dataencoded = "";

  void EncodeData(List<Product> ProductsList,int IdDistributeur,int total) {
    List<Map<String,dynamic>> ListOfProducts=[];
    Map<String,dynamic> encodedMap={};
    encodedMap.putIfAbsent('idDistributeur', () => IdDistributeur);
    encodedMap.putIfAbsent('total', () => total);
    ProductsList.forEach((element) {
      Map<String,dynamic> mappedProducts={};
      mappedProducts.putIfAbsent('idBoisson', () => element.idBoisson);
      mappedProducts.putIfAbsent('Quantite', () => element.quantity);
      ListOfProducts.add(mappedProducts);
    }
    );
    encodedMap.putIfAbsent('boissons', () => ListOfProducts);
    Dataencoded=json.encode(encodedMap);
    notifyListeners();
  }

}