import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/Screens/user/productinfo.dart';
import 'package:shop/constants.dart';
import 'package:shop/models/product.dart';
import 'package:shop/provider/cartitem.dart';
import 'package:shop/services/store.dart';
import 'package:shop/widgets/custommenu.dart';

class CartScreen extends StatelessWidget {
  static String id = "CartScreen";
  @override
  Widget build(BuildContext context) {
    List<Product> products = Provider.of<CartItem>(context).products;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double appBarHeight = AppBar().preferredSize.height;
    final double statsbar = MediaQuery.of(context).padding.top;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text(
          "Cart",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
      ),
      body: Column(
        children: [
          LayoutBuilder(builder: (context, constrains) {
            if (products.isNotEmpty) {
              return Container(
                height: screenHeight -
                    (statsbar + appBarHeight + (screenHeight * 0.08)),
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(12),
                      child: GestureDetector(
                        onTapUp: (details) {
                          showCustomMenu(details, context, products[index]);
                        },
                        child: Container(
                          height: screenHeight * .15,
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: screenHeight * .15 / 2,
                                backgroundImage: NetworkImage(
                                    "https://via.placeholder.com/300/09f/fff.png"),
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 10.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            products[index].pName,
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            '\$ ${products[index].pPrice}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(right: 20),
                                      child: Text(
                                        products[index].pQuantity.toString(),
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: products.length,
                ),
              );
            } else {
              return Container(
                  height: screenHeight -
                      ((screenHeight * 0.08) + statsbar + appBarHeight),
                  child: Center(
                    child: Text("Cart is empty"),
                  ));
            }
          }),
          Builder(
            builder :(context) => ButtonTheme(
              minWidth: screenWidth,
              height: screenHeight * 0.08,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(12),
                    topLeft: Radius.circular(12),
                  ),
                ),
                onPressed: () {
                  showCustomDialog(products, context);
                },
                child: Text('Order'.toUpperCase()),
              ),
            ),
          )
        ],
      ),
    );
  }

  void showCustomMenu(details, context, product) async {
    double dx = details.globalPosition.dx;
    double dy = details.globalPosition.dy;
    double dx2 = MediaQuery.of(context).size.width - dx;
    double dy2 = MediaQuery.of(context).size.width - dy;
    await showMenu(
        context: context,
        position: RelativeRect.fromLTRB(dx, dy, dx2, dy2),
        items: [
          MyPopupMenuItem(
            onClick: () {
              Navigator.pop(context);
              Provider.of<CartItem>(context, listen: false)
                  .deleteProduct(product);
              Navigator.pushNamed(context, ProductInfo.id, arguments: product);
            },
            child: Text("edit"),
          ),
          MyPopupMenuItem(
            onClick: () {
              Navigator.pop(context);
              Provider.of<CartItem>(context, listen: false)
                  .deleteProduct(product);
            },
            child: Text("delete"),
          ),
        ]);
  }

  void showCustomDialog(List<Product> products, context) async {
    var address;
    var price = getTotallPrice(products);
    AlertDialog alertDialog = AlertDialog(
      actions: <Widget>[
        MaterialButton(
          onPressed: () {
            try {
            Store _store = Store();
            _store
                .storeOrders({KTotalPrice: price, KAddress: address}, products);
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text("Order send"),
                ),);
                Navigator.pop(context);
            }catch(e){
              print(e.message);
            }
          },
          
          child: Text('Confirm'),
        )
      ],
      content: TextField(
        onChanged: (value) {
          address = value;
        },
        decoration: InputDecoration(hintText: 'Enter your Address'),
      ),
      title: Text('Totall Price  = \$ $price'),
    );
    await showDialog(
        context: context,
        builder: (context) {
          return alertDialog;
        });
  }

  getTotallPrice(List<Product> products) {
    var price = 0;
    for (var product in products) {
      price += product.pQuantity * int.parse(product.pPrice);
    }
    return price;
  }
}
