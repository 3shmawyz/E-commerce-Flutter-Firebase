import 'package:flutter/material.dart';
import 'package:shop/constants.dart';
import 'package:shop/models/product.dart';
import 'package:shop/widgets/customtextfield.dart';
import 'package:shop/services/store.dart';

class AddProduct extends StatelessWidget {
  static String id ="AddProduct";
  String _name,_price,_description,_category,_imglocation;
  final GlobalKey<FormState>_globalKey = GlobalKey<FormState>();
  final _store= Store();
  @override
  Widget build(BuildContext context) {
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
              mainAxisAlignment:MainAxisAlignment.center,
               children: [
                 CustomTextField(
                   onClick: (value){
                   _name=value ;
                   },
                   hint: "Product Name",
                   icon: Icons.short_text_outlined
                 ), 
                 CustomTextField(
                     onClick: (value){
                   _price=value ;
                   },
                   hint: "Product Price",
                   icon: Icons.attach_money,
                 ), 
                 CustomTextField(
                     onClick: (value){
                   _description=value ;
                   },
                   hint: "Product Description",
                   icon:Icons.description_outlined,
                 ), 
                 CustomTextField(
                     onClick: (value){
                   _category=value ;
                   },
                   hint: "Product Category",
                   icon: Icons.dehaze_outlined,
                 ), 
                 CustomTextField(
                     onClick: (value){
                   _imglocation=value ;
                   },
                   hint: "upload Image",
                   icon: Icons.image_outlined,
                 ),
                 RaisedButton(onPressed: ()
                 {
                   if(_globalKey.currentState.validate())
                   {
                     _globalKey.currentState.save();
                     _store.addProduct(Product(
                       pName:_name,
                       pPrice: _price,
                       pDescription: _description,
                       pLocation:_imglocation,
                       pCategory: _category 
                     ));
                     _globalKey.currentState.reset();
                   }
                 },
                 child: Text("Add Product"),) 
               ],
            ),
          ),
        ]),
      ),
    );
  }
}