// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, unused_local_variable


import 'package:assign_2/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import 'cubit.dart';
import 'login.dart';

class distance extends StatelessWidget {
  distance({super.key});
  Map<String, List<double>> latlang = {
    "Helwan": [29.845400, 31.337151],
    "6 Octobar": [30.562120, 31.788839],
    "Egypt Mall": [29.967590, 30.968330],
    "City Mall": [30.364361, 30.506901]
  };
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<cubit_App, states_App>(
      builder: (context, state) {
        return Center(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Distance",
                    style: TextStyle(
                        color: Colors.green,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: const Text("تسجيل الخروج"),
                                  content: const Text("هل تريد تسجيل الخروج"),
                                  actions: [
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
                                        child: const Text("نعم")),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text("لا"))
                                  ],
                                ));
                      },
                      icon: const Icon(
                        Icons.logout,
                      ))
                ],
              ),
              Expanded(
                child: ((cubit_App.get(context).servicse == false) ||
                        (cubit_App.get(context).per ==
                            LocationPermission.denied))
                    ? Center(
                        child: Text("check Permission and Open Loaction"),
                      )
                    : ListView.separated(
                        itemCount: cubit_App.get(context).favorite_data.length,
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(
                            height: 20,
                          );
                        },
                        itemBuilder: (BuildContext context, int index) {
    if ( cubit_App.get(context).favorite_data[index]==true) {
    var item= cubit_App.get(context).stores_data[index];

    return Container(
                            decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(15)),
                            height: 150,
                            child: Center(
                              child: ListTile(
                                title: Text(
                                    "${item["name"]}"),
                                leading: CircleAvatar(
                                    backgroundImage: AssetImage(
                                        "${item["image"]}")),
                                subtitle: Text(
                                    "Distance : ${(Geolocator.distanceBetween(cubit_App.get(context).current!.latitude, cubit_App.get(context).current!.longitude, item["city"]["lat"], item["city"]["lang"]) / 1000).round()} K"),
                              ),
                            ),
                          );}
                          return Container();
                        },
                      ),
              )
            ],
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}
