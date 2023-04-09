

import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mob1/Bloc/BuyedProducts.dart';
import 'package:mob1/Bloc/SugarQuantityBloc.dart';
import 'package:mob1/UI/Screens/BuyingScreen.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  State<ProductScreen> createState() => _MyAppState();
}

class _MyAppState extends State<ProductScreen> {
  double _currentSliderValue = 2;


  @override

  Widget build(BuildContext context) {
    final  sugarQuantityBloc = BlocProvider.of<SugarQuantityBloc>(context);
    final buyedProducts = Provider.of<BuyedProducts>(context);
    String _getDayOfWeek(int day) {
      switch (day) {
        case 1:
          return 'Monday';
        case 2:
          return 'Tuesday';
        case 3:
          return 'Wednesday';
        case 4:
          return 'Thursday';
        case 5:
          return 'Friday';
        case 6:
          return 'Saturday';
        case 7:
          return 'Sunday';
        default:
          return '';
      }
    }
    DateTime now = DateTime.now();
    String dayOfWeek = _getDayOfWeek(now.weekday);
    String formattedDate = "${now.day.toString().padLeft(2, '0')}-${now.month.toString().padLeft(2, '0')}-${now.year}";
    String formattedTime = "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}";

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 33, 130, 97),
          flexibleSpace: SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                     Text(
                      dayOfWeek,
                      style: const TextStyle(
                        fontSize: 12,
                        fontFamily: 'Poppins',
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      formattedDate,
                      style: const TextStyle(
                        fontSize: 12,
                        fontFamily: 'Poppins',
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const VerticalDivider(
                  color: Colors.white,
                  thickness: 2,
                  indent: 15,
                  endIndent: 15,
                ),
                 Container(
                  margin: const EdgeInsets.only(right: 40, left: 0),
                  child:  Text(
                    formattedTime,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: SafeArea(
          child: Scrollbar(
            child: Center(
              child: Card(
                elevation: 3,
                child: SizedBox(
                  height: 700,
                  width: 500,
                  child: Center(
                    child: Container(
                      margin: const EdgeInsets.only(top: 30, bottom: 30),
                      child: Column(
                        children: <Widget>[
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Image.asset(
                                  "lib/UI/assets/images/img.png",
                                  height: 150,
                                  width: 150,
                                ),
                                Column(children: <Widget>[
                                  const Text(
                                    "Cappuccino",
                                    style: TextStyle(
                                      fontSize: 27,
                                      fontWeight: FontWeight.w800,
                                      fontFamily: 'Poppins',
                                      color: Color.fromARGB(255, 33, 130, 97),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(top: 10),
                                    alignment: Alignment.center,
                                    width: 110,
                                    decoration: const BoxDecoration(
                                        color: Color.fromARGB(255, 33, 130, 97),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    child: const Text(
                                      "60 DA",
                                      style: TextStyle(
                                        fontSize: 27,
                                        fontWeight: FontWeight.w800,
                                        fontFamily: 'Poppins',
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ])
                              ]),
                          Container(
                            alignment: Alignment.center,
                            margin: const EdgeInsets.only(
                                top: 50, right: 70, left: 70, bottom: 30),
                            child: const Text(
                              "Lorem ipsum dolor sit amet constur Fringilla enim vitae sed vitae eget. Vel vel cras bibendum lectus scelerisque. ",
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Poppins',
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                const Text(
                                  "Sugar:",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Poppins',
                                    color: Colors.black,
                                  ),
                                ),
    BlocBuilder<SugarQuantityBloc,int>(
    builder:(BuildContext context,int sugarQuantity){
      return Slider(
        value: sugarQuantity.toDouble(),
        max: 5,
        divisions: 5,
        activeColor:
        const Color.fromARGB(255, 33, 130, 97),
        inactiveColor:
        const Color.fromARGB(130, 51, 51, 51),
        label: _currentSliderValue.round().toString(),
        onChanged: (double value) {
          setState(() {
            _currentSliderValue = value;
          });
        },
      );
    }),

                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              const Text(
                                "Quantity:",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Poppins',
                                  color: Colors.black,
                                ),
                              ),
                              Container(
                                decoration: const BoxDecoration(
                                    color: Color.fromARGB(100, 217, 217, 217),
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(40))),
                                margin: const EdgeInsets.only(left: 20),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                  BlocBuilder<SugarQuantityBloc,int>(
    builder:(BuildContext context,int sugarQuantity){
      return   FloatingActionButton(
        mini: true,
        backgroundColor:
        const Color.fromARGB(200, 33, 130, 97),
        onPressed: sugarQuantity==0?null:(){
          sugarQuantityBloc.add(SugarQuantityEvents.onDecreaseSugar);
        },

        child: const Icon(Icons.remove),
      );
    }),
                           
                                    SizedBox(width: 20,),
                                    BlocBuilder<SugarQuantityBloc,int>(
                                        builder:(BuildContext context,int sugarQuantity){
                                          return  Text(
                                            '$sugarQuantity',
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700,
                                              fontFamily: 'Poppins',
                                              color: Colors.black,
                                            ),
                                          );
                                        },
                                    ),
                                    SizedBox(width: 20,),
    BlocBuilder<SugarQuantityBloc,int>(
    builder:(BuildContext context,int sugarQuantity){
      return FloatingActionButton(
        mini: true,
        backgroundColor:
        const Color.fromARGB(200, 33, 130, 97),
        onPressed: sugarQuantity==5?null:(){
          sugarQuantityBloc.add(SugarQuantityEvents.onAddSugarEvent);
        },
        child: const Icon(Icons.add),
      );
    }),

                                  ],
                                ),
                              )
                            ],
                          ),
                          Container(
                              margin: const EdgeInsets.only(top: 120),
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    decoration: const BoxDecoration(
                                      color: Color.fromARGB(255, 33, 130, 97),
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(10.0),
                                          bottomRight: Radius.circular(10.0)),
                                    ),
                                    child: SizedBox(
                                      width: 200,
                                      child: FlatButton(
                                        onPressed: (){
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(builder: (context) => BuyingScreen()),
                                          );
                                        },
                                        child: const Text(
                                          'CANCEL',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700,
                                            fontFamily: 'Poppins',
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    decoration: const BoxDecoration(
                                      color: Color.fromARGB(255, 33, 130, 97),
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10.0),
                                          bottomLeft: Radius.circular(10.0)),
                                    ),
                                    child: SizedBox(
                                      width: 200,
                                      child: FlatButton(
                                        onPressed: (){
                                          buyedProducts.add_Product();
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(builder: (context) => BuyingScreen()),
                                          );
                                        },
                                        child: const Text(
                                          'ADD TO CART',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700,
                                            fontFamily: 'Poppins',
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ))
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

        ),

      ),
    );
  }
}
