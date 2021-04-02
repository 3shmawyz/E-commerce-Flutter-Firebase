import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shop/constants.dart';
import 'package:shop/models/product.dart';
import 'package:shop/services/store.dart';

class OrderDetails extends StatelessWidget {
  static String id = 'OrderDetails';
  @override
  Widget build(BuildContext context) {
    String docId = ModalRoute.of(context).settings.arguments;
    Store _store = Store();
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: _store.loadOrderDetails(docId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Product> products = [];
            for (var doc in snapshot.data.docs) {
              products.add(Product(
                  pName: doc.data()[kProductName],
                  pQuantity: doc.data()[KProductQuantity],
                  pCategory: doc.data()[kProductCategory]));
            }
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: products.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.2,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Name is ${products[index].pName}",
                                  style: TextStyle(
                                      fontSize: 18, fontWeight: FontWeight.bold)),
                              SizedBox(height: 10),
                              Text(
                                "Quantity is ${products[index].pQuantity}",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Text("Category ${products[index].pCategory}",
                                  style: TextStyle(
                                      fontSize: 18, fontWeight: FontWeight.bold)),
                              SizedBox(height: 10),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:  10, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: ButtonTheme(
                          buttonColor: Colors.grey,
                          child: RaisedButton(
                            onPressed: () {},
                            child: Text("Confirm Order"),
                          ),
                        ),
                      ),
        
                      Expanded(
                        child: ButtonTheme(
                          buttonColor: Colors.grey,
                          child: RaisedButton(
                            onPressed: () {},
                            child: Text("Delete Order"),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            );
          } else {
            return Center(
              child: Text("Orders IS Loadding ..."),
            );
          }
        },
      ),
    );
  }
}
