import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/cubit/cubit..dart';
import 'package:shopapp/layout/cubit/states.dart';
import 'package:shopapp/layout/layouts.dart';
import 'package:shopapp/modules/login/cubit/cubit.dart';
import 'package:shopapp/modules/login/cubit/states.dart';
import 'package:shopapp/modules/login/login.dart';
import 'package:shopapp/modules/onboard.dart';
import 'package:shopapp/modules/register/cubit/cubit.dart';
import 'package:shopapp/modules/search/cubit/cubit.dart';
import 'package:shopapp/networks/local/chachehelper.dart';
import 'package:shopapp/networks/remote/diohelper.dart';
import 'package:shopapp/shared/style/const.dart';
import 'package:shopapp/shared/style/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  Widget stateOfApp;
  token = CacheHelper.getData(key: "token");
  bool? onBoardState = CacheHelper.getData(key: "onboard");
  if (onBoardState != null) {
    if (token != null) {
      stateOfApp = ShopLayout();
    } else {
      stateOfApp = Login();
    }
  } else {
    stateOfApp = OnBoard();
  }

  runApp(MyApp(
    stateOfApp: stateOfApp,
  ));
}

class MyApp extends StatelessWidget {
  final Widget stateOfApp;
  MyApp({super.key, required this.stateOfApp});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ShopCubit()
            ..getproducts()
            ..getcatogery()
            ..getFavoritesByDio()
            ..getProfile(),
        ),
        BlocProvider(
          create: (context) => AppCubit(),
        ),
        BlocProvider(
          create: (context) => RegisterCubit(),
        ),
        BlocProvider(
          create: (context) => SearchCubit(),
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        builder: (context, state) => MaterialApp(
          theme: theme,
          darkTheme: darkTheme,
          themeMode: ThemeMode.light,
          debugShowCheckedModeBanner: false,
          home: stateOfApp,
        ),
        listener: (context, state) {},
      ),
    );
  }
}
