import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/cupit/cupit.dart';
import 'package:shop_app/cupit/states.dart';
import 'package:shop_app/screens/LoginScreen.dart';
import 'package:shop_app/shared/network/local/sharedPreferns.dart';

class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<loginCubit, ShopStates>(
        listener: ((context, state) {}),
        builder: ((context, state) {
          var cupit = loginCubit.get(context);
          return ConditionalBuilder(
              condition: loginCubit.get(context).favpro != null,
              fallback: (context) => Center(
                    child: CircularProgressIndicator(),
                  ),
              builder: (context) => SingleChildScrollView(
                    child: Center(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                              height: 150,
                              width: 150,
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100)),
                              child: Center(
                                child: Image(
                                  image: NetworkImage(
                                    cupit.profile!.data!.image.toString(),
                                  ),
                                  height: 150,
                                  width: 150,
                                  fit: BoxFit.cover,
                                ),
                              )),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 75,
                            width: 370,
                            decoration: BoxDecoration(
                              color: Colors.blueGrey,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Text(
                                'Name:- ${cupit.profile!.data!.name}',
                                style: TextStyle(
                                    fontSize: 21, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 75,
                            width: 370,
                            decoration: BoxDecoration(
                              color: Colors.blueGrey,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Text(
                                'Email:- ${cupit.profile!.data!.email}',
                                style: TextStyle(
                                    fontSize: 21, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 75,
                            width: 370,
                            decoration: BoxDecoration(
                              color: Colors.blueGrey,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Text(
                                'Phone:- ${cupit.profile!.data!.phone}',
                                style: TextStyle(
                                    fontSize: 21, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 75,
                            width: 370,
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: MaterialButton(
                              onPressed: () {
                                CashHelper.ClearData(key: 'token');
                                cupit.loginmodel = null;
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginScreen()));
                                Fluttertoast.showToast(
                                    msg: " تم تسجيل الخروج بنجاح",
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 5,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              },
                              child: (state != LoginLoadingState)
                                  ? Text(
                                      "LOGOUT",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25),
                                    )
                                  : CircularProgressIndicator(),
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ));
        }));
  }
}
