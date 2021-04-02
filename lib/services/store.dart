import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop/constants.dart';
import 'package:shop/models/product.dart';

class Store {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  addProduct(Product product) {
    _firestore.collection(KProductCollection).add({
      kProductName: product.pName,
      kProductPrice: product.pPrice,
      kProductCategory: product.pCategory,
      kProductDescription: product.pDescription,
      kProductLocation: product.pLocation
    });
  }

  Stream<QuerySnapshot> loadProduct() {
    return _firestore.collection(KProductCollection).snapshots();
  }

  deleteProduct(docmentid) {
    _firestore.collection(KProductCollection).doc(docmentid).delete();
  }

  editProduct(docmentid, Product product) {
    _firestore.collection(KProductCollection).doc(docmentid).update({
      kProductName: product.pName,
      kProductPrice: product.pPrice,
      kProductCategory: product.pCategory,
      kProductDescription: product.pDescription,
      kProductLocation: product.pLocation
    });
  }

  storeOrders(data, List<Product> products) {
    var docref = _firestore.collection(Korders).doc();
    docref.set(data);
    for (var product in products) {
      docref.collection(KOrderDetails).doc().set({
        kProductName: product.pName,
        kProductPrice: product.pPrice,
        kProductLocation: product.pLocation,
        KProductQuantity: product.pQuantity,
        kProductCategory:product.pCategory
      });
    }
  }

   Stream<QuerySnapshot> loadOrders() {
    return _firestore.collection(Korders).snapshots();
  }
  Stream<QuerySnapshot> loadOrderDetails(docId) {
    return _firestore.collection(Korders).doc(docId).collection(KOrderDetails).snapshots();
  }
}
