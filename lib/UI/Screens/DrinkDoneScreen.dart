import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mob1/Bloc/BuyedProducts.dart';
import 'package:mob1/Bloc/SocketIoBloc.dart';
import 'package:mob1/UI/Screens/BuyingScreen.dart';
import 'package:mob1/main.dart';
import 'package:provider/provider.dart';



class DrinkDoneScreen extends StatefulWidget {
  const DrinkDoneScreen({Key? key}) : super(key: key);

  @override
  State<DrinkDoneScreen> createState() => _MyAppState();
}

class _MyAppState extends State<DrinkDoneScreen> {
  @override
  void initState() {
    // TODO: implement initState
     Provider.of<BuyedProducts>(context,listen: false).initialise_List();
    Future.delayed(Duration(seconds: 8), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => BuyingScreen()),
      );
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
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
    String formattedDate =
        "${now.day.toString().padLeft(2, '0')}-${now.month.toString().padLeft(2, '0')}-${now.year}";
    String formattedTime =
        "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}";

    return  Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(1, 113, 75, 1),
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
                  child: Text(
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
          child: Center(
            child: Card(
              elevation: 3,
              child: SizedBox(
                height: 700,
                width: 500,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const  Text(
                        "Enjoy your drink !",
                        style: TextStyle(
                          fontSize: 29,
                          fontWeight: FontWeight.w800,
                          fontFamily: 'Poppins',
                          color: Color.fromARGB(255, 33, 130, 97),
                        ),
                      ),
                      Image.asset(
                        "lib/UI/assets/images/img_3.png",
                        height: 400,
                        width: 400,
                      ),
                      const Text(
                        '"SmartBev, your personalized hot drink solution"',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Poppins',
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      
    );
  }
}
