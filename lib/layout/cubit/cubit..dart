import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/cubit/states.dart';
import 'package:shopapp/models/catogmodel.dart';
import 'package:shopapp/models/favmodel.dart';
import 'package:shopapp/models/modelgetfav.dart';
import 'package:shopapp/models/modelofhome.dart';
import 'package:shopapp/models/models.dart';
import 'package:shopapp/models/modelsetting.dart';
import 'package:shopapp/modules/category/category.dart';
import 'package:shopapp/modules/favorites/favorites.dart';
import 'package:shopapp/modules/home/home.dart';
import 'package:shopapp/modules/settings/settings.dart';
import 'package:shopapp/networks/endpoints.dart';
import 'package:shopapp/networks/remote/diohelper.dart';
import 'package:shopapp/shared/style/const.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitial());
  bool toggleFav = false;
  IconData icon = Icons.favorite_border;

  static ShopCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<String> toggleText = ["Home", "Category", "Favorite", "Settings"];
  List<Widget> bottomWidget = [Home(), Category(), Favorites(), Settings()];
  void toogleBottomNavigation(int index) {
    currentIndex = index;
    emit(ToogleBottomNavigation());
  }

  ShopHome? shopHome;
  Map<int, bool> favoritesById = {};

  void getproducts() {
    emit(ShopHomeLoading());
    DioHelper.getData(path: HOME, token: token).then((value) {
      shopHome = ShopHome.fromjson(value.data);
      shopHome!.data.products.forEach((element) {
        favoritesById.addAll({element.id: element.inFavorite});
      });
      print(favoritesById.toString());
      emit(ShopHomeStates());
    }).catchError((error) {
      emit(ShopHomeErrorState(error: error.toString()));
    });
  }

  Catogries? category;
  void getcatogery() {
    emit(ShopCatogeryLoading());
    DioHelper.getData(path: CATEGORIES).then((value) {
      category = Catogries.fromjson(value.data);
      emit(ShopCatogeryStates());
    }).catchError((onError) {
      emit(ShopCatogeryError(error: onError));
    });
  }

  FavModel? changeFavModel;
  void postFav(int productId) {
    favoritesById[productId] = !favoritesById[productId]!;
    emit(IconFavChangeState());
    DioHelper.postData(
            path: FAVORITES, data: {"product_id": productId}, token: token)
        .then((value) {
      changeFavModel = FavModel.fromjson(value.data);
      if (!changeFavModel!.status) {
        favoritesById[productId] = !favoritesById[productId]!;
      } else {
        getFavoritesByDio();
      }
      emit(ShopFavStates(error: changeFavModel));
    }).catchError((onError) {
      if (!changeFavModel!.status) {
        favoritesById[productId] = !favoritesById[productId]!;
      }
      emit(ShopFavError());
    });
  }

  GetFav? getFavorites;
  // late GetFav? getFavorites;
  void getFavoritesByDio() {
    emit(GetFavLoading());
    DioHelper.getData(path: FAVORITES, token: token).then((value) {
      getFavorites = GetFav.fromjson(value.data);
      emit(GetFavStates());
    }).catchError((onError) {
      emit(GetFavError());
    });
  }

  Profile? getSettings;
  void getProfile() {
    emit(GetProLoading());
    DioHelper.getData(path: PROFILE, token: token).then((value) {
      getSettings = Profile.fromjson(value.data);
      emit(GetProStates());
    }).catchError((onError) {
      emit(GetProError());
    });
  }

  ShopUser? shopUser;
  void updataData({
    required String name,
    required String phone,
    required String email,
  }) {
    emit(UpdateLoading());
    DioHelper.updateData(path: UPDATE, token: token, data: {
      "name": name,
      "phone": phone,
      "email": email,
    }).then((value) {
      shopUser = ShopUser.fromjson(value.data);
      getSettings = Profile.fromjson(value.data);
      emit(UpdateStates());
    }).catchError((onError) {
      emit(UpdateError());
    });
  }
}
