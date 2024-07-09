import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodstorefront/utils/colors.dart';
import 'package:foodstorefront/utils/images_strings.dart';
import 'package:foodstorefront/widgets/store_screen_widgets.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4, // Number of tabs, you can fetch this dynamically
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          iconTheme: const IconThemeData(color: MyColors.primary),
          backgroundColor: Colors.white, // Ensure the background color is set
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarBrightness: Brightness.light, // For iOS: (dark icons)
            statusBarIconBrightness:
                Brightness.dark, // For Android: (dark icons)
            statusBarColor: Colors.white,
          ),
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 18),
              child: Row(
                children: [
                  Icon(Icons.favorite_outline),
                  SizedBox(width: 12),
                  Icon(Icons.share_outlined),
                  SizedBox(width: 12),
                  Icon(Icons.search_outlined)
                ],
              ),
            )
          ],
        ),
        drawer: Drawer(), // Ensure only one drawer
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.asset(
                              ImagesStrings.optpLogo,
                              height: 56,
                              width: 55,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 15),
                          const Text(
                            "OPTP - Johar Town",
                            style: TextStyle(
                                color: MyColors.textPrimary,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      MoreInfo(),
                      const SizedBox(height: 15),
                      SeeReviews(),
                      const SizedBox(height: 10),
                      DeliveryInfo(),
                      const SizedBox(height: 10),
                      AvailableDeals(),
                      const SizedBox(height: 10),
                      DiscountOffTag(),
                    ],
                  ),
                ),
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate: _SliverAppBarDelegate(
                  TabBar(
                    labelColor: MyColors.primary,
                    unselectedLabelColor: Colors.grey,
                    tabs: [
                      Tab(text: "Popular"), // Fetch tab titles dynamically
                      Tab(text: "Summer Deals"),
                      Tab(text: "Favourite Deal"),
                      Tab(text: "New Arrivals"),
                    ],
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(
            children: [
              TabContentWidget(
                  apiEndpoint: 'popular'), // Fetch data dynamically
              TabContentWidget(apiEndpoint: 'summer_deals'),
              TabContentWidget(apiEndpoint: 'favourite_deal'),
              TabContentWidget(apiEndpoint: 'new_arrivals'),
            ],
          ),
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}

class TabContentWidget extends StatelessWidget {
  final String apiEndpoint;

  const TabContentWidget({super.key, required this.apiEndpoint});

  @override
  Widget build(BuildContext context) {
    // Fetch data from API using apiEndpoint
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            //  mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.bug_report,
                color: Colors.orange,
              ),
              Text(
                "Popular",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Most ordered right now",
            style: TextStyle(
              fontSize: 15,
            ),
          ),
          GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 0.75,
            ),
            itemCount: 10, // Replace with the actual count from API
            itemBuilder: (context, index) {
              return ProductContainer(
                productName: 'Product $index',
                productImage:
                    'path_to_image', // Replace with actual image path from API
                productPrice: 'Rs. ${index * 100}',
                productOldPrice: 'Rs. ${index * 120}', // Optional
              );
            },
          ),
        ],
      ),
    );
  }
}

class ProductContainer extends StatelessWidget {
  final String productName;
  final String productImage;
  final String productPrice;
  final String? productOldPrice;

  const ProductContainer({
    super.key,
    required this.productName,
    required this.productImage,
    required this.productPrice,
    this.productOldPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(8.0)),
              child: Image.asset(
                "assets/images/cricket_deal_2.jpg",
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
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
                    SizedBox(
                      width: 10,
                    ),
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
        ],
      ),
    );
  }
}
