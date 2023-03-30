import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrderTitle extends StatelessWidget {
  final String id;
  const OrderTitle(this.id);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: StreamBuilder<DocumentSnapshot>(
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              int status = snapshot.data!["status"];

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Código do pedido: ${snapshot.data!.id}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 4.0,
                  ),
                  Text(_buildProductsText(snapshot.data!)),
                  SizedBox(
                    height: 4.0,
                  ),
                  Text(
                    "Status do pedidos",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildCircle("1", "Preparação", status, 1),
                      Container(
                        height: 1.0,
                        width: 40.0,
                        color: Colors.grey,
                      ),
                      _buildCircle("2", "Transporte", status, 2),
                      Container(
                        height: 1.0,
                        width: 40.0,
                        color: Colors.grey,
                      ),
                      _buildCircle("3", "Entrega", status, 3),
                    ],
                  )
                ],
              );
            }
          },
          stream: FirebaseFirestore.instance
              .collection("orders")
              .doc(id)
              .snapshots(),
        ),
      ),
    );
  }

  String _buildProductsText(DocumentSnapshot snapshot) {
    String text = "Descrição:\n";

    for (LinkedHashMap p in snapshot["products"]) {
      double price = p["product"]["price"];
      text +=
          " ${p["quantity"]} x ${p["product"]["title"]} (${price.toStringAsFixed(2)}) \n";
    }
    double totalPrice = snapshot["totalPrice"];
    return text += "Total: R\$ ${totalPrice.toStringAsFixed(2)}";
  }

  Widget _buildCircle(
      String title, String subtitle, int status, int thisStatus) {
    Color backColor;
    Widget child;
    if (status < thisStatus) {
      backColor = Colors.grey;
      child = Text(
        title,
        style: TextStyle(color: Colors.white),
      );
    } else if (status == thisStatus) {
      backColor = Colors.blue;
      child = Stack(
        alignment: Alignment.center,
        children: [
          Text(
            title,
            style: TextStyle(color: Colors.white),
          ),
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          )
        ],
      );
    } else {
      backColor = Colors.green;
      child = Icon(Icons.check);
    }
    return Column(
      children: [
        CircleAvatar(
          radius: 20.0,
          backgroundColor: backColor,
          child: child,
        ),
      ],
    );
  }
}
