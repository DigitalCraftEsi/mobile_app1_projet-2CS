import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mob1/Bloc/BuyedProducts.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';


class SocketIoDistBloc extends ChangeNotifier {
  late IO.Socket socket;
   late String code;
    String statistics="";
  void setStatistics(String statistics){
    this.statistics=statistics;
    notifyListeners();
  }
   void setCode(String code){
     this.code=code;
     notifyListeners();
   }
  void connectToMachine() {
    socket = IO.io('http://192.168.201.154:8080', OptionBuilder()
        .setTransports(['websocket'])
        .disableAutoConnect() // for Flutter or Dart VM// disable auto-connection// optional
        .build()

    );
    socket.connect();
    socket.onConnectError((data) => print("error ${data.toString()}"));
    socket.onConnect((_) {
      print('connect');

    });

    notifyListeners();
  }
  void onError(){
    socket.onError((error) {
      print('Socket error: $error');
    });
  }

}