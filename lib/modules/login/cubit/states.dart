import 'package:shopapp/models/models.dart';

abstract class AppStates {}

class AppStateInitial extends AppStates {}

class AppStateToggleEye extends AppStates {}

class AppStateErrorLogin extends AppStates {
  String? error;
  AppStateErrorLogin({this.error});
}

class AppStateLoadingLogin extends AppStates {}

class AppStateValueLogin extends AppStates {
  ShopUser? shopState;
  AppStateValueLogin({this.shopState});
}
