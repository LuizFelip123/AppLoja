import 'package:app_loja/models/user_model.dart';
import 'package:app_loja/screens/login_screen.dart';
import 'package:app_loja/screens/titles/order_title.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrderTab extends StatelessWidget {
  const OrderTab();

  @override
  Widget build(BuildContext context) {
        if(UserModel.of(context).isLoggedIn()){
          String uid = UserModel.of(context).user!.uid;

          return FutureBuilder<QuerySnapshot>(
            future: FirebaseFirestore.instance.collection("users").doc(uid).collection("orders").get(),
            builder: (context, snapshot) {
              if(!snapshot.hasData){
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              return ListView(
                children: snapshot.data!.docs.map((e){
                  return  OrderTitle(e.id);
                }).toList().reversed.toList(),
              );
            },
          );
        }

        return Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.view_list,
                    color: Color.fromARGB(255, 238, 113, 129),
                    size: 80.0,
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  Text(
                    "Faça o login para acompanhar os seus pedidos!",
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
  }
}