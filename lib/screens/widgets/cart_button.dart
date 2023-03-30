import 'package:app_loja/screens/cart_screen.dart';
import 'package:flutter/material.dart';

class CartButton extends StatelessWidget {
  const CartButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => CartScreen(),
          ),
        );
      },
      backgroundColor: Color.fromARGB(255, 238, 113, 129),
      child: Icon(
        Icons.shopping_cart,
        color: Colors.white,
      ),
    );
  }
}
