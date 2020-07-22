import 'package:flutteronline/redux/product/productReducer.dart';
import 'package:flutteronline/redux/profile/profileReducer.dart';
import 'package:meta/meta.dart';

@immutable
class  AppState {
  final ProfileState profileState;
  final ProductState productState;

  AppState({
    this.profileState,
    this.productState
  });

  factory AppState.initial(){
    return AppState(
      profileState: ProfileState(),
      productState: ProductState(),
    );
  }
}

AppState appReducer(AppState state, dynamic action){
  return AppState(
    profileState: profileReducer(state.profileState, action),
    productState: productReducer(state.productState, action)
  );
}