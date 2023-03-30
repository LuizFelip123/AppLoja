import 'package:flutter/material.dart';

class OrderScreen extends StatelessWidget {
  final String orderId;
  const OrderScreen(this.orderId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:  Color.fromARGB(255, 238, 113, 129),
        title: Text("Pedido Realizado"),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center ,
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check,
              color: Color.fromARGB(255, 238, 113, 129),
              size: 80.0,
            ),
            Text(
              "Pedido Realizado com Sucesso!",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            Text(
              "Código do pedido: $orderId",
              style: TextStyle(
                fontSize: 16.0,
              ),
            )
          ],
        ),
      ),
    );
  }
}
