import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mob1/UI/Screens/ProductScreen.dart';
class ProductCard extends StatelessWidget {
  const ProductCard({Key? key, required this.img, required this.name, required this.Price, required this.id}) : super(key: key);
  final int id;
  final String img;
  final String name;
  final int Price;
  @override
  Widget build(BuildContext context) {
    var ScreenWidth=MediaQuery.of(context).size.width;
    var ScreenHeight=MediaQuery.of(context).size.height;
    return  InkWell(

      onTap: (){
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ProductScreen(id: this.id,),
          ),
        );
      },
      child:
         Card(

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 4,
          child: LayoutBuilder(builder: (ctx, constraints) {
            return Column(

              children: [

                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8,left: 8,bottom: 0,right: 8),
                    child: Image.asset('$img',width: double.infinity,fit:BoxFit.contain),
                  ),
                ),

                SizedBox(height: ScreenHeight/180,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4,vertical: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(

                        child: Text('$name',style: TextStyle(color: Color.fromRGBO(1, 113, 75, 1),fontSize: ScreenWidth/35,fontWeight: FontWeight.w800),),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: ScreenHeight/180,bottom:ScreenHeight/150 ),
                        padding: EdgeInsets.symmetric(vertical: ScreenHeight/200,horizontal: ScreenWidth/40),

                        decoration: BoxDecoration(
                            color: Color.fromRGBO(1, 113, 75, 1),
                            borderRadius: BorderRadius.all(Radius.circular(20))
                        ),
                        child: Text('$Price DA',style: TextStyle(fontSize: ScreenWidth/40,fontWeight: FontWeight.w700,color: Colors.white),),
                      ),

                    ],
                  ),
                ),
              ],
            );
          }),

        ),

    );
  }
}
