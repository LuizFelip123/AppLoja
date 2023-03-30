import 'package:app_loja/datas/products_data.dart';
import 'package:app_loja/screens/product_screen.dart';
import 'package:flutter/material.dart';

class ProductsTitle extends StatelessWidget {
  final String type;
  final ProductsData productsData;
  ProductsTitle({required this.type, required this.productsData});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push( MaterialPageRoute(builder: (context)=>ProductScreen(productsData: this.productsData)),);
      },
      child: Card(
        child: type == "Grid"
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  AspectRatio(
                    aspectRatio: 0.8,
                    child: Image.network(
                      productsData.images![0],
                      fit: BoxFit.cover,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            productsData.title!,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "R\$ ${productsData.price!.toStringAsFixed(2)}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                              fontSize: 17.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            : Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: Image.network(
                      productsData.images![0],
                      height: 250.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            productsData.title!,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "R\$ ${productsData.price!.toStringAsFixed(2)}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                              fontSize: 17.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
