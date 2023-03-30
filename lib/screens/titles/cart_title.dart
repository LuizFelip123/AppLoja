import 'package:app_loja/datas/cart_product.dart';
import 'package:app_loja/datas/products_data.dart';
import 'package:app_loja/models/cart_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CartTile extends StatelessWidget {
  final CartProduct cartProduct;
  CartTile(this.cartProduct);
  Widget _buildContent(BuildContext context) {
    CartModel.of(context).updatePrice();
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          height: 120.0,
          padding: EdgeInsets.all(8.0),
          child: Image.network(cartProduct.productsData!.images![0],
              fit: BoxFit.cover),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  cartProduct.productsData!.title!,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 17.0,
                  ),
                ),
                Text(
                  "Tamanho: ${cartProduct.size}",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  "R\$ ${cartProduct.productsData!.price!.toStringAsFixed(2)}",
                  style: TextStyle(
                      color: Color.fromARGB(255, 238, 113, 129),
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      
                      onPressed: cartProduct.quantity! > 1
                          ? () {
                              CartModel.of(context).decProduct(cartProduct);
                            }
                          : null,
                       
                      icon: Icon(Icons.remove),
                      color: Color.fromARGB(255, 238, 113, 129),
                    ),
                    Text(
                      cartProduct.quantity.toString(),
                    ),
                    IconButton(
                      onPressed: () {
                        CartModel.of(context).incProduct(cartProduct);
                      },
                      icon: Icon(Icons.add),
                      color: Color.fromARGB(255, 238, 113, 129),
                    ),
                    TextButton(
                      onPressed: () {
                        CartModel.of(context).removeCartItem(cartProduct);
                      },
                      child: Text(
                        "Remover",
                        style: TextStyle(
                          color: Colors.grey[500],
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: cartProduct.productsData == null
          ? FutureBuilder<DocumentSnapshot>(
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  cartProduct.productsData =
                      ProductsData.fromDocument(snapshot.data!);
                  return _buildContent(context);
                } else {
                  return Container(
                    height: 70,
                    child: CircularProgressIndicator(),
                    alignment: Alignment.center,
                  );
                }
              },
              future: FirebaseFirestore.instance
                  .collection("products")
                  .doc(cartProduct.category)
                  .collection("items")
                  .doc(cartProduct.pid)
                  .get(),
            )
          : _buildContent(context),
    );
  }
}
