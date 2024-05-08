

import 'dart:math';

import 'package:assign_2/login.dart';
import 'package:assign_2/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'cubit.dart';
import 'home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Bloc.observer = MyBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit_App()
        ..get_postion(),
      child: BlocConsumer<cubit_App, states_App>(
          listener: (context, state) {},
          builder: (context, state) {
            return MaterialApp(
              builder: EasyLoading.init(),
              debugShowCheckedModeBanner: false,
              home: login(),
            );
          }),
    );
  }
}
