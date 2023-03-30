import 'package:app_loja/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formkey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _addressController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 238, 113, 129),
          title: Text("Criar Conta"),
          centerTitle: true,
        ),
        body: ScopedModelDescendant<UserModel>(
          builder: (context, child, model) {
            if (model.isLoading)
              return Center(
                child: CircularProgressIndicator(),
              );

            return Form(
              key: _formkey,
              child: ListView(
                padding: EdgeInsets.all(16.0),
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(hintText: "Nome Completo"),
                    keyboardType: TextInputType.text,
                    validator: (text) {
                      if (text!.isEmpty) return "Nome inválido";
                    },
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
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
                    controller: _addressController,
                    decoration: InputDecoration(hintText: "Endereço"),
                    keyboardType: TextInputType.emailAddress,
                    validator: (text) {
                      if (text!.isEmpty) return "Endereço inválido";
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
                  SizedBox(
                    height: 16.0,
                  ),
                  SizedBox(
                    height: 44,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formkey.currentState!.validate()) {
                          Map<String, dynamic> userData = {
                            "name": _nameController.text,
                            "email": _emailController.text,
                            "address": _addressController.text
                          };
                          model.signup(
                              userData: userData,
                              pass: _passController.text,
                              onSuccess: _onSuccess,
                              onFail: _onFail);
                        }
                      },
                      child: Text(
                        "Criar",
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
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Usuário Criado com sucesso!")
        ,backgroundColor: Color.fromARGB(255, 238, 113, 129) ,
        duration: Duration(seconds: 2),
      ),
    );
    Future.delayed(Duration(seconds: 2)).then((_){
      Navigator.of(context).pop();
    });
  }

  void _onFail() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Usuário não foi Criado!"),
      duration: Duration(
        seconds: 2,
      ),
      backgroundColor: Colors.redAccent, 
    ));

  }
}
