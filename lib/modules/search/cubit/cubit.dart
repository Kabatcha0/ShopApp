import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/models/searchmodel.dart';
import 'package:shopapp/modules/search/cubit/states.dart';
import 'package:shopapp/networks/endpoints.dart';
import 'package:shopapp/networks/remote/diohelper.dart';
import 'package:shopapp/shared/style/const.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());
  static SearchCubit get(context) => BlocProvider.of(context);
  SearchModel? getSearch;
  void searchFromApi(String text) {
    emit(SearchEmitLoading());
    DioHelper.postData(path: SEARCH, token: token, data: {"text": text})
        .then((value) {
      getSearch = SearchModel.fromjson(value.data);
      emit(SearchEmitState());
    }).catchError((onError) {
      emit(SearchEmitError());
    });
  }
}
