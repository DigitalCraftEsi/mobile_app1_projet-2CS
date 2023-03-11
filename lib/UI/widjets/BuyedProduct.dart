
import 'package:flutter/material.dart';
class BuyedProduct extends StatelessWidget {
  const BuyedProduct({Key? key, required this.name, required this.quantity, required this.Price, required this.image}) : super(key: key);
  final String name;
  final int quantity;
  final int Price;
  final String image;
  @override
  Widget build(BuildContext context) {
    var screenWidth=MediaQuery.of(context).size.width;
    var screenHeight=MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.only(left: screenWidth/60,bottom: 10),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
          child: Row(
            children: [
              Image.asset('$image',width: screenWidth/18,fit:BoxFit.contain),
              SizedBox(width: screenWidth/80,),
              Column(

                children: [
                  Text("$name",style: TextStyle(fontWeight: FontWeight.w800,fontSize: screenWidth/35,color: Color.fromRGBO(1, 113, 75, 1)),),
                  Row(
                    children: [
                      Text("Qty: $quantity",style: TextStyle(fontWeight: FontWeight.w800,fontSize: screenWidth/35,color: Color.fromRGBO(1, 113, 75, 1)),),
                      SizedBox(width: screenWidth/50,),
                      Container(

                        padding: EdgeInsets.symmetric(vertical: screenHeight/700,horizontal: screenWidth/100),

                        decoration: BoxDecoration(
                            color: Color.fromRGBO(1, 113, 75, 1),
                            borderRadius: BorderRadius.all(Radius.circular(20))
                        ),
                        child: Text('$Price DA',style: TextStyle(fontSize: screenWidth/40,fontWeight: FontWeight.w700,color: Colors.white),),
                      ),

                    ],
                  ),
                ],
              ),
              SizedBox(width: screenWidth/60,),
              InkWell(
                onTap: (){},
                child: Container(
                  margin: EdgeInsets.only(left: 7),
                  padding: EdgeInsets.all(1),
                  child: Icon(Icons.close,size: screenWidth/30,color: Colors.white,),
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
