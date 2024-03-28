part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class HomeInitialEvent extends HomeEvent {}

class HomeProductWishListButtonEvent extends HomeEvent {
  final ProductModel wishListProduct;

  HomeProductWishListButtonEvent({required this.wishListProduct});
}

class HomeProductCartButtonEvent extends HomeEvent {
  final ProductModel cartProduct;

  HomeProductCartButtonEvent({required this.cartProduct});
}

class HomeWishListButtonNavigateEvent extends HomeEvent {}

class HomeCartButtonNavigateEvent extends HomeEvent {}
