import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/models/registermodel.dart';
import 'package:shopapp/modules/register/cubit/states.dart';
import 'package:shopapp/networks/endpoints.dart';
import 'package:shopapp/networks/remote/diohelper.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());
  static RegisterCubit get(context) => BlocProvider.of(context);
  bool change = false;
  IconData eye = Icons.visibility_off;
  void changeEye() {
    change = !change;
    eye = change ? Icons.visibility : Icons.visibility_off;
    emit(ChangeEyeState());
  }

  RegisterParse? registerToApi;
  void postRegister(
      {required String name,
      required String phone,
      required String email,
      required String password}) {
    emit(RegisterLoadingState());
    DioHelper.postData(path: REGISTER, data: {
      "name": name,
      "phone": phone,
      "email": email,
      "password": password
    }).then((value) {
      registerToApi = RegisterParse.fromjson(value.data);
      emit(RegisterDoneState(registerFromApi: registerToApi));
    }).catchError((onError) {
      emit(RegisterErrorsState());
    });
  }
}
