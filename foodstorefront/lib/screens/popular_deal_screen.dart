import 'package:flutter/material.dart';
import 'package:foodstorefront/models/product_model.dart';
import 'package:foodstorefront/screens/product_detail/product_detail_page.dart';
import 'package:foodstorefront/utils/colors.dart';
import 'package:foodstorefront/widgets/popular_container_widget.dart';

class PopularContentWidget extends StatefulWidget {
  final String apiEndpoint;
  final String title;

  const PopularContentWidget({
    Key? key,
    required this.apiEndpoint,
    required this.title,
  }) : super(key: key);

  @override
  State<PopularContentWidget> createState() => _PopularContentWidgetState();
}

class _PopularContentWidgetState extends State<PopularContentWidget> {
  late Future<List<Product>> _futureProducts;
  @override
  void initState() {
    super.initState();
    _futureProducts = fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Product>>(
      future: _futureProducts,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error fetching data'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No data available'));
        } else {
          List<Product> products = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
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
                      widget.title,
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                const Text(
                  "Most ordered right now",
                  style: TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 15),
                Expanded(
                  child: GridView.builder(
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 10,
                      childAspectRatio: 0.78,
                    ),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetailScreen(
                              productId: products[index].id,
                            ),
                          ),
                        ),
                        child: PopularContainerWidget(product: products[index]),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
