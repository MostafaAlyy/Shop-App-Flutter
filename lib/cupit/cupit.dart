import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/models/FaoriteModel.dart';
import 'package:shop_app/models/HomeModel.dart';
import 'package:shop_app/models/LoginModel.dart';
import 'package:shop_app/models/SerchModel.dart';
import 'package:shop_app/screens/home/catigoresScr.dart';
import 'package:shop_app/screens/home/favoriteScr.dart';
import 'package:shop_app/screens/home/productScr.dart';
import 'package:shop_app/screens/home/settingsScr.dart';
import 'package:shop_app/shared/network/local/sharedPreferns.dart';
import 'package:shop_app/shared/network/remote/diohelper.dart';
import '../models/CategoriesModel.dart';
import '../models/profileModel.dart';
import './states.dart';

class loginCubit extends Cubit<ShopStates> {
  loginCubit() : super(LoginInitialState());

  UloginModel? loginmodel;

  static loginCubit get(BuildContext context) => BlocProvider.of(context);

  void userLogin({required String email, required String password}) async {
    // emit(LoginLoadingState());
    print('try login $email');
    DioHelper.postData(
        url: "/login",
        data: {'email': '${email}', 'password': '${password}'}).then((value) {
      print(value.data);
      print(' logiiiiiiin');
      loginmodel = UloginModel.fromJson(value.data);
      print(loginmodel?.message);
      emit(LoginSucseesState(loginmodel: loginmodel));
    }).catchError((error) {
      print("error :-" + error.toString());
      //   emit(LoginEroeeState(error.toString()));
    });
  }

  void userRegister(
      {required String email,
      required String password,
      required String phone,
      required String name}) async {
    // emit(LoginLoadingState());
    print('try register $email');
    DioHelper.postData(url: "/register", data: {
      'email': '${email}',
      'password': '${password}',
      'name': name,
      'phone': phone
    }).then((value) {
      print(value.data);
      print(' register');
      loginmodel = UloginModel.fromJson(value.data);
      print(loginmodel?.message);
      emit(LoginSucseesState(loginmodel: loginmodel));
    }).catchError((error) {
      print("error :-" + error.toString());
      //   emit(LoginEroeeState(error.toString()));
    });
  }

  IconData loginSuffix = Icons.visibility_outlined;
  bool isPassowrdShown = true;
  void changeShonPass() {
    isPassowrdShown = !isPassowrdShown;
    (isPassowrdShown)
        ? loginSuffix = Icons.visibility_outlined
        : loginSuffix = Icons.visibility_off_outlined;
    emit(LoginPassVisabltiCHangedState());
  }

  int currentindex = 0;

  List<Widget> views = [
    ProductScreen(),
    CategorisScreen(),
    FavoritScreen(),
    SettingScreen(),
  ];
  void changeCurrentIndex(index) {
    currentindex = index;
    emit(ChangeBottomNavBarState());
  }

  HomeModel? homeModel;
  Map<int, bool> favorit = {};
  void getHomeData() {
    emit(ShopHomeLoadingState());
    DioHelper.getData(url: "/home", token: CashHelper.getData(key: "token"))
        .then((value) {
      homeModel = HomeModel.fromjson(value.data);
      homeModel!.data!.products.forEach(
        (element) {
          favorit.addAll({element.id: element.in_favorites});
        },
      );
      // print(homeModel?.data?.banners[0].toString());
      //  print(homeModel?.status);
      emit(ShopHomeSucsesaState());
    }).catchError((onError) {
      print(onError);
      emit(ShopHomeErorrState());
    });
  }

  CategoriesModel? CategoryModel;
  void getCategoryData() {
    emit(ShopHomeLoadingState());
    DioHelper.getData(
      url: "/categories",
    ).then((value) {
      CategoryModel = CategoriesModel.fromjson(value.data);
      print(CategoryModel?.status);
      emit(ShopHomeSucsesaState());
    }).catchError((onError) {
      print(onError);
      emit(ShopHomeErorrState());
    });
  }

  void changeFavoriteData(int id) {
    if (favorit[id] == false)
      favorit[id] = true;
    else
      favorit[id] = false;
    emit(ChangeFavoriteSucsesaState());

    DioHelper.postData(
      data: {'product_id': id},
      url: "/favorites",
      token: CashHelper.getData(key: "token"),
    ).then((value) {
      getFav();
      emit(ChangeFavoriteSucsesaState());
    }).catchError((onError) {
      print(onError);
      emit(ChangeFavoriteErorrState());
    });
  }

  FavoritsModel? favpro;
  void getFav() {
    DioHelper.getData(
      url: "/favorites",
      token: CashHelper.getData(key: "token"),
    ).then((value) {
      favpro = FavoritsModel.fromJson(value.data);
      emit(ChangeFavoriteSucsesaState());
    }).catchError((onError) {
      print(onError);
      emit(ChangeFavoriteErorrState());
    });
  }

  profileModel? profile;

  void getProfile() {
    emit(profileLoadingState());
    DioHelper.getData(url: '/profile', token: CashHelper.getData(key: "token"))
        .then((value) {
      profile = profileModel.fromJson(value.data);
      print(profile!.data!.name);
      emit(profileSucsesaState());
    }).catchError((onError) {
      print(onError.toString());
      emit(profileErorrState());
    });
  }

  SearchModel? searchModel;
  void getserch(String v) {
    DioHelper.postData(url: '/products/search', data: {'text': v})
        .then((value) {
      searchModel = SearchModel.fromJson(value.data);
      print(searchModel!.data!.data);
      emit(SearchSucsesaState());
    }).catchError((onError) {
      print(onError.toString());
    });
  }
}
