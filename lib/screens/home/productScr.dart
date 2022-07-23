import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cupit/cupit.dart';
import 'package:shop_app/cupit/states.dart';
import 'package:shop_app/models/CategoriesModel.dart';
import 'package:shop_app/models/HomeModel.dart';

class ProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<loginCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return BlocConsumer<loginCubit, ShopStates>(
              listener: (context, state) {},
              builder: (context, state) {
                return ConditionalBuilder(
                    condition: loginCubit.get(context).homeModel != null,
                    fallback: (context) => Center(
                          child: CircularProgressIndicator(),
                        ),
                    builder: (context) => ConditionalBuilder(
                        condition: loginCubit.get(context).homeModel != null &&
                            loginCubit.get(context).CategoryModel != null,
                        fallback: (context) => Center(
                              child: CircularProgressIndicator(),
                            ),
                        builder: (context) => prouductWidget(
                            loginCubit.get(context).homeModel!,
                            loginCubit.get(context).CategoryModel!,
                            context)));
              });
        });
  }

  Widget prouductWidget(
      HomeModel model, CategoriesModel categoriesModel, BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          CarouselSlider(
              items: model.data?.banners
                  .map((e) => Image(
                        image: NetworkImage(e.image!),
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ))
                  .toList(),
              options: CarouselOptions(
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                viewportFraction: 1,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(seconds: 1),
                autoPlayCurve: Curves.fastOutSlowIn,
              )),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  "Categories",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 150,
                  child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: ((context, index) =>
                        CategoryItem(index, categoriesModel.data!.data[index])),
                    itemCount: categoriesModel.data!.data.length,
                    separatorBuilder: ((context, index) => SizedBox(
                          width: 10,
                        )),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                const Text(
                  "New Products",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          Container(
            color: Colors.grey[300],
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                childAspectRatio: 1 / 1.29,
                crossAxisSpacing: 2,
                mainAxisSpacing: 2,
                children: List.generate(
                    model.data!.products.length,
                    (index) =>
                        BuildProductGrid(model.data!.products[index], context)),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget BuildProductGrid(HomeProducts model, BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Stack(
              alignment: Alignment.bottomLeft,
              children: [
                Image(
                  image: NetworkImage(
                    '${model.image}',
                  ),
                  width: double.infinity,
                  height: 180,
                  fit: BoxFit.contain,
                ),
                if (model.old_price != 0 && model.old_price > model.price)
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
            Text(
              "${model.name}",
              maxLines: 2,
              style: TextStyle(
                  height: 1, fontSize: 14, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                SizedBox(
                  width: 5,
                ),
                Text(
                  "${model.price}",
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 5,
                ),
                if (model.old_price != 0 && model.old_price > model.price)
                  Text(
                    "${model.old_price}",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                        fontWeight: FontWeight.bold),
                  ),
                Spacer(),
                IconButton(
                    onPressed: () {
                      loginCubit.get(context).changeFavoriteData(model.id);
                    },
                    icon: ConditionalBuilder(
                        condition:
                            loginCubit.get(context).favorit[model.id] == true,
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
            )
          ]),
    );
  }

  Widget CategoryItem(index, DataModel model) {
    return Container(
      //  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      height: 150,
      width: 150,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
              height: 150,
              width: 150,
              child: Image(
                image: NetworkImage(model.image.toString()),
                height: 150,
                width: 150,
                fit: BoxFit.cover,
              )),
          Container(
            color: Colors.black.withOpacity(0.6),
            width: double.infinity,
            height: 30,
            // alignment: Alignment.bottomCenter,
            child: Center(
              child: Text(
                model.name.toString(),
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ),
          )
        ],
      ),
    );
  }
}
