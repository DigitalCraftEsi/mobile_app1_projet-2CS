
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mob1/Bloc/SocketIoDistBloc.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'BuyingScreen.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({Key? key}) : super(key: key);

  @override
  _StatisticsScreenState createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  Map<String,dynamic> statistics={};
  @override
  void initState() {
    // TODO: implement initState
    String data=Provider.of<SocketIoDistBloc>(context,listen: false).statistics;
    setState(() {
      statistics=jsonDecode(data);
    });
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    Widget statisticRow(String title,int value){
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text("$title",style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            fontFamily: 'Poppins',
            color: Colors.black,
          ),),
          Row(
            children: [
              Container(
                width: 230,
                child: Slider(
                  value: value.toDouble(),
                  max: 100,
                  divisions: 100,
                  activeColor: Color.fromARGB(255, 33, 130, 97),
                  inactiveColor: Color.fromARGB(130, 51, 51, 51),
                  onChanged: (double v){

                  },

                ),
              ),
              Text("$value %",style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins',
                color: Color.fromARGB(255, 33, 130, 97),
              ),),
            ],
          ),

        ],
      );
    }
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
    var date=DateTime.now();
    var today= DateFormat('EEEE').format(date);
    var todayDate=DateFormat('dd-MM-yyyy').format(date);
    String hour=date.hour.toString();
    String minute=date.minute.toString();
    if(hour.length==1){
      hour='0'+hour;
    }
    if(minute.length==1){
      minute='0'+minute;
    }
    var screenWidth=MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(1, 113, 75, 1),
        leadingWidth: 170,
        leading:    Container(
          margin: EdgeInsets.only(left: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("$today",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 11),),
                  Text("$todayDate",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 11),),
                ],

              ),
              VerticalDivider(
                thickness: screenWidth/360,
                color: Colors.white,
                indent: 15,
                endIndent: 15,
              ),

              Text("${hour}:${minute}",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 18),),
            ],
          ),
        ),
        actions: [
          IconButton(onPressed: (){
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => BuyingScreen()),
            );
          }, icon: Icon(Icons.home,color: Colors.white,size: 34,)),
          SizedBox(width: 30,),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 3,
            child: SizedBox(
              height: 700,
              width: 500,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const  Text(
                      "Vending machine statistics",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w800,
                        fontFamily: 'Poppins',
                        color: Color.fromARGB(255, 33, 130, 97),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.symmetric(horizontal: 40,vertical: 5),
                      child: Text("Ingredients",style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Poppins',
                        color: Color.fromARGB(255, 33, 130, 97),
                      ),),
                    ),
                    Column(

                      children: [
                        statisticRow("Coffee", statistics["coffee"].toInt()),
                        statisticRow("Milk", statistics["milk"].toInt()),
                        statisticRow("Water", statistics["water"].toInt()),
                        statisticRow("Sugar", statistics["sugar"].toInt()),
                      ],
                    ),
                    SizedBox(height: 20,),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.symmetric(horizontal: 40,vertical: 5),
                      child: Text("Recipients",style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Poppins',
                        color: Color.fromARGB(255, 33, 130, 97),
                      ),),
                    ),
                    Column(

                      children: [
                        statisticRow("Spoons", 0),
                        statisticRow("Cups", 10),
                      ],
                    ),
                    SizedBox(height: 55,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.all( Radius.circular(28)),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 30,vertical: 5),
                          onPressed: (){
                            IO.Socket socketDist= Provider.of<SocketIoDistBloc>(context,listen: false).socket;
                            socketDist.emit("unlock-distribiteur","unlock");
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('the machine had been Unlocked',style: TextStyle(fontSize: 25),),
                                duration: Duration(seconds: 3),
                                backgroundColor:Color.fromRGBO(1, 113, 75, 1),
                                action: SnackBarAction(
                                  label: '',
                                  onPressed: () {
                                    // Perform some action
                                  },
                                ),
                              ),
                            );
                          },
                          child: Text("UnLock",style: TextStyle(letterSpacing: 1,fontWeight: FontWeight.w700,fontSize: 24,color: Colors.white,),),
                          color: Color.fromRGBO(1, 113, 75, 1),
                        ),
                        RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.all( Radius.circular(28)),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 30,vertical: 5),
                          onPressed: (){
                            IO.Socket socketDist= Provider.of<SocketIoDistBloc>(context,listen: false).socket;
                            socketDist.emit("powerOff-distribiteur","powerOff");
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('the machine had been Powered Off',style: TextStyle(fontSize: 25),),
                                duration: Duration(seconds: 3),
                                backgroundColor:Color.fromRGBO(1, 113, 75, 1),
                                action: SnackBarAction(
                                  label: '',
                                  onPressed: () {
                                    // Perform some action
                                  },
                                ),
                              ),
                            );
                          },
                          child: Text("Power Off",style: TextStyle(letterSpacing: 1,fontWeight: FontWeight.w700,fontSize: 24,color: Colors.white,),),
                          color: Colors.red,
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
    );
  }
}
