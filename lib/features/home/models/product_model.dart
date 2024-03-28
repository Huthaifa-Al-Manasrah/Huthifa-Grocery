class ProductModel {
  int id;
  String image;
  double price;
  String description;
  String name;
  int quantity;

  ProductModel(
      {required this.id,
      required this.image,
      required this.price,
      required this.description,
      required this.name,
      required this.quantity});
}
