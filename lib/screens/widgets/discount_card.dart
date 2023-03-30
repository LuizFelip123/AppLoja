import 'package:app_loja/models/cart_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DiscountCard extends StatelessWidget {
  const DiscountCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: ExpansionTile(
        title: Text(
          "Cupom de desconto",
          textAlign: TextAlign.start,
          style:
              TextStyle(fontWeight: FontWeight.w500, color: Colors.grey[500]),
        ),
        leading: Icon(
          Icons.card_giftcard,
        ),
        trailing: Icon(Icons.add),
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Digite seu cupom",
              ),
              initialValue: CartModel.of(context).couponCode ?? "",
              onFieldSubmitted: (value) {
                FirebaseFirestore.instance
                    .collection("coupons")
                    .doc(value)
                    .get()
                    .then((docSnap) {
                  if ( docSnap.exists) {
                    CartModel.of(context).setCoupon(value, docSnap['percent']);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            "Desconto de ${docSnap["percent"]}% aplicado! "),
                        backgroundColor: Color.fromARGB(255, 238, 113, 129),
                      ),
                    );
                  } else {
                    CartModel.of(context).setCoupon(null, 0);
                     ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            "Cupom não existente! "),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
