
import 'package:flutter/material.dart';
import 'package:shop/constants.dart';
import 'package:shop/models/product.dart';
import 'package:shop/services/store.dart';
import 'package:shop/widgets/customtextfield.dart';

class EditProduct extends StatelessWidget {
  static String id ="EditProducts";
    String _name,_price,_description,_category,_imglocation;
  final GlobalKey<FormState>_globalKey = GlobalKey<FormState>();
  final _store= Store();
  
  @override
  Widget build(BuildContext context) {
    Product product= ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: Container(
         decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: [
                Color(0xFFD9C7AA),
                Color(0xFFD3BD9C),
                Color(0xFFCDB48E),
                kMainColor
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            )),
        child: ListView(
          children:[ 
            Form(
              key: _globalKey,
            child: Column(
               children: [
                 SizedBox(height: MediaQuery.of(context).size.height*.1,),
                 CustomTextField(
                   onClick: (value){
                   _name=value ;
                   },
                   initial: "${product.pName}",
                   icon: Icons.short_text_outlined,
                 ), 
                 CustomTextField(
                     onClick: (value){
                   _price=value ;
                   },
                  initial: "${product.pPrice}",
                   icon: Icons.attach_money,
                 ), 
                 CustomTextField(
                     onClick: (value){
                   _description=value ;
                   },
                  initial: "${product.pDescription}",
                   icon:Icons.description_outlined,
                 ), 
                 CustomTextField(
                     onClick: (value){
                   _category=value ;
                   },
                  initial: "${product.pCategory}",
                   icon: Icons.dehaze_outlined,
                 ), 
                 CustomTextField(
                     onClick: (value){
                   _imglocation=value ;
                   },
                  initial: "${product.pLocation}",
                   icon: Icons.image_outlined,
                 ),
                 RaisedButton(onPressed: ()
                 {
                   if(_globalKey.currentState.validate())
                   {
                     _globalKey.currentState.save();
                      _store.editProduct(product.pId,Product(
                       pName:_name,
                       pPrice: _price,
                       pDescription: _description,
                       pLocation:_imglocation,
                       pCategory: _category 
                       

                      ));
                   }
                   Navigator.of(context).pop();
                 },
                 child: Text("Edit Product"),) 
               ],
            ),
          ),
        ]),
      ),
    );
  }
}