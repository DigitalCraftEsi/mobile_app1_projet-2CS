

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mob1/Bloc/SocketIoDistBloc.dart';
import 'package:mob1/UI/Screens/BuyingScreen.dart';
import 'package:mob1/UI/Screens/StatisticsScreen.dart';
import 'package:mob1/main.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
class EnterCodeScreen extends StatefulWidget {
  const EnterCodeScreen({Key? key}) : super(key: key);

  @override
  _EnterCodeScreenState createState() => _EnterCodeScreenState();
}

class _EnterCodeScreenState extends State<EnterCodeScreen> {
  String code="";
  bool isloading=false;
  late IO.Socket socketDist;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    socketDist=Provider.of<SocketIoDistBloc>(context,listen: false).socket;
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

    Widget clicableNumbre(int number){
      return InkWell(
        onTap: (){
          if(code.length<4){
            setState(() {
              code=code+"$number";
            });

          }
          print(code);
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20,vertical: 15),
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Color.fromARGB(255, 33, 130, 97),
              width: 2,
            ),
          ),
          child: Center(
            child: Text("$number",style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              fontFamily: 'Poppins',
              color: Color.fromARGB(255, 33, 130, 97),
            ),),
          ),
        ),
      );
    }

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
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 85,),
            Image.asset(
              "lib/UI/assets/images/logo.png",
              height: 100,
              width: 100,
            ),
            SizedBox(height: 30,),
             Text(
              "Enter the code",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w800,
                fontFamily: 'Poppins',
                color: Color.fromARGB(255, 33, 130, 97),
              ),
            ),
            SizedBox(height: 20,),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '* ' * code.length,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Poppins',
                      color: Color.fromARGB(255, 33, 130, 97),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                clicableNumbre(1),
                clicableNumbre(2),
                clicableNumbre(3),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                clicableNumbre(4),
                clicableNumbre(5),
                clicableNumbre(6),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                clicableNumbre(7),
                clicableNumbre(8),
                clicableNumbre(9),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 SizedBox(width: 70,),
                clicableNumbre(0),
                SizedBox(width: 27,),
                IconButton(onPressed: (){
                    if(code.length!=0){
                      setState(() {
                        code = code.substring(0, code.length - 1);
                        print(code);
                      });

                    }
                },

                    icon: Icon(Icons.cancel,color: Color.fromARGB(255, 33, 130, 97),size: 50,)
                ),
              ],
            ),
            SizedBox(height: 45,),
            RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.all( Radius.circular(28)),
              ),
              padding: isloading?EdgeInsets.symmetric(horizontal: 60,vertical: 10):EdgeInsets.symmetric(horizontal: 30,vertical: 10),
              onPressed: (){
                String rightCode= Provider.of<SocketIoDistBloc>(context,listen: false).code;
                rightCode = rightCode.substring(0, rightCode.length - 1);
                if(rightCode!=code){
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Your code is incorrect',style: TextStyle(fontSize: 25),),
                      duration: Duration(seconds: 3),
                      backgroundColor:Colors.red,
                      action: SnackBarAction(
                        label: '',
                        onPressed: () {
                          // Perform some action
                        },
                      ),
                    ),
                  );
                }
                else{
                  setState(() {
                    isloading=true;
                  });
                  print(Provider.of<SocketIoDistBloc>(context,listen: false).statistics);
                  socketDist.emit("statistics-event","get statistics");
                  socketDist.on("statistics-event", (data) {
                    print(data);
                    Provider.of<SocketIoDistBloc>(context,listen: false).setStatistics(data);
                    setState(() {
                      isloading=false;
                    });
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => StatisticsScreen()),
                    );
                  });

                }

              },
              child: isloading?CircularProgressIndicator(
                color: Colors.white,
              ):Text("Confirm",style: TextStyle(letterSpacing: 1,fontWeight: FontWeight.w700,fontSize: 24,color: Colors.white,),),
              color: Color.fromRGBO(1, 113, 75, 1),
            ),

          ],
        ),
      ),
    );
  }
}










