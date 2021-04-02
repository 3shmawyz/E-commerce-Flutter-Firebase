import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop/Screens/LoginScreen.dart';
import 'package:shop/Screens/admin/addproduct.dart';
import 'package:shop/Screens/admin/adminhome.dart';
import 'package:shop/Screens/admin/editproduct.dart';
import 'package:shop/Screens/admin/manageproduct.dart';
import 'package:shop/Screens/admin/orderdetails.dart';
import 'package:shop/Screens/admin/orderscreen.dart';
import 'package:shop/Screens/user/cartscreen.dart';
import 'package:shop/Screens/user/homescreen.dart';
import 'package:shop/Screens/signupscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shop/Screens/user/productinfo.dart';
import 'package:shop/provider/adminmode.dart';
import 'package:shop/provider/cartitem.dart';
import 'package:shop/provider/modelhud.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  bool isUserLoggedIn = false;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
      return FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder: (context,snapshot){
        if(!snapshot.hasData)
        {
          return MaterialApp(
            home:Scaffold(body: Center(child: Text("Loadding"),),)
          );
        }else 
        {
          isUserLoggedIn = snapshot.data.getBool("keepMeLoggedIn") ?? false ;
          return MultiProvider(
      providers: [
        ChangeNotifierProvider<ModelHud>( 
          create: (context) => ModelHud(),
        ),
         ChangeNotifierProvider<CartItem>(
          create: (context) => CartItem(),
        ),
        ChangeNotifierProvider<AdminMode>(
          create: (context) => AdminMode(),
        
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute:isUserLoggedIn ? Home.id  :  LoginScreen.id,
        routes: {
          LoginScreen.id: (context) => LoginScreen(),
          SingupScreen.id: (context) => SingupScreen(),
          Home.id: (context) => Home(),
          AdminHome.id: (context) => AdminHome(),
          AddProduct.id: (context) => AddProduct(),
          ManageProduct.id:(context)=> ManageProduct(),
          EditProduct.id:(context)=> EditProduct(),
          ProductInfo.id:(context)=> ProductInfo(),
           CartScreen.id:(context)=> CartScreen(),
           OrderScreen.id:(context)=> OrderScreen(),
           OrderDetails.id:(context)=> OrderDetails()

        },
      ),
    );
        }
      }
      
    );

  }
}







    