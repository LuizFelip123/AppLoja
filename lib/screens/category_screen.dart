import 'package:app_loja/datas/products_data.dart';
import 'package:app_loja/screens/titles/products_title.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CategoryScreen extends StatelessWidget {
  final DocumentSnapshot snapshot;
  CategoryScreen({required this.snapshot});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 238, 113, 129),
          title: Text(
            snapshot["title"],
          ),
          centerTitle: true,
          bottom: TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(
                icon: Icon(
                  Icons.grid_on,
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.list,
                ),
              )
            ],
          ),
        ),
        body: FutureBuilder<QuerySnapshot>(
          future: FirebaseFirestore.instance
              .collection("products")
              .doc(snapshot.id)
              .collection("items")
              .get(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    GridView.builder(
                      padding: EdgeInsets.all(4.0),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 4.0,
                          crossAxisSpacing: 4.0,
                          childAspectRatio: 0.65),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        ProductsData productsData = ProductsData.fromDocument(
                          snapshot.data!.docs[index],
                        );
                        productsData.category = this.snapshot.id;

                        return ProductsTitle(
                          type: "Grid",
                          productsData: productsData,
                        );
                      },
                    ),
                    ListView.builder(
                      padding: EdgeInsets.all(4.0),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        ProductsData productsData = ProductsData.fromDocument(
                          snapshot.data!.docs[index],
                        );
                        productsData.category = this.snapshot.id;
                        return ProductsTitle(
                          type: "List",
                          productsData: productsData,
                        );
                      },
                    ),
                  ]);
            }
          },
        ),
      ),
    );
  }
}
