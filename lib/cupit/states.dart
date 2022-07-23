import 'package:shop_app/models/LoginModel.dart';

abstract class ShopStates {}

class LoginInitialState extends ShopStates {}

class LoginLoadingState extends ShopStates {}

class LoginSucseesState extends ShopStates {
  UloginModel? loginmodel;
  LoginSucseesState({this.loginmodel});
}

class LoginEroeeState extends ShopStates {
  final String error;
  LoginEroeeState(this.error);
}

class LoginPassVisabltiCHangedState extends ShopStates {}

class ChangeBottomNavBarState extends ShopStates {}

class ShopHomeLoadingState extends ShopStates {}

class ShopHomeSucsesaState extends ShopStates {}

class ShopHomeErorrState extends ShopStates {}

class profileLoadingState extends ShopStates {}

class profileSucsesaState extends ShopStates {}

class profileErorrState extends ShopStates {}

class SearchSucsesaState extends ShopStates {}

class SearchErorrState extends ShopStates {}

class SearchLoadingState extends ShopStates {}

class ChangeFavoriteErorrState extends ShopStates {}

class ChangeFavoriteSucsesaState extends ShopStates {}
