import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mob1/Bloc/BuyedProducts.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';


class SocketIoBloc extends ChangeNotifier {
  late IO.Socket socket;
  late bool isloading;
  late int idDistributeur;

  void setIdDistributeur(int idDistributeur){
   this.idDistributeur=idDistributeur;
    notifyListeners();
  }
  void connectToMachine() {
    socket = IO.io('http://192.168.43.185:8000', OptionBuilder()
        .setTransports(['websocket'])
        .disableAutoConnect() // for Flutter or Dart VM// disable auto-connection
        .setExtraHeaders({'auth':jsonEncode({'type': 'DISTRIBUTEUR',
      "payload":{
        "distUid":"232323"
      }
    })})// optional
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