import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shop/Screens/admin/editproduct.dart';
import 'package:shop/models/product.dart';
import 'package:shop/services/store.dart';
import 'package:shop/widgets/custommenu.dart';

import '../../constants.dart';

class ManageProduct extends StatefulWidget {
  static String id = "ManageProduct";

  @override
  _ManageProductState createState() => _ManageProductState();
}

class _ManageProductState extends State<ManageProduct> {
  final _store = Store();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
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
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
                childAspectRatio: .9), 
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: GestureDetector(
                      onTapUp: (details)async {
                   double dx=details.globalPosition.dx;
                   double dy=details.globalPosition.dy; 
                   double dx2=MediaQuery.of(context).size.width - dx;  
                   double dy2=MediaQuery.of(context).size.width - dy;  
                 await showMenu(context: context, position:RelativeRect.fromLTRB(dx,dy,dx2,dy2),items: [
                      MyPopupMenuItem(onClick: (){
                       Navigator.pushNamed(context,EditProduct.id,arguments: products[index]);
                      }, 
                      child: Text("edit"),),
                      MyPopupMenuItem(onClick: (){
                        _store.deleteProduct(products[index].pId);
                             Navigator.pop(context);

                      },
                      child: Text("delete"),),

                  ]);
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
          }),
    );
  }
}


