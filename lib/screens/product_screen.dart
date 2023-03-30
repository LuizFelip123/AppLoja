import 'package:app_loja/datas/cart_product.dart';
import 'package:app_loja/datas/products_data.dart';
import 'package:app_loja/models/cart_model.dart';
import 'package:app_loja/models/user_model.dart';
import 'package:app_loja/screens/cart_screen.dart';
import 'package:app_loja/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ProductScreen extends StatefulWidget {
  final ProductsData productsData;
  ProductScreen({required this.productsData});

  @override
  State<ProductScreen> createState() =>
      _ProductScreenState(productsData: productsData);
}

class _ProductScreenState extends State<ProductScreen> {
  final ProductsData productsData;
  String? size;
  _ProductScreenState({required this.productsData});
  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 238, 113, 129),
        title: Text(productsData.title!),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          AspectRatio(
            aspectRatio: 1.0,
            child: CarouselSlider(
              items: productsData.images!.map((e) {
                return Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(e),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }).toList(),
              options: CarouselOptions(
                height:
                    double.infinity, // Preenche todo espaço vertical disponível
                enableInfiniteScroll: false,
                viewportFraction: 1.0,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  productsData.title!,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 3,
                ),
                Text(
                  "R\$ ${productsData.price!.toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                Text(
                  "Tamanho ",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 34.0,
                  child: GridView(
                    padding: EdgeInsets.symmetric(vertical: 4.0),
                    scrollDirection: Axis.horizontal,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      mainAxisSpacing: 8.0,
                      childAspectRatio: 0.5,
                    ),
                    children: productsData.sizes!.map((e) {
                      return GestureDetector(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(4.0),
                            ),
                            border: Border.all(
                                color: e == size
                                    ? primaryColor
                                    : Colors.grey[500]!,
                                width: 3.0),
                          ),
                          width: 50,
                          alignment: Alignment.center,
                          child: Text(e),
                        ),
                        onTap: () {
                          setState(() {
                            size = e;
                          });
                        },
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                SizedBox(
                  height: 44.0,
                  child: ElevatedButton(
                    onPressed: size != null
                        ? () {
                            if (UserModel.of(context).isLoggedIn()) {
                              CartProduct cartProduct = CartProduct();
                              cartProduct.size = size;
                              cartProduct.quantity = 1;
                              cartProduct.pid = productsData.id;
                              cartProduct.category = productsData.category;
                            cartProduct.productsData = productsData;
                              CartModel.of(context).addCartItem(cartProduct);
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => CartScreen(),
                              ));
                            } else {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => LoginScreen(),
                                ),
                              );
                            }
                          }
                        : null,
                    child: Text(
                      UserModel.of(context).isLoggedIn()
                          ? "Adicionar ao Carrinho"
                          : "Entre para Comprar",
                      style: TextStyle(fontSize: 18.0),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 238, 113, 129),
                    ),
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                Text(
                  "Descrição ",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  productsData.description!,
                  style: TextStyle(fontSize: 16.0),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
