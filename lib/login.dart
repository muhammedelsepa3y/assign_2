import 'dart:math';
import 'package:assign_2/sign_up.dart';
import 'package:assign_2/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'cubit.dart';
import 'home_screen.dart';

class login extends StatelessWidget {
  var email = TextEditingController();
  var password = TextEditingController();
  var formKey = GlobalKey<FormState>();
  var scafoldKey = GlobalKey<ScaffoldState>();
  bool find = false;
  bool obstext = true;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<cubit_App, states_App>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            key: scafoldKey,
            body: SafeArea(
                child: Center(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Login",
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.green),
                        ),
                        const SizedBox(
                          height: 80,
                        ),
                        TextFormField(
                          controller: email,
                          validator: (value) {
                            if (value!.isEmpty ||
                                value.endsWith("@gmail.com") == false ||
                                value.indexOf("@gmail.com") != 8) {
                              return "Email required include id@gmail.com ";
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
                          height: 50,
                        ),
                        TextFormField(
                          obscureText: obstext,
                          controller: password,
                          validator: (value) {
                            if (value!.length < 8) {
                              return " password very Small ";
                            }
                          },
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    obstext == true
                                        ? obstext = false
                                        : obstext = true;
                                  },
                                  icon: const Icon(Icons.remove_red_eye)),
                              label: const Text("password"),
                              border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25)))),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Container(
                            width: 200,
                            child: ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.grey)),
                                onPressed: () async{
                                  if (formKey.currentState!.validate()) {
                                    await cubit_App
                                        .get(context)
                                        .login(context,email.text, password.text);
                                  }
                                },
                                child: const Text("Login",
                                    style: TextStyle(color: Colors.black)))),
                        Row(
                          children: [
                            const Text("Don't Have Email"),
                            TextButton(
                                onPressed: () {
                                  Navigator.push<void>(
                                    context,
                                    MaterialPageRoute<void>(
                                      builder: (BuildContext context) =>
                                          signUp(),
                                    ),
                                  );
                                },
                                child: const Text("Sign_Up",
                                    style: TextStyle(color: Colors.green)))
                          ],
                        ),
                        const SizedBox(
                          height: 100,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )),
          );
        });
  }
}
