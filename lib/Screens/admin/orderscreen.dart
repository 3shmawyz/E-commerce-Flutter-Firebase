import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shop/Screens/admin/orderdetails.dart';
import 'package:shop/constants.dart';
import 'package:shop/models/order.dart';
import 'package:shop/services/store.dart';


class OrderScreen extends StatelessWidget {
  Store _store = Store();
  static String id = "OrderScreen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: _store.loadOrders(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Text('No orders Yet'),
            );
          } else {
            List<Order> _orders = [];
            for (var doc in snapshot.data.docs) {
              _orders.add(Order(
                  docId: doc.id,
                  address: doc.data()[KAddress],
                  totalPrice: doc.data()[KTotalPrice]));
            }
            return ListView.builder(
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: GestureDetector(
                    onTap: ()
                    {
                      Navigator.pushNamed(context,OrderDetails.id,arguments:_orders[index].docId );
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.2,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Total Price = \$ ${_orders[index].totalPrice}",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                                    SizedBox(height: 10),
                            Text(
                              "Address is ${_orders[index].address}",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
              itemCount: _orders.length,
            );
          }
        },
      ),
    );
  }
}
