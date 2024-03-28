part of 'home_bloc.dart';

@immutable
abstract class HomeState {} // to build the ui

abstract class HomeActionState extends HomeState {} // if I get the state I will some action (like a navigate)

class HomeInitial extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeLoadedSuccessState extends HomeState {
  List<ProductModel> products;

  HomeLoadedSuccessState({required this.products});
}

class HomeErrorState extends HomeState {}

class HomeNavigateToWishListState extends HomeActionState {}

class HomeNavigateToCartState extends HomeActionState {}

class HomeProductItemAddedToWishList extends HomeActionState{}

class HomeProductItemAddedToCart extends HomeActionState{}