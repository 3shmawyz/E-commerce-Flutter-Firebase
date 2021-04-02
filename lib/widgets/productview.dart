import 'package:flutter/material.dart';
import 'package:shop/Screens/user/productinfo.dart';
import 'package:shop/models/product.dart';

Widget productView(String cat, List<Product> allproducts) {
  List<Product> products = [];
  products = getProductByCategory(cat, allproducts);
  return GridView.builder(
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, childAspectRatio: .9),
    itemCount: products.length,
    itemBuilder: (context, index) {
      return Padding(
        padding: const EdgeInsets.all(10),
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, ProductInfo.id, arguments: products[index]);
          },
          child: Stack(
            children: [
              Positioned.fill(
                  child: Image.network(
                      'https://via.placeholder.com/300/09f/fff.png',
                      fit: BoxFit.fill)),
              Positioned(
                  bottom: 0,
                  child: Opacity(
                    opacity: .4,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      color: Colors.white,
                      height: 60,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              products[index].pName,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text("\$${products[index].pPrice}"),
                          ],
                        ),
                      ),
                    ),
                  ))
            ],
          ),
        ),
      );
    },
  );
}

List<Product> getProductByCategory(String cat, List<Product> allproducts) {
  List<Product> products = [];
  try {
    for (var product in allproducts) {
      if (product.pCategory == cat) {
        products.add(product);
      }
    }
  } on Error catch (e) {
    print(e);
  }
  return products;
}
