import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/cubit/cubit..dart';
import 'package:shopapp/layout/cubit/states.dart';
import 'package:shopapp/models/catogmodel.dart';

class Category extends StatelessWidget {
  Category({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) => defaultCategory(
                  ShopCubit.get(context).category!.data.dataPage[index],
                  context),
              separatorBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Container(
                      height: 1,
                      width: double.infinity,
                      color: Colors.grey,
                    ),
                  ),
              itemCount: ShopCubit.get(context).category!.data.dataPage.length),
        );
      },
    );
  }

  Widget defaultCategory(DataPage model, context) {
    return Row(
      children: [
        Image(
          key: UniqueKey(),
          image: NetworkImage(model.image),
          fit: BoxFit.cover,
          height: 80,
          width: 80,
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          model.name,
          style: Theme.of(context).textTheme.bodyText2,
        ),
        const Spacer(),
        IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.arrow_forward_ios,
              size: 18,
            ))
      ],
    );
  }
}
