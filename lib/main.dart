import 'package:app_loja/models/cart_model.dart';
import 'package:app_loja/models/user_model.dart';
import 'package:app_loja/screens/home_screen.dart';
import 'package:app_loja/screens/login_screen.dart';
import 'package:app_loja/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:scoped_model/scoped_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserModel>(
        model: UserModel(),
        child: ScopedModelDescendant<UserModel>(
          builder: (context, child, model) {

            
            return ScopedModel<CartModel>(
              model: CartModel(model),
              child: MaterialApp(
                title: "Flutter's Closthing ",
                theme: ThemeData(
                    primarySwatch: Colors.blue,
                    primaryColor: const Color.fromARGB(255, 4, 125, 141)),
                debugShowCheckedModeBanner: false,
                home: HomeScreen(),
              ),
            );
          },
        ));
  }
}
