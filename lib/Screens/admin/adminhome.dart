import 'package:flutter/material.dart';
import 'package:shop/Screens/admin/addproduct.dart';
import 'package:shop/Screens/admin/manageproduct.dart';
import 'package:shop/Screens/admin/orderscreen.dart';
import 'package:shop/constants.dart';

class AdminHome extends StatelessWidget {
  static String id = "Admin Screen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor:kMainColor,
       body:Column(
        mainAxisAlignment:MainAxisAlignment.center,
        crossAxisAlignment:CrossAxisAlignment.center,

         children: [
         SizedBox(width: double.infinity),
         RaisedButton(onPressed:(){
           Navigator.pushNamed(context,AddProduct.id);
         } ,
         child:Text("Add Product") ,),
         RaisedButton(onPressed:(){
           Navigator.pushNamed(context,ManageProduct.id);
         } ,
         child:Text("Edit Product") ,),
         RaisedButton(onPressed:(){
           Navigator.pushNamed(context,OrderScreen.id);
         } ,
         child:Text("View Orders") ,),
         
       ],)
    );
  }
}