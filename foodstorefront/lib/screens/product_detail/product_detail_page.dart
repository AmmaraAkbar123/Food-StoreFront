import 'package:flutter/material.dart';
import 'package:foodstorefront/models/product_model.dart';
import 'package:foodstorefront/utils/colors.dart';
import 'package:foodstorefront/widgets/product_detail_widgets/cancel_button_widget.dart';
import 'package:foodstorefront/widgets/product_detail_widgets/frequent_bought_widget.dart';
import 'package:foodstorefront/widgets/product_detail_widgets/product_detail_section_widget.dart';
import 'package:foodstorefront/widgets/product_detail_widgets/select_menu_section_widget.dart';
import 'package:foodstorefront/widgets/product_detail_widgets/remove_order_section_widget.dart';
import 'package:foodstorefront/widgets/product_detail_widgets/special_instruction.dart';

class ProductDetailScreen extends StatefulWidget {
  final String productId;

  const ProductDetailScreen({super.key, required this.productId});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  late Future<Product> _productFuture;
  int _quantity = 1;

  @override
  void initState() {
    super.initState();
    _productFuture = fetchProductDetails(widget.productId);
  }

  void _incrementQuantity() {
    setState(() {
      _quantity++;
    });
  }

  void _decrementQuantity() {
    setState(() {
      if (_quantity > 1) _quantity--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Product>(
        future: _productFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading product details'));
          } else if (snapshot.hasData) {
            final product = snapshot.data!;
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 300.0,
                  floating: false,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Image.asset(
                      product.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Center(
                          child: Icon(
                            Icons.error,
                            color: Colors.red,
                            size: 50,
                          ),
                        );
                      },
                    ),
                  ),
                  leading: CustomCancelButton(
                    size: 50, // Adjust the size as needed
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
                        const SizedBox(height: 15),
                        // Dynamically add SelectMenuSection widgets
                        ...product.variations.map((variation) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: SelectMenuSection(
                              product: product,
                              variation: variation,
                            ),
                          );
                        }).toList(),

                        //frequently bought together///
                        const SizedBox(height: 20),
                        FrequentlyBoughtTogetherSection(
                          product: product,
                        ),
                        const SizedBox(height: 10),
                        Divider(
                          color: MyColors.grey,
                        ),
                        const SizedBox(height: 10),

                        /// special instruction textfield
                        SpecialInstructionSection(),
                        SizedBox(
                          height: 20,
                        ),

                        ///remove from my order section
                        RemoveFromOrderSection(),
                        SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: Text('No product data available'));
          }
        },
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: MyColors.grey),
          ),
          child: BottomAppBar(
            height: 95,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: MyColors.grey),
                    child: IconButton(
                      onPressed: _decrementQuantity,
                      icon: Icon(
                        Icons.remove,
                        color: MyColors.white,
                      ),
                    ),
                  ),
                  Text(
                    '$_quantity',
                    style: TextStyle(fontSize: 20),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: MyColors.primary),
                    child: IconButton(
                      onPressed: _incrementQuantity,
                      icon: Icon(Icons.add),
                    ),
                  ),
                  Container(
                    width: 180,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    decoration: BoxDecoration(
                      color: MyColors.grey,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        'Add to Cart',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
