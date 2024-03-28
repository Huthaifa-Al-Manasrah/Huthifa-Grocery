import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:huthifa_grocery/features/cart/ui/cart_screen.dart';
import 'package:huthifa_grocery/features/home/bloc/home_bloc.dart';
import 'package:huthifa_grocery/features/home/ui/product_tile_widget.dart';
import 'package:huthifa_grocery/features/wish_list/ui/wish_list_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeBloc _homeBloc = HomeBloc();

  @override
  void initState() {
    _homeBloc.add(HomeInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: _homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        if (state is HomeNavigateToWishListState) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const WishListScreen()));
        } else if (state is HomeNavigateToCartState) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const CartScreen()));
        } else if (state is HomeProductItemAddedToWishList) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('product added to wish list'),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height - 100,
                right: 20,
                left: 20),
          ));
        } else if (state is HomeProductItemAddedToCart) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('product added to cart'),
              backgroundColor: Colors.green,
              behavior: SnackBarBehavior.floating,
              margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height - 100,
                  right: 20,
                  left: 20),
            ),
          );
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case HomeLoadingState:
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          case HomeErrorState:
            return const Scaffold(
              body: Center(
                child: Icon(Icons.error, color: Colors.red),
              ),
            );
          case HomeLoadedSuccessState:
            final successState = state as HomeLoadedSuccessState;
            return Scaffold(
              appBar: AppBar(
                title: const Text('Huthifa Grocery'),
                actions: [
                  IconButton(
                      icon: const Icon(Icons.favorite),
                      onPressed: () {
                        _homeBloc.add(HomeWishListButtonNavigateEvent());
                      }),
                  IconButton(
                      icon: const Icon(Icons.shopping_cart),
                      onPressed: () {
                        _homeBloc.add(HomeCartButtonNavigateEvent());
                      }),
                ],
              ),
              body: ListView.builder(
                itemCount: successState.products.length,
                itemBuilder: (context, index) {
                  return ProductTileWidget(
                      homeBloc: _homeBloc,
                      productModel: successState.products[index]);
                },
              ),
            );
          default:
            return SizedBox.shrink();
        }
      },
    );
  }
}
