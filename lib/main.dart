

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mob1/UI/Screens/DrinkDoneScreen.dart';
import 'package:mob1/UI/Screens/PaymentDoneScreen.dart';

import 'Bloc/SugarQuantityBloc.dart';
import 'UI/Screens/PaymentScreen.dart';
import 'UI/Screens/ProductScreen.dart';
import 'UI/widjets/ProductCard.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'mob1',
      theme: ThemeData(fontFamily: 'Poppins'),
      home:BlocProvider(
      create: (BuildContext context) =>SugarQuantityBloc(),
    child:ProductScreen(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);




  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {
   var screenWidth=MediaQuery.of(context).size.width;
   var screenHeight=MediaQuery.of(context).size.height;
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(1, 113, 75, 1),
        actions: [
          Container(
            margin: EdgeInsets.only(right: screenWidth/14),
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
        ],
      ),
      body: Column(
         crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(

            margin: EdgeInsets.only(left: 30,right: 30,bottom: 0,top: 30 ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              boxShadow:  [
                BoxShadow(
                  color: Color.fromRGBO(26, 27, 28,0.5),
                  blurRadius: 5,
                ),
                BoxShadow(
                  color: Color.fromRGBO(26, 27, 28, 0.3),
                  blurRadius: 15,
                ),
              ],
                ),
          child:
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child:Image.asset('lib/UI/assets/images/Acceil.png',),
    )
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 0,horizontal: screenWidth/30),

            child: GridView(


              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children:[
                ProductCard(img: 'lib/UI/assets/images/cappochino.png', name: 'Cappuccino', Price: 60),
                ProductCard(img: 'lib/UI/assets/images/cappochino.png', name: 'Cappuccino', Price: 60),
                ProductCard(img: 'lib/UI/assets/images/cappochino.png', name: 'Cappuccino', Price: 60),
                ProductCard(img: 'lib/UI/assets/images/cappochino.png', name: 'Cappuccino', Price: 60),
                ProductCard(img: 'lib/UI/assets/images/cappochino.png', name: 'Cappuccino', Price: 60),
                ProductCard(img: 'lib/UI/assets/images/cappochino.png', name: 'Cappuccino', Price: 60),

              ],
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth/9, vertical: screenHeight/37),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(

                crossAxisCount: 3,
                childAspectRatio: 0.75,
                crossAxisSpacing: 5,
                mainAxisSpacing: 10,
              ),
            ),
          ),
           Stack(
             alignment: Alignment.bottomCenter,
             children:[
               Container(

                   height: screenHeight/10,
                   width: double.infinity,
                   color: Color.fromRGBO(1, 113, 75, 1),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       Image.asset('lib/UI/assets/images/Touch.png'),
                       SizedBox(
                         width: screenWidth/40,
                       ),
                       Text("TOUCH ANYWHERE TO START",style: TextStyle(fontWeight: FontWeight.w800,fontSize: screenWidth/25,color: Colors.white),)
                     ],
                   )

               ),
             ],
           ),





        ],
      ),

    );
  }
}
