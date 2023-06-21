import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:mob1/Data/Models/Drink.dart';
import 'package:mob1/Data/Services/AddsService.dart';
import 'package:mob1/Data/Services/DrinksService.dart';

class AddsBloc extends ChangeNotifier {
  Map<String,dynamic> _data = {};

  Map<String,dynamic> get data => _data;

  Future<void> getAdd({required File picture,required String distUid}) async {
    _data= await AddsService.getAdd(picture:picture,distUid:distUid);
    notifyListeners();
  }

}