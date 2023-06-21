import 'dart:io';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mob1/Bloc/AddsBloc.dart';
import 'package:mob1/Bloc/SocketIoBloc.dart';
import 'package:mob1/Bloc/SocketIoDistBloc.dart';
import 'package:mob1/UI/Screens/DrinkDoneScreen.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;




class PaymentDoneScreen extends StatefulWidget {
  const PaymentDoneScreen({Key? key}) : super(key: key);

  @override
  State<PaymentDoneScreen> createState() => _MyAppState();
}

class _MyAppState extends State<PaymentDoneScreen> {
  bool isloading=true;
  Map<String,dynamic>  data={};
  @override
  void initState() {
    // Future.delayed(Duration(seconds: 5), () {
    //   Navigator.pushReplacement(
    //     context,
    //     MaterialPageRoute(builder: (context) => DrinkDoneScreen()),
    //   );
    // });
    super.initState();
    Provider.of<AddsBloc>(context,listen: false).getAdd(picture: File("lib/UI/assets/images/img_2.png"), distUid: "2").then((value){
      setState(() {
        isloading=false;
        data=Provider.of<AddsBloc>(context,listen: false).data;
        print("data $data");
        print(data.isEmpty);
      });
    });

    IO.Socket socket= Provider.of<SocketIoBloc>(context,listen: false).socket;
    IO.Socket socketDist= Provider.of<SocketIoDistBloc>(context,listen: false).socket;
    socketDist.on("response_event",(data){
      print("hhh $data");
      socket.emitWithAck("preparation-done",null,ack: (){
        print("ack sent");
      });
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => DrinkDoneScreen()),
      );
    });

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

    return Scaffold(
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
                height: 700,
                width: 500,
                child: Center(
                  child: Container(
                    margin: const EdgeInsets.only(top: 30),
                    child: Column(
                      mainAxisAlignment: isloading?MainAxisAlignment.center:MainAxisAlignment.spaceBetween,
                      children: <Widget>[

                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: const EdgeInsets.only( bottom:30),
                              child: Image.asset(
                                "lib/UI/assets/images/img_2.png",
                                height: 150,
                                width: 150,
                              ),
                            ),
                            const Text(
                              "Payment processed",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Poppins',
                                color: Colors.black,
                              ),
                            ),
                            const Text(
                              "Your Drink will be ready in a moment",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Poppins',
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        isloading?Container():(data.isEmpty?Container(
                          child: Image.network("https://th.bing.com/th/id/OIP.SJBBH0TFHFSdiuR718pfxQHaFh?pid=ImgDet&rs=1",)):data["data"]["link"]==null?Container(
                        child: Image.network("https://fiverr-res.cloudinary.com/videos/so_11.219035,t_main1,q_auto,f_auto/flfffyyj4wleq0ugwj5l/place-your-logo-and-text-in-this-coffee-advert.png")):Container(
                          child: Image.network("${data["data"]["link"]}"),
                        ))
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
