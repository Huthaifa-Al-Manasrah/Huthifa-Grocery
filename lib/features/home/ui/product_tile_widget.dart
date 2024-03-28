import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:huthifa_grocery/features/home/bloc/home_bloc.dart';
import 'package:huthifa_grocery/features/home/models/product_model.dart';

class ProductTileWidget extends StatelessWidget {
  final HomeBloc homeBloc;
  final ProductModel productModel;
  const ProductTileWidget({Key? key, required this.productModel, required this.homeBloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 2,
      clipBehavior: Clip.hardEdge,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
      //set border radius more than 50% of height and width to make circle
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.network(productModel.image, fit: BoxFit.cover, height: 200),
          const Divider(endIndent: 50, indent: 50, thickness: 2),
          Text(productModel.name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
          Text(productModel.description, style: const TextStyle(fontSize: 13)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('\$ ${productModel.price}', style: const TextStyle(fontSize: 15),),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(onPressed: (){
                    homeBloc.add(HomeProductCartButtonEvent(cartProduct: productModel));
                  }, icon: const Icon(Icons.add_shopping_cart)),
                  IconButton(onPressed: (){
                    homeBloc.add(HomeProductWishListButtonEvent(wishListProduct: productModel));
                  }, icon: const Icon(Icons.favorite_border)),
                ],
              )
            ],
          ),
          const SizedBox(height: 10,)
        ],
      ),
    );
  }
}
