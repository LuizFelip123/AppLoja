
import 'package:app_loja/datas/products_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CartProduct {
  String? cid;
  String? category;

  String? pid;
  int? quantity;
  String? size;

  ProductsData? productsData;
  CartProduct();
  CartProduct.fromDocument(DocumentSnapshot document) {
    cid = document.id;
    category = document['category'];
    pid = document['pid'];
    quantity = document['quantity'];
    size = document['size'];
  }
  Map<String, dynamic> toMap() {
    return {
      'category': category,
      'pid': pid,
      'quantity':quantity,
      'size': size,
     'product': productsData!.toResumedMap(),
    };
  }

}
