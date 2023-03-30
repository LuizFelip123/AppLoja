import 'package:app_loja/models/user_model.dart';
import 'package:app_loja/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 238, 113, 129),
          title: Text("Entrar"),
          centerTitle: true,
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => SignUpScreen(),
                ));
              },
              child: Text(
                "CRIAR CONTA",
                style: TextStyle(fontSize: 15.0, color: Colors.white),
              ),
            ),
          ],
        ),
        body: ScopedModelDescendant<UserModel>(
          builder: (context, child, model) {
            if (model.isLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return Form(
              key: _formkey,
              child: ListView(
                padding: EdgeInsets.all(16.0),
                children: [
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(hintText: "Email"),
                    keyboardType: TextInputType.emailAddress,
                    validator: (text) {
                      if (text!.isEmpty || !text.contains("@"))
                        return "Email inválido";
                    },
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  TextFormField(
                    controller: _passController,
                    obscureText: true,
                    decoration: InputDecoration(hintText: "Senha"),
                    validator: (text) {
                      if (text!.isEmpty || text.length < 6) {
                        return "Senha inválida";
                      }
                    },
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: EdgeInsets.zero,
                      child: TextButton(
                        onPressed: () {
                          if (_emailController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content:
                                  Text("Insira seu e-mail para recuperação!"),
                              duration: Duration(
                                seconds: 2,
                              ),
                              backgroundColor: Colors.redAccent,
                            ));
                          } else {
                            model.recoverPass(_emailController.text);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Confira seu email!"),
                              duration: Duration(
                                seconds: 2,
                              ),
                              backgroundColor: Color.fromARGB(255, 27, 221, 101),
                            ));
                          }
                        },
                        child: Text(
                          "Esqueci minha senha",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  SizedBox(
                    height: 44,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formkey.currentState!.validate()) {}
                        model.signin(
                            email: _emailController.text,
                            pass: _passController.text,
                            onSuccess: _onSuccess,
                            onFail: _onFail);
                      },
                      child: Text(
                        "Entrar",
                        style: TextStyle(fontSize: 18.0),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 238, 113, 129),
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ));
  }

  void _onSuccess() {
    Navigator.of(context).pop();
  }

  void _onFail() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Falha ao Entrar!"),
      duration: Duration(
        seconds: 2,
      ),
      backgroundColor: Colors.redAccent,
    ));
  }
}
