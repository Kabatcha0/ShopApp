import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/component/component.dart';
import 'package:shopapp/layout/cubit/cubit..dart';
import 'package:shopapp/layout/cubit/states.dart';
import 'package:shopapp/models/catogmodel.dart';
import 'package:shopapp/models/modelofhome.dart';

class Home extends StatelessWidget {
  Home({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(listener: (context, state) {
      if (state is ShopFavStates) {
        if (!state.error!.status) {
          toast(text: "error in Auth", changeState: ToastStates.error);
        }
      }
    }, builder: (context, state) {
      return ConditionalBuilder(
        condition: ShopCubit.get(context).shopHome != null &&
            ShopCubit.get(context).category != null,
        fallback: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
        builder: (context) => buildHome(ShopCubit.get(context).shopHome!,
            context, ShopCubit.get(context).category!),
      );
    });
  }

  Widget buildHome(ShopHome shop, context, Catogries mainCategory) =>
      SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            CarouselSlider(
                items: shop.data.banners.map((e) {
                  return Image(
                    key: UniqueKey(),
                    image: NetworkImage(e.image),
                    width: double.infinity,
                    fit: BoxFit.cover,
                  );
                }).toList(),
                options: CarouselOptions(
                    height: 250,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration: const Duration(seconds: 1),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    scrollDirection: Axis.horizontal,
                    viewportFraction: 1)),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Categories",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontSize: 21),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 120,
                    child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) =>
                            catogeries(mainCategory.data.dataPage[index]),
                        separatorBuilder: (context, index) => const SizedBox(
                              width: 5,
                            ),
                        itemCount: mainCategory.data.dataPage.length),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Products",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontSize: 21),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 1 / 1.26,
                children: List.generate(shop.data.products.length,
                    (index) => product(shop.data.products[index], context)),
              ),
            )
          ],
        ),
      );
  Widget product(Products products, context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              key: UniqueKey(),
              image: NetworkImage(products.image),
              height: 150,
              width: double.infinity,
            ),
            if (products.discount != 0)
              Container(
                decoration: BoxDecoration(
                    color: Colors.red, borderRadius: BorderRadius.circular(5)),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  "Discount",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(color: Colors.white, fontSize: 14),
                ),
              )
          ],
        ),
        Text(
          products.name,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(height: 1.3),
        ),
        const Spacer(),
        Row(
          children: [
            Text(
              "${products.price}",
              style: const TextStyle(height: 1.3),
            ),
            const Spacer(),
            if (products.discount != 0)
              Text(
                "${products.oldPrice}",
                style: const TextStyle(
                    height: 1.3,
                    decoration: TextDecoration.lineThrough,
                    color: Colors.grey),
              ),
            const SizedBox(
              width: 3,
            ),
            CircleAvatar(
              radius: 20,
              child: IconButton(
                  onPressed: () {
                    ShopCubit.get(context).postFav(products.id);
                  },
                  icon: ShopCubit.get(context).favoritesById[products.id]!
                      ? const Icon(
                          Icons.favorite,
                          color: Colors.white,
                        )
                      : const Icon(
                          Icons.favorite_border,
                          color: Colors.white,
                        )),
            )
          ],
        )
      ],
    );
  }

  Widget catogeries(DataPage model) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Image(
          key: UniqueKey(),
          image: NetworkImage(model.image),
          width: 100,
          height: 120,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 3),
          width: 100,
          color: Colors.black.withOpacity(0.8),
          child: Text(
            model.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.start,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
