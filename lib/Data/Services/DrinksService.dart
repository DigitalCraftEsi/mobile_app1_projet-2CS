import 'dart:convert';

import 'package:http/http.dart' as http ;
import 'package:mob1/Data/Models/Drink.dart';
class DrinkServices{
  
  static Future<List<Drink>> getDrinks(String distUID) async {
    List<Drink> Drinks=[];
    try{
      final res = await http.post("http://192.168.43.185:8000/beverage",
     body: {
        "distUID":"$distUID",
     }
      );
      final data=json.decode(res.body) as Map<String,dynamic>;
      List<dynamic> ListOfMap=data["data"]["boissons"];
      print(ListOfMap);
      Drinks= ListOfMap.map((c)=>Drink.fromJson(c)).toList() ;
      return Drinks;
    }
    catch(e){
      print("jutos "+e.toString());
      return Drinks;
    }

  }
}