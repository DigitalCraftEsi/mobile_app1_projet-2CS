

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mob1/Bloc/AddsBloc.dart';
import 'package:mob1/Bloc/BuyedProducts.dart';
import 'package:mob1/Bloc/Drinks.dart';
import 'package:mob1/Bloc/QrCodeBloc.dart';
import 'package:mob1/Bloc/SocketIoBloc.dart';
import 'package:mob1/Bloc/SocketIoDistBloc.dart';
import 'package:mob1/Data/Services/DrinksService.dart';
import 'package:mob1/UI/Screens/BuyingScreen.dart';
import 'package:mob1/UI/Screens/DrinkDoneScreen.dart';
import 'package:mob1/UI/Screens/PaymentDoneScreen.dart';
import 'package:mob1/UI/Screens/StatisticsScreen.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'Data/Models/Drink.dart';
import 'UI/Screens/EnterCodeScreen.dart';
import 'UI/Screens/PaymentScreen.dart';
import 'UI/Screens/ProductScreen.dart';
import 'UI/widjets/ProductCard.dart';
import 'package:flutter/services.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
void main() {
  runApp(MultiProvider(child:MyApp(),
    providers: [
      ChangeNotifierProvider<SocketIoBloc>.value(value: SocketIoBloc()..connectToMachine()),
      ChangeNotifierProvider<SocketIoDistBloc>.value(value: SocketIoDistBloc()..connectToMachine()),
      ChangeNotifierProvider<BuyedProducts>.value(value: BuyedProducts()),
      ChangeNotifierProvider<Drinks>.value(value: Drinks()),
      ChangeNotifierProvider<QrCodeBloc>.value(value: QrCodeBloc()),
      ChangeNotifierProvider<AddsBloc>.value(value: AddsBloc()),
    ],
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: 'mob1',
      theme: ThemeData(fontFamily: 'Poppins'),
      home: MyHomePage(),

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
  PageController controller=PageController(initialPage: 0,

  );
  bool isloading=true;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("1");
    IO.Socket socketDist= Provider.of<SocketIoDistBloc>(context,listen: false).socket;
    socketDist.on("code_event",(data) {
      print("code $data");
      Provider.of<SocketIoDistBloc>(context,listen: false).setCode(data);
    } );
    IO.Socket socket= Provider.of<SocketIoBloc>(context,listen: false).socket;
    socket.on('idDistributeur', (data) {
      print('received message: $data');
      Provider.of<SocketIoBloc>(context,listen: false).setIdDistributeur(int.parse("${data["idDistributeur"]}"));
     int distUid=Provider.of<SocketIoBloc>(context,listen: false).uid;
      Provider.of<Drinks>(context,listen: false).LoadDrinks("$distUid").then((value){
        setState(() {
          isloading=false;
        });
      });
    });
    Provider.of<SocketIoBloc>(context,listen: false).onError();
    print("4");
    /*Provider.of<Drinks>(context,listen: false).LoadDrinks().then((value){
      setState(() {
       isloading=false;
      });
    });*/



  }
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  int currentCard=0;


  @override
  Widget build(BuildContext context) {
    List<Drink> ListDrinks=Provider.of<Drinks>(context,listen: false).list;
   var screenWidth=MediaQuery.of(context).size.width;
   var screenHeight=MediaQuery.of(context).size.height;
    int chunkSize = 6;
    List<List<Drink>> chunks = [];

    for (var i = 0; i < ListDrinks.length; i += chunkSize) {
      int endIndex = i + chunkSize;
      if (endIndex > ListDrinks.length) {
        endIndex = ListDrinks.length;
      }
      chunks.add(ListDrinks.sublist(i, endIndex));
    }
    List<Widget> _listOfCards=List.generate(chunks.length, (index) => Container(
      padding: EdgeInsets.symmetric(vertical: 0,horizontal: screenWidth/30),

      child: GridView(


        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: chunks[index].map((e) => ProductCard(id: e.IdBoisson,img: 'lib/UI/assets/images/cappochino.png', name: e.nomBoisson, Price: e.tarif)).toList(),
        padding: EdgeInsets.symmetric(
            horizontal: screenWidth/9, vertical: screenHeight/37),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(

          crossAxisCount: 3,
          childAspectRatio: 0.75,
          crossAxisSpacing: 5,
          mainAxisSpacing: 10,
        ),
      ),
    ));


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
              MaterialPageRoute(builder: (context) => EnterCodeScreen()),
            );
          }, icon: Icon(Icons.settings,color: Colors.white,size: 34,)),
          SizedBox(width: 30,),
        ],
      ),
      body: isloading?Center(
          child: CircularProgressIndicator(
            color: Color.fromRGBO(1, 113, 75, 1),
            strokeWidth: 6,
          )):Column(
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
            height: 600,

            child: PageView(

              children:
              _listOfCards,
              scrollDirection: Axis.horizontal,
              controller: controller,
              onPageChanged: (int num){
                setState(() {
                  currentCard=num;

                }

                );
              },
            ),
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_listOfCards.length, (index) => Container(
                margin: EdgeInsets.symmetric(horizontal: 3),
                width: index==currentCard?10:8,
                height: index==currentCard?10:8,
                decoration: BoxDecoration(
                    color: index==currentCard?Color.fromRGBO(1, 113, 75, 1):Colors.grey,
                    borderRadius: BorderRadius.all(Radius.circular(200))
                ),
              )),



            ),
          ),

           InkWell(
             onTap: (){
               Navigator.pushReplacement(
                 context,
                 MaterialPageRoute(builder: (context) => BuyingScreen()),
               );
               print(ListDrinks);
               print(chunks);
             },
             child: Stack(
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
           ),





        ],
      ),

    );
  }
}
