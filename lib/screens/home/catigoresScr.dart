import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cupit/cupit.dart';
import 'package:shop_app/cupit/states.dart';
import 'package:shop_app/models/CategoriesModel.dart';

class CategorisScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<loginCubit, ShopStates>(
        listener: ((context, state) {}),
        builder: ((context, state) => ConditionalBuilder(
            condition: loginCubit.get(context).favpro != null,
            fallback: (context) => Center(
                  child: CircularProgressIndicator(),
                ),
            builder: (context) => SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Container(
                    color: Colors.grey[300],
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: GridView.count(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        childAspectRatio: 1 / 1.2,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5,
                        children: List.generate(
                            loginCubit
                                .get(context)
                                .CategoryModel!
                                .data!
                                .data
                                .length,
                            (index) => BuildCategoryGrid(loginCubit
                                .get(context)
                                .CategoryModel!
                                .data!
                                .data[index])),
                      ),
                    ),
                  ),
                ))));
  }

  Widget BuildCategoryGrid(DataModel model) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.blueGrey, borderRadius: BorderRadius.circular(12)),
      child: Center(
        child: Column(
          children: [
            SizedBox(
              height: 5,
            ),
            Image(
              image: NetworkImage(model.image.toString()),
              fit: BoxFit.cover,
              height: 180,
              width: 180,
            ),
            Center(
              child: Text(
                model.name.toString(),
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
