import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mob1/Bloc/BuyedProducts.dart';
import 'package:mob1/Bloc/QrCodeBloc.dart';
import 'package:mob1/UI/Screens/PaymentDoneScreen.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';


class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key, required this.dataEncoded}) : super(key: key);
  final String dataEncoded;
  @override
  State<PaymentScreen> createState() => _MyAppState();
}

class _MyAppState extends State<PaymentScreen> {
   @override
 /* void initState() {
    Future.delayed(Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => PaymentDoneScreen()),
      );
    });
    super.initState();
  }*/
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
                  child: Container(
                    margin: const EdgeInsets.only(top: 30, bottom: 30),
                    child: Column(
                      children: <Widget>[
                        const Text(
                          "Scan the code to pay",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                            fontFamily: 'Poppins',
                            color: Color.fromARGB(255, 33, 130, 97),
                          ),
                        ),
                      /*  Container(
                          margin: const EdgeInsets.only(top: 50),
                          child: Image.asset(
                            "lib/UI/assets/images/img_1.png",
                            height: 190,
                            width: 190,
                          ),
                        ),*/
                        QrImage(data: widget.dataEncoded,size: 190,),
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.only(
                              top: 50, bottom: 20,left:90),
                          child: const Text(
                            "How to Pay Merchants",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Poppins',
                              color: Color.fromARGB(255, 33, 130, 97),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const CircleAvatar(
                              radius: 12,
                              backgroundColor: Color.fromARGB(255, 33, 130, 97),
                              child: Text(
                                '1',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Find the QR Code",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Poppins',
                                    color: Colors.black,
                                  ),
                                ),
                                Container(
                                  width: 250,
                                  child: const Text(
                                    "After Finalizing  your command , the vending machine will display a QR code",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Poppins',
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height:20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const CircleAvatar(
                              radius: 12,
                              backgroundColor: Color.fromARGB(255, 33, 130, 97),
                              child: Text(
                                '2',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Scan QR Code to Pay",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Poppins',
                                    color: Colors.black,
                                  ),
                                ),
                                Container(
                                  width: 250,
                                  child: const Text(
                                    "Tap Pay in the SmartBev app to start scanning.",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Poppins',
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height:20,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const CircleAvatar(
                              radius: 12,
                              backgroundColor: Color.fromARGB(255, 33, 130, 97),
                              child: Text(
                                '3',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Get your Drinks",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Poppins',
                                    color: Colors.black,
                                  ),
                                ),
                                Container(
                                  width: 250,
                                  child: const Text(
                                    "Ensure that the payment is done and get your drinks",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Poppins',
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
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
