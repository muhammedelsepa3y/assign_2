// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors


import 'package:assign_2/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit.dart';
import 'login.dart';

class signUp extends StatelessWidget {
  var name = TextEditingController();
  var Age = TextEditingController();
  var email = TextEditingController();
  var password = TextEditingController();
  var formKey = GlobalKey<FormState>();
  bool found = false;
  bool obText = true;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<cubit_App, states_App>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(15),
              child: Center(
                child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Sign Up",
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.green),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        TextFormField(
                          controller: name,
                          validator: (value) {
                            if (value!.isEmpty || value.length < 2) {
                              return " name is small";
                            }
                          },
                          keyboardType: TextInputType.name,
                          decoration: const InputDecoration(
                              label: Text("name"),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25)))),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          controller: Age,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Age very small";
                            }
                          },
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                              label: Text("Age"),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25)))),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          controller: email,
                          validator: (value) {
                            if (value!.isEmpty ||
                                value.endsWith("@gmail.com") == false ||
                                value.indexOf("@gmail.com") != 8) {
                              return "Email required include  id@gmail.com ";
                            }
                          },
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                              label: Text("Email"),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25)))),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          obscureText: obText,
                          controller: password,
                          validator: (value) {
                            if (value!.length < 8) {
                              return " password very Small ";
                            }
                          },
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                              label: Text("password"),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25)))),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Container(
                          width: 200,
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.grey)),
                              onPressed: () async{
                                if (formKey.currentState!.validate()) {
                                 await cubit_App.get(context).signUp_database(
                                    context,
                                      name: name.text,
                                      Age: Age.text,
                                      email: email.text,
                                      password: password.text);
                                }
                              },
                              child: Text(
                                "Sign Up",
                                style: TextStyle(color: Colors.black),
                              )),
                        ),
                        Row(
                          children: [
                            Text("Already Have Email"),
                            TextButton(
                                onPressed: () {
                                  Navigator.push<void>(
                                    context,
                                    MaterialPageRoute<void>(
                                      builder: (BuildContext context) =>
                                          login(),
                                    ),
                                  );
                                },
                                child: Text(
                                  "Login",
                                  style: TextStyle(color: Colors.green),
                                ))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
