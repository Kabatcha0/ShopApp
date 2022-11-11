import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/cubit/cubit..dart';
import 'package:shopapp/layout/cubit/states.dart';
import 'package:shopapp/models/modelgetfav.dart';

class Favorites extends StatelessWidget {
  Favorites({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        builder: (context, state) {
          return ConditionalBuilder(
              condition: state is! GetFavLoading &&
                  ShopCubit.get(context).getFavorites != null &&
                  ShopCubit.get(context).favoritesById.isNotEmpty,
              builder: (context) => Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) => defaultFavorites(
                            ShopCubit.get(context)
                                .getFavorites!
                                .data
                                .data1[index],
                            context),
                        separatorBuilder: (context, index) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: Container(
                                height: 1,
                                width: double.infinity,
                                color: Colors.grey,
                              ),
                            ),
                        itemCount: ShopCubit.get(context)
                            .getFavorites!
                            .data
                            .data1
                            .length),
                  ),
              fallback: (context) => const Center(
                    child: CircularProgressIndicator(),
                  ));
        },
        listener: (context, state) {});
  }

  Widget defaultFavorites(ListOfData model, context) {
    return Container(
      height: 150,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                key: UniqueKey(),
                image: NetworkImage(model.product.image),
                height: 140,
                width: 100,
              ),
              if (model.product.discount != 0)
                Container(
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(5)),
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
          const SizedBox(
            width: 5,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.product.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(height: 1.3),
                ),
                const Spacer(),
                Row(
                  children: [
                    Text(
                      "${model.product.price}",
                      style: const TextStyle(height: 1.3),
                    ),
                    const Spacer(),
                    if (model.product.discount != 0)
                      Text(
                        "${model.product.oldPrice}",
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
                            ShopCubit.get(context).postFav(model.product.id);
                          },
                          icon: ShopCubit.get(context)
                                  .favoritesById[model.product.id]!
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
            ),
          )
        ],
      ),
    );
  }
}
