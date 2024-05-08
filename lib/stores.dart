
import 'package:assign_2/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit.dart';
import 'login.dart';

class stores extends StatefulWidget {
  @override
  State<stores> createState() => _storesState();
}

class _storesState extends State<stores> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cubit_App.get(context).getFavourites();
  }
  @override
  Widget build(BuildContext context) {
    IconData fav = Icons.favorite_border;
    bool f = false;
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
                      "What's Favorite ?",
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
                          itemCount: cubit_App.get(context).stores_data.length,
                          separatorBuilder: (BuildContext context, int index) {
                            return const SizedBox(
                              height: 20,
                            );
                          },
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(15)),
                              height: 150,
                              child: Center(
                                child: ListTile(
                                  title: Text(
                                      "${cubit_App.get(context).stores_data[index]["name"]}"),
                                  leading: CircleAvatar(
                                      backgroundImage: AssetImage(
                                          "${cubit_App.get(context).stores_data[index]["image"]}")),
                                  subtitle: Text(
                                      "${cubit_App.get(context).stores_data[index]["city"]["city"]}"),
                                  trailing: IconButton(
                                      onPressed: () {

                                        cubit_App.get(context)
                                            .toggleFavourite(cubit_App.get(context).stores_data[index]['id']);
                                      },
                                      icon: Icon(
                                            cubit_App.get(context)
                                .favorite_data[cubit_App.get(context).stores_data[index]['id']]==null||
                                                cubit_App.get(context)
                                                    .favorite_data[cubit_App.get(context).stores_data[index]['id']]==false?Icons.favorite_border:Icons.favorite,
                                        color: Colors.green,
                                      )),
                                ),
                              ),
                            );
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
