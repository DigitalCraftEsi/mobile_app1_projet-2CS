import 'dart:convert';

import 'package:http/http.dart' as http ;
import 'package:mob1/Data/Models/Drink.dart';
class DrinkServices{
  
  static Future<List<Drink>> getDrinks() async {
    List<Drink> Drinks=[];
    try{
      final res = await http.get("http://192.168.43.76:8000/machine/2/beverages");
      final data=json.decode(res.body) as Map<String,dynamic>;
      List<dynamic> ListOfMap=data["data"];
      Drinks= ListOfMap.map((c)=>Drink.fromJson(c)).toList() ;
      return Drinks;
    }
    catch(e){
      print(e.toString());
      return Drinks;
    }

  }
}