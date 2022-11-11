import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/models/models.dart';
import 'package:shopapp/modules/login/cubit/states.dart';
import 'package:shopapp/networks/endpoints.dart';

import '../../../networks/remote/diohelper.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppStateInitial());
  static AppCubit get(context) => BlocProvider.of(context);
  late IconData change = Icons.visibility_off;
  ShopUser? shopUser;
  bool changeEye = false;
  void toogleEye() {
    changeEye = !changeEye;
    change = changeEye ? Icons.visibility : Icons.visibility_off;
    emit(AppStateToggleEye());
  }

  void login({required String email, required String pass}) {
    emit(AppStateLoadingLogin());
    DioHelper.postData(path: LOGIN, data: {
      "email": email,
      "password": pass,
    }).then((value) {
      shopUser = ShopUser.fromjson(value.data);
      emit(AppStateValueLogin(shopState: shopUser));
    }).catchError((onError) {
      emit(AppStateErrorLogin(error: onError.toString()));
    });
  }
}
