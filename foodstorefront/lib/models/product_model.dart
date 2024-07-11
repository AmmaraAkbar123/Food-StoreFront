import 'package:foodstorefront/utils/images_strings.dart';

class Product {
  final String id;
  final String name;
  final String imageUrl;
  final String description;
  final double price;
  final double? oldPrice;
  final bool isPopular;

  final List<ProductVariation> variations;
  final List<Product> frequentlyBoughtTogether;

  Product({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.price,
    this.isPopular = false,
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

//// popular deals data///////////
///
Future<List<Product>> fetchProducts() async {
  // Simulate fetching data from an API after 2 seconds delay
  await Future.delayed(Duration(seconds: 2));

  // Replace with actual API call to fetch products
  return [
    Product(
      id: '1',
      name: 'Burger',
      imageUrl: ImagesStrings.burgerimage2,
      description: 'Delicious burger with cheese ',
      price: 100,
      oldPrice: 120,
      isPopular: true,
      variations: [],
      frequentlyBoughtTogether: [],
    ),
    Product(
      id: '2',
      name: 'Pizza',
      imageUrl: ImagesStrings.burgerimage2,
      description: 'Pepperoni pizza with extra cheese',
      price: 200,
      oldPrice: 220,
      variations: [],
      frequentlyBoughtTogether: [],
    ),
    Product(
      id: '3',
      name: 'Fries',
      imageUrl: ImagesStrings.burgerimage,
      description: 'Crispy fries with ketchup',
      price: 50,
      variations: [],
      frequentlyBoughtTogether: [],
      oldPrice: 80,
    ),
    Product(
      id: '4',
      name: 'Ice Cream',
      imageUrl: ImagesStrings.burgerimage2,
      description: 'Vanilla ice cream with chocolate syrup',
      price: 80,
      variations: [],
      frequentlyBoughtTogether: [],
      oldPrice: 90,
    ),
  ];
}

///// summerdeals data ////////////
Future<List<Product>> fetchSummerDeals() async {
  // Simulate fetching summer deals from an API
  await Future.delayed(const Duration(seconds: 2));
  return List.generate(4, (index) {
    return Product(
      id: 'deal-$index',
      name: 'Summer Deal $index',
      imageUrl: ImagesStrings.burgerimage,
      description:
          'Description for summer deal Pepperoni pizza with extra cheese gfrdhtgf hfhgf thftfy sewsetr juhkujhjk $index',
      price: 99.99 + index,
      oldPrice: 119.99 + index,
      isPopular: index % 2 == 0,
      variations: [],
      frequentlyBoughtTogether: [],
    );
  });
}
