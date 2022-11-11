import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/component/component.dart';
import 'package:shopapp/layout/cubit/cubit..dart';
import 'package:shopapp/models/searchmodel.dart';
import 'package:shopapp/modules/search/cubit/cubit.dart';
import 'package:shopapp/modules/search/cubit/states.dart';

class Search extends StatelessWidget {
  TextEditingController search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchCubit, SearchStates>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  defaultTextFormField(
                      icon: Icons.search,
                      isSuffix: false,
                      text: "Search",
                      type: TextInputType.text,
                      control: search,
                      change: (String value) {
                        SearchCubit.get(context).searchFromApi(value);
                      }),
                  const SizedBox(
                    height: 7,
                  ),
                  if (state is SearchEmitLoading)
                    const LinearProgressIndicator(),
                  const SizedBox(
                    height: 7,
                  ),
                  if (state is SearchEmitState)
                    Expanded(
                      child: ListView.separated(
                          itemBuilder: (context, index) => searchProduct(
                              context,
                              SearchCubit.get(context)
                                  .getSearch!
                                  .data
                                  .dataSearch[index]),
                          separatorBuilder: (context, index) => Container(
                                height: 1,
                                color: Colors.grey,
                                width: double.infinity,
                              ),
                          itemCount: SearchCubit.get(context)
                              .getSearch!
                              .data
                              .dataSearch
                              .length),
                    )
                ],
              ),
            ),
          );
        },
        listener: (context, state) => {});
  }

  Widget searchProduct(context, DataSearch model) {
    return SizedBox(
      height: 150,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                key: UniqueKey(),
                image: NetworkImage(model.image),
                height: 140,
                width: 100,
              ),
              if (model.discount != 0 && model.discount == null)
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
                  model.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(height: 1.3),
                ),
                const Spacer(),
                Row(
                  children: [
                    Text(
                      "${model.price}",
                      style: const TextStyle(height: 1.3),
                    ),
                    const Spacer(),
                    if (model.discount != 0 && model.discount != null)
                      Text(
                        "${model.oldPrice}",
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
                            ShopCubit.get(context).postFav(model.id);
                          },
                          icon: ShopCubit.get(context).favoritesById[model.id]!
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
