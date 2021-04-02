import 'package:firebase_auth/firebase_auth.dart';

class Product {
  String pName;
  String pPrice;
  String pDescription;
  String pCategory;
  String pLocation;
  String pId;
  int pQuantity;

  Product(
      {this.pName,
      this.pPrice,
      this.pCategory,
      this.pDescription,
      this.pLocation,
      this.pId,
      this.pQuantity});
}

class Users{
  String email;
  String password;
  bool admin =false;

  Users(
    {this.email,
    this.password,
    this.admin});
}
