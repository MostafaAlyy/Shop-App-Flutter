import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../cupit/cupit.dart';
import '../cupit/states.dart';
import '../shared/network/local/sharedPreferns.dart';
import 'HomeScreen.dart';

class RegisterScreen extends StatelessWidget {
  @override
  var formKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController nameController = TextEditingController();
    return BlocConsumer<loginCubit, ShopStates>(
      listener: (context, state) {
        var cupit = loginCubit.get(context);
        if (state is LoginSucseesState) {
          if (state.loginmodel!.status == true) {
            print("object");
            print(state.loginmodel?.data?.token);
            print(state.loginmodel?.message);
            CashHelper.SaveData(
                    key: 'token', value: state.loginmodel?.data?.token)
                .then((value) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                return MyHomePage();
              }));
            });
            Fluttertoast.showToast(
                msg: "${state.loginmodel?.message}",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 5,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0);
          } else {
            print(state.loginmodel?.message);
            Fluttertoast.showToast(
                msg: "${state.loginmodel?.message}",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 5,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          }
        }
      },
      builder: (context, state) => Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      "Create New Account",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: emailController,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return "Please enter email";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Email Address",
                        prefixIcon: Icon(Icons.email),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: passController,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return "password is required";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.visiblePassword,
                      onFieldSubmitted: (vale) {
                        if (formKey.currentState!.validate()) {
                          loginCubit.get(context).userLogin(
                              email: emailController.text,
                              password: passController.text);
                        }
                      },
                      obscureText: loginCubit.get(context).isPassowrdShown,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Password",
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: IconButton(
                              icon: Icon(loginCubit.get(context).loginSuffix),
                              onPressed: () {
                                loginCubit.get(context).changeShonPass();
                              })),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: nameController,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return "Name is required";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.visiblePassword,
                      onFieldSubmitted: (vale) {
                        if (formKey.currentState!.validate()) {
                          loginCubit.get(context).userLogin(
                              email: emailController.text,
                              password: passController.text);
                        }
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Name",
                        prefixIcon: Icon(Icons.manage_accounts),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: phoneController,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return "Phone is required";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.visiblePassword,
                      onFieldSubmitted: (vale) {
                        if (formKey.currentState!.validate()) {
                          loginCubit.get(context).userLogin(
                              email: emailController.text,
                              password: passController.text);
                        }
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Phone",
                        prefixIcon: Icon(Icons.phone),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: double.infinity,
                      height: 50,
                      child: MaterialButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            loginCubit.get(context).userRegister(
                                  email: emailController.text,
                                  password: passController.text,
                                  name: nameController.text,
                                  phone: phoneController.text,
                                );
                          }
                        },
                        color: Colors.blue,
                        child: const Text(
                          "Register",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 25),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
