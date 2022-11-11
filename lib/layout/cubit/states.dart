import 'package:shopapp/models/favmodel.dart';

abstract class ShopStates {}

class ShopInitial extends ShopStates {}

class ToogleBottomNavigation extends ShopStates {}

class ShopHomeLoading extends ShopStates {}

class ShopHomeStates extends ShopStates {}

class ShopHomeErrorState extends ShopStates {
  final String? error;
  ShopHomeErrorState({this.error});
}

class IconFavChangeState extends ShopStates {}

class ShopCatogeryLoading extends ShopStates {}

class ShopCatogeryStates extends ShopStates {}

class ShopCatogeryError extends ShopStates {
  final String? error;
  ShopCatogeryError({this.error});
}

class ShopFavStates extends ShopStates {
  final FavModel? error;
  ShopFavStates({this.error});
}

class ShopFavError extends ShopStates {
  final FavModel? error;
  ShopFavError({this.error});
}

class GetFavStates extends ShopStates {}

class GetFavError extends ShopStates {}

class GetFavLoading extends ShopStates {}

class GetProStates extends ShopStates {}

class GetProError extends ShopStates {}

class GetProLoading extends ShopStates {}

class UpdateStates extends ShopStates {}

class UpdateError extends ShopStates {}

class UpdateLoading extends ShopStates {}
