import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class DrinkDoneScreen extends StatefulWidget {
  const DrinkDoneScreen({Key? key}) : super(key: key);

  @override
  State<DrinkDoneScreen> createState() => _MyAppState();
}

class _MyAppState extends State<DrinkDoneScreen> {
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
                height: 550,
                width: 350,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const  Text(
                        "Enjoy your drink !",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w800,
                          fontFamily: 'Poppins',
                          color: Color.fromARGB(255, 33, 130, 97),
                        ),
                      ),
                      Image.asset(
                        "lib/UI/assets/images/img_3.png",
                        height: 300,
                        width: 300,
                      ),
                      const Text(
                        '"SmartBev, your personalized hot drink solution"',
                        style: TextStyle(
                          fontSize: 11,
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
