import 'dart:io';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hive/hive.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DeskStorage  {
  register(String name,String password,String email,int age) async {
    await EasyLoading.show(status: 'loading...');
    var hive = await Hive.openBox('Auth');
    List<dynamic> users = hive.get('users', defaultValue: []);
    for (var user in users) {
      if (user['email'] == email) {
        await EasyLoading.dismiss();
        return 'Email already exists';
      }
    }
    users.add({
      'name': name,
      'password': password,
      'email': email,
      'age': age
    });
    await hive.put('users', users);
    await EasyLoading.dismiss();
    return null;
  }



  login (String email,String password) async {
    await EasyLoading.show(status: 'loading...');
    var hive = await Hive.openBox('Auth');
    List<dynamic> users = hive.get('users', defaultValue: []);
    for (var user in users) {
      if (user['email'] == email && user['password'] == password) {
        await EasyLoading.dismiss();
        return user;
      }
    }
    Map favourites = hive.get('favourites', defaultValue: {});
    if (favourites.isEmpty) {
      await hive.put('favourites', {
        0:false,
        1:false,
        2:false,
        3:false,
        4:false,
        5:false,
        6:false,
      });
    }

    await EasyLoading.dismiss();
    return null;
  }

  toggleFavourite(int id) async{
    var hive = await Hive.openBox('Auth');
    Map favourites = hive.get('favourites', defaultValue: {});
    print (favourites);
    if (!favourites.containsKey(id)) {
      favourites[id] = true;
      await hive.put('favourites', favourites);
      return;
    }
    favourites[id] = !favourites[id];
    await hive.put('favourites', favourites);
  }

  getFavourites () async{
    var hive = await Hive.openBox('Auth');
    Map favourites = hive.get('favourites', defaultValue: {});
    return favourites;
  }

}
