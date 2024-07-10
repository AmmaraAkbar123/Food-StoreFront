class Product {
  final String id;
  final String name;
  final String imageUrl;
  final String description;
  final double price;
  final double oldPrice;
  final List<ProductVariation> variations;
  final List<Product> frequentlyBoughtTogether;

  Product({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.price,
    required this.oldPrice,
    required this.variations,
    required this.frequentlyBoughtTogether,
  });
}

class ProductVariation {
  final String name;
  final double price;
  final double oldPrice;

  ProductVariation({
    required this.name,
    required this.price,
    required this.oldPrice,
  });
}
