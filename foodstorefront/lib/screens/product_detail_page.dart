import 'package:flutter/material.dart';
import 'package:foodstorefront/widgets/product_detail_widget.dart';
import 'package:foodstorefront/models/product_model.dart';

class ProductDetailScreen extends StatelessWidget {
  final String productId;

  const ProductDetailScreen({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: fetchProductDetails(productId), // Placeholder for API call
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading product details'));
          } else {
            final product = snapshot.data;
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 300.0,
                  floating: false,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Image.network(
                      product!.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                  leading: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ProductTitleSection(product: product),
                        const SizedBox(height: 20),
                        ProductVariationSection(product: product),
                        const SizedBox(height: 20),
                        FrequentlyBoughtTogetherSection(product: product),
                        const SizedBox(height: 20),
                        AddToCartSection(product: product),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  Future<Product> fetchProductDetails(String productId) async {
    // Placeholder for API call
    await Future.delayed(const Duration(seconds: 2));
    return Product(
      id: productId,
      name: 'Kofta Chanay',
      imageUrl: 'https://example.com/kofta_chanay.jpg',
      description: 'Single/Double',
      price: 192.0,
      oldPrice: 240.0,
      variations: [
        ProductVariation(name: 'Single', price: 192.0, oldPrice: 240.0),
        ProductVariation(name: 'Double', price: 384.0, oldPrice: 480.0),
      ],
      frequentlyBoughtTogether: [
        Product(
          id: '1',
          name: 'Paratha',
          imageUrl: 'https://example.com/paratha.jpg',
          price: 50.0,
          description: '',
          oldPrice: 66,
          variations: [],
          frequentlyBoughtTogether: [],
        ),
        // Product(
        //   id: '2',
        //   name: 'Raita',
        //   imageUrl: 'https://example.com/raita.jpg',
        //   price: 30.0,
        // ),
      ],
    );
  }
}
