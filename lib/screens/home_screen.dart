import 'package:app_loja/screens/tabs/home_tab.dart';
import 'package:app_loja/screens/tabs/order_tab.dart';
import 'package:app_loja/screens/tabs/places_tab.dart';
import 'package:app_loja/screens/tabs/products_tab.dart';
import 'package:app_loja/screens/widgets/cart_button.dart';
import 'package:app_loja/screens/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _pageController = PageController();
    return PageView(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      children: [
        Scaffold(
          body: HomeTab(),
          drawer: CustomDrawer(pageController: _pageController),
          floatingActionButton: CartButton(),
        ),
        Scaffold(
          appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 238, 113, 129),
            title: Text("Produtos"),
            centerTitle: true,
          ),
          floatingActionButton: CartButton(),
          drawer: CustomDrawer(pageController: _pageController),
          body: ProductsTab(),
        ),
        Scaffold(
          appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 238, 113, 129),
            title: Text("Lojas"),
            centerTitle: true,
          ),
          body: PlacesTab(),
          drawer: CustomDrawer(pageController: _pageController),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text("Meus Pedidos"),
            centerTitle: true,
            backgroundColor: Color.fromARGB(255, 238, 113, 129),
          ),
          drawer: CustomDrawer(pageController: _pageController),
          body: OrderTab(),
        )
      ],
    );
  }
}
