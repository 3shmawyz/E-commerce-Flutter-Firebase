import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop/Screens/loginscreen.dart';
import 'package:shop/Screens/user/cartscreen.dart';
import 'package:shop/Screens/user/productinfo.dart';
import 'package:shop/constants.dart';
import 'package:shop/models/product.dart';
import 'package:shop/services/auth.dart';
import 'package:shop/services/store.dart';
import 'package:shop/widgets/productview.dart';

class Home extends StatefulWidget {
    static String id ="Home" ;

  @override
  _HomeState createState() => _HomeState();
  
}

class _HomeState extends State<Home> {
  final _store = Store();
  final _auth = Auth();
  User _loggedUser;
  int _tabIndex = 0;
  int _bottmIndex = 0;
  List <Product> _products;
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children:[
          DefaultTabController(
            length: 4,
            child: Scaffold(
              bottomNavigationBar: BottomNavigationBar(
                type:BottomNavigationBarType.fixed,
                currentIndex: _bottmIndex,
                selectedItemColor: Colors.black,
                onTap: (value) async{
                 if (value == 2) 
                 {
                SharedPreferences pref = await SharedPreferences.getInstance();
                pref.clear();
                await _auth.signOut();
                Navigator.popAndPushNamed(context,LoginScreen.id);
                 } 
               setState(() {
                _bottmIndex = value;                                
                              });
                },
                items: [
                BottomNavigationBarItem(icon:Icon(Icons.person,),label:"test"),
                BottomNavigationBarItem(icon:Icon(Icons.person),label:"test"),
                BottomNavigationBarItem(icon:Icon(Icons.logout),label:"Sign Out"),

              ],),
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 1,
                bottom:TabBar(
                  indicatorColor:Colors.black ,
                  onTap: (value){
                    setState(() {
                     _tabIndex=value;                   
                                      });
                  },
                  tabs: [
                  Text("Type1",
                  style:TextStyle(color: _tabIndex == 0 ? Colors.black : Colors.grey,
                  fontSize: _tabIndex == 0 ? 16 :null)),
                  Text("Type2",
                   style:TextStyle(color: _tabIndex == 1 ? Colors.black :Colors.grey,
                  fontSize: _tabIndex == 1 ? 16 :null)),
                  Text("Type3",
                   style:TextStyle(color: _tabIndex == 2 ? Colors.black :Colors.grey,
                  fontSize: _tabIndex == 2 ? 16 :null)),
                  Text("Type4",
                   style:TextStyle(color: _tabIndex == 3 ? Colors.black :Colors.grey,
                  fontSize: _tabIndex == 3 ? 16 :null)),
                ],) ,),
              body: TabBarView(
                children: [
                  summer(),
                  productView(Kwinter,_products),
                  productView(Kbags,_products),
                  productView(Kkids,_products),
                                  ],
              ),
            ),
            
          ),
          Container(
          height: MediaQuery.of(context).size.height * .1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:[ Text("D&S",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
          GestureDetector(
            onTap: (){
              Navigator.pushNamed(context,CartScreen.id);
            },
            child: Icon(Icons.shopping_cart_outlined))]),
          )
        ]
        
      ),
    );
  }

 Widget summer() {
   return StreamBuilder<QuerySnapshot>(
          stream: _store.loadProduct(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
            List<Product> products = [];
              for (var doc in snapshot.data.docs) {
                products.add(Product(
                    pId: doc.id,
                    pName: doc.data()[kProductName],
                    pCategory: doc.data()[kProductCategory],
                    pDescription: doc.data()[kProductDescription],
                    pLocation: doc.data()[kProductLocation],
                    pPrice: doc.data()[kProductPrice]));
               }
              _products = [...products];
              products.clear();
              products = getProductByCategory(KSummer,_products);
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
                childAspectRatio: .9), 
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: GestureDetector(
                      onTap: (){
            Navigator.pushNamed(context, ProductInfo.id, arguments: products[index]);
                      },
                      child: Stack(
                        children: [
                          Positioned.fill(child: Image.network('https://via.placeholder.com/300/09f/fff.png',fit:BoxFit.fill)),
                          Positioned(
                            bottom: 0,
                            child: Opacity(
                              opacity: .4,
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                color: Colors.white,height: 60,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(products[index].pName,style: TextStyle(fontWeight: FontWeight.bold),),
                                      Text("\$${products[index].pPrice}"),
                                    ],
                                  ),
                                ),),
                            ))
                        ],
                      ),
                    ),
                  );
                },
              );
            } else {
              return CircularProgressIndicator();
            }
          }
          );
 }

}