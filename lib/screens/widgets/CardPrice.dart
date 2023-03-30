import 'package:app_loja/models/cart_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class CartPrice extends StatelessWidget {
 final VoidCallback buy;
  const CartPrice(this.buy);
 
  @override
  Widget build(BuildContext context) {
  
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: ScopedModelDescendant<CartModel>(
          
          builder: (context, child, model) {
            double price  = model.getProductsPrice();
            double discount = model.getDiscount() ;
            double ship  = model.getShipPrice();

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Resumo do pedido",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 12.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Subtotal"),
                    Text("R\$ ${price.toStringAsFixed(2)}"),
                  ],
                ),
                Divider(
                  color: Colors.grey[500],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Desconto"),
                    Text("R\$ ${discount.toStringAsFixed(2)}"),
                  ],
                ),
                Divider(
                  color: Colors.grey[500],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Entrega"),
                    Text("R\$ ${ship.toStringAsFixed(2)}"),
                  ],
                ),
                Divider(
                  color: Colors.grey[500],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "R\$ ${(price+ship-discount).toStringAsFixed(2 )}",
                      style: TextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 238, 113, 129),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 12.0,
                ),
                ElevatedButton(
                  onPressed: buy,
                  child: Text(
                    "Finalizar Pedido",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 238, 113, 129),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
