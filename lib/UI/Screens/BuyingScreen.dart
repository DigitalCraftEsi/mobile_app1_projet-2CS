
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mob1/Bloc/BuyedProducts.dart';
import 'package:mob1/Bloc/Drinks.dart';
import 'package:mob1/Bloc/QrCodeBloc.dart';
import 'package:mob1/Bloc/SocketIoBloc.dart';
import 'package:mob1/Data/Models/Drink.dart';
import 'package:mob1/UI/Screens/PaymentScreen.dart';
import 'package:mob1/UI/widjets/BuyedProduct.dart';
import 'package:mob1/UI/widjets/ProductCard.dart';
import 'package:provider/provider.dart';

import '../../main.dart';


class BuyingScreen extends StatefulWidget {
  const BuyingScreen({Key? key}) : super(key: key);

  @override
  _BuyingScreenState createState() => _BuyingScreenState();
}

class _BuyingScreenState extends State<BuyingScreen> {

  PageController controller=PageController(initialPage: 0,

  );
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  int currentCard=0;
  @override
  Widget build(BuildContext context) {
    List<Drink> ListDrinks=Provider.of<Drinks>(context,listen: true).list;
    List<Product> buyedProductsList= Provider.of<BuyedProducts>(context,listen: true).list;
     double Total=0;
     buyedProductsList.forEach((element) {
       Drink  _drink=Provider.of<Drinks>(context,listen: true).getDrink(element.idBoisson);
       Total=Total+element.quantity*_drink.tarif;
     });
    var screenWidth=MediaQuery.of(context).size.width;
    var screenHeight=MediaQuery.of(context).size.height;
    int chunkSize = 9;
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
        children: chunks[index].map((e) => ProductCard(id:e.IdBoisson,img: 'lib/UI/assets/images/cappochino.png', name: e.nomBoisson, Price: e.tarif)).toList(),
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

    return SafeArea(
      child: Scaffold(
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
      body: SafeArea(
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [


          Container(
            height: 810,

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

          Stack(
            alignment: Alignment.bottomCenter,
            children:[
              Container(

                  height: screenHeight/4.35,
                  width: double.infinity,
                  color: Color.fromRGBO(1, 113, 75, 1),
                  child: Column(

                    children: [
                      Padding(
                        padding:  EdgeInsets.symmetric(vertical: screenHeight/73,horizontal: screenWidth/15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text("YOUR CART",style: TextStyle(fontWeight: FontWeight.w800,fontSize: screenWidth/23,color: Colors.white),),
                              SizedBox(width: screenWidth/60,),
                              Icon(Icons.add_shopping_cart,color: Colors.white,),
                              ],
                            ),
                            Row(
                              children: [
                                Text("TOTAL : ${Total.toInt()} DA",style: TextStyle(fontWeight: FontWeight.w800,fontSize: screenWidth/23,color: Colors.white),),

                              ],
                            ),
                          ],
                        ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                           mainAxisAlignment: MainAxisAlignment.start,
                         children: buyedProductsList.map((Product product) {
                           Drink  _drink=Provider.of<Drinks>(context,listen: true).getDrink(product.idBoisson);
                           return BuyedProduct(idBoisson: _drink.IdBoisson,name: _drink.nomBoisson, quantity: product.quantity, Price: _drink.tarif, image:"lib/UI/assets/images/cappochino.png" );
                         }).toList(),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.only(topLeft: Radius.circular(0),topRight: Radius.circular(15),bottomLeft: Radius.circular(0),bottomRight: Radius.circular(15)),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: screenWidth/16,vertical: screenHeight/100),
                            onPressed: (){
                              Provider.of<BuyedProducts>(context,listen: false).initialise_List();
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => MyHomePage()),
                              );
                            },
                            child: Text("CANCEL",style: TextStyle(letterSpacing: 1,fontWeight: FontWeight.w800,fontSize: screenWidth/24,color: Color.fromRGBO(1, 113, 75, 1)),),
                            color: Colors.white,
                          ),
                          RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(0),bottomLeft: Radius.circular(15),bottomRight: Radius.circular(0)),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: screenWidth/20,vertical: screenHeight/100),
                            onPressed: (){
                              int idDistributeur=Provider.of<SocketIoBloc>(context,listen: false).idDistributeur;
                              Provider.of<QrCodeBloc>(context,listen: false).EncodeData(buyedProductsList,idDistributeur,Total.toInt());
                              String _dataEncoded=Provider.of<QrCodeBloc>(context,listen: false).Dataencoded;
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => PaymentScreen(dataEncoded: _dataEncoded,)),
                              );
                            },
                            child: Text("PAY NOW",style: TextStyle(letterSpacing: 1,fontWeight: FontWeight.w800,fontSize: screenWidth/24,color: Color.fromRGBO(1, 113, 75, 1)),),
                            color: Colors.white,
                          ),
                        ],
                      ),

                    ],
                  )

              ),
            ],
          ),

        ],
        ),
      )
      ),
    );
  }
}
