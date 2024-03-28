import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:huthifa_grocery/data/cart_items.dart';
import 'package:huthifa_grocery/data/grocery_data.dart';
import 'package:huthifa_grocery/data/wish_list_items.dart';
import 'package:huthifa_grocery/features/home/models/product_model.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  //what is it's role ? when this event happen pass this state

  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>(homeInitialEvent);
    on<HomeWishListButtonNavigateEvent>(homeWishListButtonNavigateEvent);
    on<HomeCartButtonNavigateEvent>(homeCartButtonNavigateEvent);
    on<HomeProductCartButtonEvent>(homeProductCartButtonEvent);
    on<HomeProductWishListButtonEvent>(homeProductWishListButtonEvent);
  }

  FutureOr<void> homeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());

    ///API calling
    await Future.delayed(const Duration(seconds: 3));
    emit(HomeLoadedSuccessState(
        products: GroceryData.groceryDate
            .map((e) => ProductModel(
                id: e['id'],
                image: e['image'],
                price: e['price'],
                description: e['description'],
                name: e['name'],
                quantity: e['quantity']))
            .toList()));
  }

  FutureOr<void> homeWishListButtonNavigateEvent(
      HomeWishListButtonNavigateEvent event, Emitter<HomeState> emit) {
    print('wish list clicked');
    emit(HomeNavigateToWishListState());
  }

  FutureOr<void> homeCartButtonNavigateEvent(
      HomeCartButtonNavigateEvent event, Emitter<HomeState> emit) {
    print('cart clicked');
    emit(HomeNavigateToCartState());
  }

  FutureOr<void> homeProductCartButtonEvent(HomeProductCartButtonEvent event, Emitter<HomeState> emit) {
    print('the product cart clicked');
    CartItems.add(event.cartProduct);
    emit(HomeProductItemAddedToCart());
  }

  FutureOr<void> homeProductWishListButtonEvent(HomeProductWishListButtonEvent event, Emitter<HomeState> emit) {
    print('the product wish list clicked');
    WishListItems.add(event.wishListProduct);
    emit(HomeProductItemAddedToWishList());
  }
}
