import 'package:another_flushbar/flushbar.dart';
import 'package:assign_2/states.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'desk_storage.dart';
import 'home_screen.dart';

class cubit_App extends Cubit<states_App> {
  cubit_App() : super(ini());
  List signUp_data = [];
  List stores_data = [
    {"name": "NBE", "image": "assets/ahly.png", "city": {"lat":120.5,"lang":115.0,"city":"Cairo"},"id":0},
    {"name": "CIB", "image": "assets/cib.jpg", "city": {"lat": 85.5,"lang": 110.0,"city":"Alex"},"id":1},
    {"name": "AAIB", "image": "assets/aaib.png", "city": {"lat": 110.5,"lang": 112.0,"city":"Aswan"},"id":2},
    {"name": "QNB", "image": "assets/qnb.jpeg", "city": {"lat": 45.5,"lang": 131.0,"city":"London"},"id":3},
    {"name": "HSBC", "image": "assets/hsbc.jpg", "city": {"lat": 97.5,"lang": 64.0,"city":"Paris"},"id":4},
    {"name": "BLOM", "image": "assets/blom.jpeg", "city": {"lat": 48.5,"lang": 86.0,"city":"Berlin"},"id":5},
    {"name": "Misr", "image": "assets/misr.png", "city": {"lat": 78.5,"lang": 12.0,"city":"Moscow"},"id":6},


  ];
  Map favorite_data = {};
  bool servicse = false;
  var per;
  Position? current;
  List<Placemark>? placemarker;
  double? distance;
  var distanceBetween;

  static cubit_App get(context) => BlocProvider.of(context);

  get_postion() async {
    servicse = await Geolocator.isLocationServiceEnabled();
    per = await Geolocator.checkPermission();
    per == LocationPermission.denied
        ? per = await Geolocator.requestPermission()
        : null;

    if (servicse == true && per != LocationPermission.denied) {
      current = await Geolocator.getCurrentPosition().then((value) => value);
      placemarker =
          await placemarkFromCoordinates(current!.latitude, current!.longitude);
      print(current);
      print(placemarker![0].subAdministrativeArea);
      print(per);
      print(servicse);
    } else {
      Fluttertoast.showToast(
          msg: "Open Location and Permation",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      print("Services $servicse");
    }
  }



  void Chang_nav() {
    emit(change_nav());
  }

  void chang_to_distance() {
    emit(change_nav_Distance());
  }

  signUp_database(
    context, {
    required String name,
    required String Age,
    required String email,
    required String password,
  }) async {
    var user =
        await DeskStorage().register(name, password, email, int.parse(Age));
    if (user == null) {
      Navigator.pop(context);
      Fluttertoast.showToast(
          msg: "Sign up Successfuly",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
      emit(Create_DataBase());
    } else {
      Fluttertoast.showToast(
          msg: user,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      emit(Error_Data());
    }
  }

  login(context, String text, String text2) async {
    var user = await DeskStorage().login(text, text2);
    if (user != null) {
      emit(Get_Data_signUp());
      await getFavourites();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => const home_screen(),
        ),
      );
      Fluttertoast.showToast(
          msg: "Login Successfuly",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      Fluttertoast.showToast(
          msg: "Fail Login",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      emit(Error_Data());
    }
  }

   toggleFavourite(int id) async{
    await DeskStorage().toggleFavourite(id);
    getFavourites();

   }
   getFavourites() async{
    emit(Load_Data());
    favorite_data = await DeskStorage().getFavourites();
    emit(Get_Data_Favorite());
   }
}

class MyBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    // TODO: implement onCreate
    super.onCreate(bloc);
    print("on Create-- ${bloc.runtimeType}");
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    // TODO: implement onChange
    super.onChange(bloc, change);
    print("on Create-- ${bloc.runtimeType} , $change");
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    // TODO: implement onError
    super.onError(bloc, error, stackTrace);
    print("on Create-- ${bloc.runtimeType} , $error");
  }

  @override
  void onClose(BlocBase bloc) {
    // TODO: implement onClose
    super.onClose(bloc);
    print("on Create-- ${bloc.runtimeType}");
  }
}
