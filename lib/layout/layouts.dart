import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/component/component.dart';
import 'package:shopapp/layout/cubit/cubit..dart';
import 'package:shopapp/layout/cubit/states.dart';
import 'package:shopapp/modules/search/search.dart';

class ShopLayout extends StatelessWidget {
  ShopLayout({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              cubit.toggleText[cubit.currentIndex],
              style: Theme.of(context).textTheme.bodyText2,
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  defaultnavigator(context, Search());
                },
              ),
            ],
          ),
          body: cubit.bottomWidget[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.category),
                label: "category",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: "Favorite",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: "Settings",
              )
            ],
            currentIndex: cubit.currentIndex,
            onTap: (value) {
              cubit.toogleBottomNavigation(value);
            },
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}
