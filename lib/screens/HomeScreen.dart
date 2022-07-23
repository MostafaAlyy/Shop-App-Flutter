import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cupit/cupit.dart';
import 'package:shop_app/cupit/states.dart';
import 'package:shop_app/screens/home/SecrchScr.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<loginCubit, ShopStates>(
        listener: (context, state) => {},
        builder: (context, state) {
          var cupit = loginCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: const Text('Mostafa Express'),
              actions: [
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SerchScreen()));
                  },
                ),
              ],
            ),
            body: Center(
              child: cupit.views[cupit.currentindex],
            ),
            bottomNavigationBar: BottomNavigationBar(
                onTap: ((value) {
                  cupit.changeCurrentIndex(value);
                }),
                currentIndex: cupit.currentindex,
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: "Home",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.apps),
                    label: "Catagories",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.favorite),
                    label: "favorite",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.settings),
                    label: "settings",
                  ),
                ]),
          );
        });
  }
}
