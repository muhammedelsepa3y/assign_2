
import 'package:assign_2/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit.dart';
import 'login.dart';

class favorite extends StatefulWidget {
  @override
  State<favorite> createState() => _favoriteState();
}

class _favoriteState extends State<favorite> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cubit_App.get(context).getFavourites();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<cubit_App, states_App>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is! Load_Data) {
            return Center(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Your Favorite ",
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
                                                builder:
                                                    (BuildContext context) =>
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
                  child: ListView.separated(
                          itemCount: 7,
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
                                      "${item["city"]["city"]}"),
                                  trailing: IconButton(
                                      onPressed: () {
                                        cubit_App.get(context)
                                            .toggleFavourite(item['id']);
                                      },
                                      icon: const Icon(
                                        Icons.favorite,
                                        color: Colors.green,
                                      )),
                                ),
                              ),
                            );
                            }
                            return Container();
                          },
                        ),
                )
              ],
            ),
          );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
