import 'package:flutter/material.dart';
import 'package:foodstorefront/screens/product_detail_page.dart';
import 'package:foodstorefront/utils/colors.dart';
import 'package:foodstorefront/utils/images_strings.dart';
import 'package:foodstorefront/widgets/stack_image_add_icon.dart';

class TabContentWidget extends StatelessWidget {
  final String apiEndpoint;
  final String title;

  const TabContentWidget({
    super.key,
    required this.apiEndpoint,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.local_fire_department,
                color: MyColors.red,
              ),
              Text(
                title,
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 6),
          const Text(
            "Most ordered right now",
            style: TextStyle(fontSize: 15),
          ),
          const SizedBox(height: 15),
          Expanded(
            child: GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 5,
                crossAxisSpacing: 10,
                childAspectRatio: 0.78,
              ),
              itemCount: 4, // Replace with the actual count from API
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetailScreen(
                        productId: 'Product $index',
                      ),
                    ),
                  ),
                  child: ProductContainer(
                    productName: 'Product $index',
                    productImage: ImagesStrings
                        .burgerimage2, // Replace with actual image path from API
                    productPrice: 'Rs. ${index * 100}',
                    productOldPrice: 'Rs. ${index * 120}', // Optional
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Future<Map<String, dynamic>> fetchReview() async {
//   // Simulate a network request
//   await Future.delayed(const Duration(seconds: 2));
//   return {
//     'reviewText': 'quantity was lesser than it usually is',
//     'rating': 4.0,
//     'reviewerName': 'Ayesha',
//     'timeAgo': '1 month ago',
//   };
// }

class ProductContainer extends StatelessWidget {
  final String productName;
  final String productImage;
  final String productPrice;
  final String? productOldPrice;

  const ProductContainer({
    Key? key,
    required this.productName,
    required this.productImage,
    required this.productPrice,
    this.productOldPrice,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              StackImagewithAddIcon(productImage: productImage),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        productName,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Text(
                            productPrice,
                            style: const TextStyle(
                              color: MyColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 10),
                          if (productOldPrice != null)
                            Text(
                              productOldPrice!,
                              style: const TextStyle(
                                fontSize: 12,
                                decoration: TextDecoration.lineThrough,
                                color: Colors.grey,
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
