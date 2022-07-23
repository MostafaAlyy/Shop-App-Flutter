import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cupit/cupit.dart';
import 'package:shop_app/cupit/states.dart';
import 'package:shop_app/models/FaoriteModel.dart';

class FavoritScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cupit = loginCubit.get(context);
    return BlocConsumer<loginCubit, ShopStates>(
      listener: ((context, state) {}),
      builder: ((context, state) {
        return ConditionalBuilder(
            condition: loginCubit.get(context).favpro != null,
            fallback: (context) => Center(
                  child: CircularProgressIndicator(),
                ),
            builder: (context) =>  Container(
          color: Colors.grey[300],
          child: ListView.separated(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemBuilder: ((context, index) => BuildProductFavList(
                index, cupit.favpro!.data!.data![index], context)),
            itemCount: cupit.favpro!.data!.data!.length,
            separatorBuilder: ((context, index) => SizedBox(
                  height: 0,
                )),
          ),
        ));
      }),
    );
  }

  Widget BuildProductFavList(int index, Data2 model, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        height: 120,
        width: double.infinity,
        child: Row(children: [
          Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Image(
                image: NetworkImage(
                  '${model.product!.image}',
                ),
                width: 120,
                height: 120,
                fit: BoxFit.contain,
              ),
              if (model.product!.oldPrice != 0 &&
                  model.product!.oldPrice > model.product!.price)
                Container(
                  color: Colors.red,
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Text(
                      "HOT",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(
            width: 5,
          ),
          Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 5,
                ),
                Container(
                  width: 270,
                  child: Text(
                    "${model.product!.name}",
                    maxLines: 2,
                    style: TextStyle(
                        // height: 3,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: 270,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "${model.product!.price}",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      if (model.product!.oldPrice != 0 &&
                          model.product!.oldPrice > model.product!.price)
                        Text(
                          "${model.product!.oldPrice}",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                              fontWeight: FontWeight.bold),
                        ),
                      Spacer(),
                      IconButton(
                          onPressed: () {
                            loginCubit
                                .get(context)
                                .changeFavoriteData(model.product!.id);
                          },
                          icon: ConditionalBuilder(
                              condition: loginCubit
                                      .get(context)
                                      .favorit[model.product!.id] ==
                                  true,
                              builder: (context) => CircleAvatar(
                                  backgroundColor: Colors.white,
                                  child: Icon(
                                    Icons.favorite,
                                    color: Colors.redAccent,
                                  )),
                              fallback: (context) => CircleAvatar(
                                  backgroundColor: Colors.grey,
                                  child: Icon(
                                    Icons.favorite,
                                    color: Colors.white,
                                  ))))
                    ],
                  ),
                )
              ]),
        ]),
      ),
    );
  }
  
}
