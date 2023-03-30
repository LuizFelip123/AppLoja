import 'package:app_loja/datas/cart_product.dart';
import 'package:app_loja/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class CartModel extends Model {
  final UserModel user;
  bool isLoading = false;
  String? couponCode;
  int discountPorcentage = 0;
  List<CartProduct> products = [];
  CartModel(this.user){
    if(this.user.isLoggedIn()){
      _loadCartItems();
    }
  }
  static CartModel of(BuildContext context) =>
      ScopedModel.of<CartModel>(context);
  void addCartItem(CartProduct cartProduct) {
    products.add(cartProduct);
    FirebaseFirestore.instance
        .collection("users")
        .doc(user.user!.uid)
        .collection("cart")
        .add(cartProduct.toMap())
        .then((value) {
      cartProduct.cid = value.id;
    });
    notifyListeners();
  }

  void removeCartItem(CartProduct cartProduct) {
    FirebaseFirestore.instance
        .collection("users")
        .doc(user.user!.uid)
        .collection("cart")
        .doc(cartProduct.cid)
        .delete();
    products.remove(cartProduct);
    notifyListeners();
  }

  void decProduct(CartProduct cartProduct) {
    cartProduct.quantity = -1;
    FirebaseFirestore.instance
        .collection("users")
        .doc(user.user!.uid)
        .collection("cart")
        .doc(cartProduct.cid)
        .update(cartProduct.toMap());
    notifyListeners();
  }

  void incProduct(CartProduct cartProduct) {
    cartProduct.quantity = cartProduct.quantity! + 1;
    FirebaseFirestore.instance
        .collection("users")
        .doc(user.user!.uid)
        .collection("cart")
        .doc(cartProduct.cid)
        .update(cartProduct.toMap());
    notifyListeners();
  }
  void _loadCartItems()async{
  QuerySnapshot query =  await FirebaseFirestore.instance
        .collection("users")
        .doc(user.user!.uid)
        .collection("cart").get();
        products = query.docs.map((e) => CartProduct.fromDocument(e),).toList();
    notifyListeners();
  }
  void setCoupon(String? couponCode, int discountPorcentage){
    this.couponCode = couponCode;
    this.discountPorcentage = discountPorcentage;
  }
  void updatePrice(){
    notifyListeners();
  }
  double getProductsPrice(){
    double price = 0.0;
   
     for(CartProduct c in products){
      if(c!= null && c.productsData != null){
        price +=  c.quantity! *c.productsData!.price!; 
      }
    
   }
    return price;
  }
  double getDiscount(){
    return getProductsPrice() * discountPorcentage/100;
  }
  double getShipPrice(){
    return 9.99;
  }
  Future<String?> finishOrder()async{
    if(products.length == 0) return null;

    isLoading =true;
    notifyListeners();

    double  productsPrice = getProductsPrice();
    double shipPrice = getShipPrice();
    double discount = getDiscount();

   DocumentReference refOrder = await FirebaseFirestore.instance.collection("orders").add({
       "clientId": user.user!.uid,
       "products": products.map((e) => e.toMap()).toList(),
       "ship": shipPrice,
       "productsPrice": productsPrice,
       "discount":discount,
       "totalPrice": productsPrice - discount+ shipPrice,
       "status": 1  
    });  
   FirebaseFirestore.instance.collection("users").doc(user.user!.uid).collection("orders").doc(refOrder.id).set(
    {
      "orderId": refOrder.id
    }
   ); 
    QuerySnapshot query = await FirebaseFirestore.instance.collection("users").doc(user.user!.uid).collection("cart").get();
    for (DocumentSnapshot doc   in query.docs) {
      doc.reference.delete();
    }
    products.clear();
    discount = 0;
    couponCode = null;
    isLoading = false;

    notifyListeners();

    return refOrder.id;
  }

}
