import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/screens/HomeScreen.dart';
import 'package:shop_app/screens/LoginScreen.dart';
import 'package:shop_app/screens/onBordingScreen.dart';

import 'cupit/cupit.dart';
import 'shared/network/local/sharedPreferns.dart';
import '/shared/network/remote/diohelper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CashHelper.init();

  bool? onboardingend = CashHelper.getData(key: "islast");
  String? token = CashHelper.getData(key: "token");
  Widget? widget;
  if (onboardingend != null) {
    if (token != null) {
      widget = MyHomePage();
      loginCubit()
        ..getHomeData()
        ..getCategoryData()
        ..getFav()
        ..getProfile();
    } else
      widget = LoginScreen();
  } else
    widget = onBondingScreen();

  return runApp(MyApp(widget));
}

class MyApp extends StatelessWidget {
  @override
  final Widget widget;
  MyApp(this.widget);
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => loginCubit()
          ..getHomeData()
          ..getCategoryData()
          ..getFav()
          ..getProfile(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            appBarTheme: const AppBarTheme(
                titleTextStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
                iconTheme: IconThemeData(color: Colors.black),
                color: Colors.white,
                elevation: 0,
                backwardsCompatibility: false,
                systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.white,
                    statusBarIconBrightness: Brightness.dark)),
            accentColor: Colors.blue,
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                selectedItemColor: Colors.blue,
                unselectedItemColor: Colors.black),
          ),
          darkTheme: ThemeData(
            scaffoldBackgroundColor: Colors.black87,
            primarySwatch: Colors.blue,
            appBarTheme: const AppBarTheme(
                titleTextStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
                iconTheme: const IconThemeData(color: Colors.white),
                color: Color.fromARGB(255, 0, 14, 26),
                elevation: 0,
                backwardsCompatibility: false,
                systemOverlayStyle: const SystemUiOverlayStyle(
                    statusBarColor: Color.fromARGB(255, 0, 21, 39),
                    statusBarIconBrightness: Brightness.dark)),
            accentColor: Colors.blue,
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                backgroundColor: const Color.fromARGB(255, 0, 9, 23),
                selectedItemColor: Colors.blue,
                unselectedItemColor: Colors.white),
          ),
          title: 'Shop App',
          home: widget,
        ));
  }
}
