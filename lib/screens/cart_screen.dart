import 'package:app_loja/models/cart_model.dart';
import 'package:app_loja/models/user_model.dart';
import 'package:app_loja/screens/login_screen.dart';
import 'package:app_loja/screens/order_screen.dart';
import 'package:app_loja/screens/titles/cart_title.dart';
import 'package:app_loja/screens/widgets/CardPrice.dart';
import 'package:app_loja/screens/widgets/discount_card.dart';
import 'package:app_loja/screens/widgets/ship_card.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 238, 113, 129),
        title: Text("Meu Carrinho"),
        centerTitle: true,
        actions: [
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(right: 8.0),
            child: ScopedModelDescendant<CartModel>(
              builder: (context, child, model) {
                int p = model.products.length;
                return Text(
                  "${p}  ${p == 1 ? " ITEM" : " ITENS"}",
                  style: TextStyle(fontSize: 17.0),
                );
              },
            ),
          )
        ],
      ),
      body: ScopedModelDescendant<CartModel>(
        builder: (context, child, model) {
          if (model.isLoading && UserModel.of(context).isLoggedIn()) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (!UserModel.of(context).isLoggedIn()) {
            return Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.remove_shopping_cart,
                    color: Color.fromARGB(255, 238, 113, 129),
                    size: 80.0,
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  Text(
                    "Faça o login para adicionar produtos!",
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ));
                    },
                    child: Text(
                      "Entrar",
                      style: TextStyle(fontSize: 18.0),
                    ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 238, 113, 129)),
                  )
                ],
              ),
            );
          } else if (model.products == null || model.products.length == 0) {
            return Center(
              child: Text(
                "Nenhum produto no carrinho!",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            );
          } else {
            return ListView(
              children: [
                Column(
                  children: model.products.map((e) {
                    return CartTile(e);
                  }).toList(),
                ),
                DiscountCard(),
                ShipCard(),
                CartPrice(() async {
                  String? orderId = await model.finishOrder();
                  if (orderId != null) {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => OrderScreen(orderId),
                    ));
                  }
                })
              ],
            );
          }
        },
      ),
    );
  }
}
