
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mob1/UI/widjets/BuyedProduct.dart';
import 'package:mob1/UI/widjets/ProductCard.dart';


class BuyingScreen extends StatefulWidget {
  const BuyingScreen({Key? key}) : super(key: key);

  @override
  _BuyingScreenState createState() => _BuyingScreenState();
}

class _BuyingScreenState extends State<BuyingScreen> {
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
    int total=120;
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
              padding: EdgeInsets.symmetric(vertical: 0,horizontal: screenWidth/30),

              child: GridView(


                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children:[
                  ProductCard(img: 'lib/assets/images/cappochino.png', name: 'Cappuccino', Price: 60),
                  ProductCard(img: 'lib/assets/images/cappochino.png', name: 'Cappuccino', Price: 60),
                  ProductCard(img: 'lib/assets/images/cappochino.png', name: 'Cappuccino', Price: 60),
                  ProductCard(img: 'lib/assets/images/cappochino.png', name: 'Cappuccino', Price: 60),
                  ProductCard(img: 'lib/assets/images/cappochino.png', name: 'Cappuccino', Price: 60),
                  ProductCard(img: 'lib/assets/images/cappochino.png', name: 'Cappuccino', Price: 60),
                  ProductCard(img: 'lib/assets/images/cappochino.png', name: 'Cappuccino', Price: 60),
                  ProductCard(img: 'lib/assets/images/cappochino.png', name: 'Cappuccino', Price: 60),
                  ProductCard(img: 'lib/assets/images/cappochino.png', name: 'Cappuccino', Price: 60),
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
                                Text("TOTAL : $total DA",style: TextStyle(fontWeight: FontWeight.w800,fontSize: screenWidth/23,color: Colors.white),),

                              ],
                            ),
                          ],
                        ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                           mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            BuyedProduct(name: "Cappuchino", quantity: 1, Price: 60, image: "lib/UI/assets/images/cappochino.png"),
                            BuyedProduct(name: "Cappuchino", quantity: 1, Price: 60, image: "lib/UI/assets/images/cappochino.png"),
                            BuyedProduct(name: "Cappuchino", quantity: 1, Price: 60, image: "lib/UI/assets/images/cappochino.png"),



                            ],
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
                            onPressed: (){},
                            child: Text("CANCEL",style: TextStyle(letterSpacing: 1,fontWeight: FontWeight.w800,fontSize: screenWidth/24,color: Color.fromRGBO(1, 113, 75, 1)),),
                            color: Colors.white,
                          ),
                          RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(0),bottomLeft: Radius.circular(15),bottomRight: Radius.circular(0)),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: screenWidth/20,vertical: screenHeight/100),
                            onPressed: (){
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
