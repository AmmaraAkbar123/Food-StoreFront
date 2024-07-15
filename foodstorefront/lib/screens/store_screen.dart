import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodstorefront/models/review_model.dart';
import 'package:foodstorefront/provider/category_provider.dart';
import 'package:foodstorefront/screens/favorite_screen.dart';
import 'package:foodstorefront/screens/popular_deal_screen.dart';
import 'package:foodstorefront/utils/colors.dart';
import 'package:foodstorefront/utils/images_strings.dart';
import 'package:foodstorefront/widgets/delivery_info_widget.dart';
import 'package:foodstorefront/widgets/discount_offtag_widgets.dart';
import 'package:foodstorefront/widgets/more_info_text_widget.dart';
import 'package:foodstorefront/widgets/see_reviews_widget.dart';
import 'package:foodstorefront/widgets/summer_deals_widget.dart';
import 'package:provider/provider.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({super.key});

  @override
  _StoreScreenState createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  bool _isAppBarExpanded = false;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: context.read<CategoryProvider>().categories.length,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          iconTheme: const IconThemeData(color: MyColors.primary),
          backgroundColor: MyColors.white,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.dark,
            statusBarColor: Colors.white,
          ),
          title: _isAppBarExpanded
              ? const Column(
                  children: [
                    Text(
                      "Delivery",
                      style: TextStyle(
                          color: MyColors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w700),
                    ),
                    Text("10-25 min",
                        style: TextStyle(color: MyColors.primary, fontSize: 12))
                  ],
                )
              : null,
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
        drawer: const Drawer(),
        body: Consumer<CategoryProvider>(
          builder: (context, categoryProvider, child) {
            return NotificationListener<ScrollNotification>(
              onNotification: (scrollNotification) {
                if (scrollNotification is ScrollUpdateNotification) {
                  setState(() {
                    _isAppBarExpanded = scrollNotification.metrics.pixels > 200;
                  });
                }
                return true;
              },
              child: NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
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
                                      color: MyColors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            const MoreInfo(),
                            const SizedBox(height: 15),
                            const SeeReviews(),
                            const SizedBox(height: 10),
                            const DeliveryInfo(),
                            const SizedBox(height: 15),
                            const AvailableDeals(),
                          ],
                        ),
                      ),
                    ),
                    SliverPersistentHeader(
                      pinned: true,
                      delegate: _SliverAppBarDelegate(
                        TabBar(
                          tabAlignment: TabAlignment.start,
                          isScrollable: true,
                          labelStyle: const TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 13),
                          indicatorColor: MyColors.primary,
                          labelColor: MyColors.primary,
                          unselectedLabelColor: MyColors.black,
                          tabs: categoryProvider.categories
                              .map((category) => Tab(text: category.title))
                              .toList(),
                        ),
                      ),
                    ),
                  ];
                },
                body: TabBarView(
                  children: categoryProvider.categories.map((category) {
                    switch (category.id) {
                      case '1':
                        return const PopularContentWidget(
                            apiEndpoint: 'popular', title: 'Popular');
                      case '2':
                        return const SummerDealsWidget();
                      case '3':
                        return FavoriteScreen(
                          reviews: reviews,
                        );
                      case '4':
                        return const PopularContentWidget(
                            apiEndpoint: 'new_arrivals', title: 'New Arrivals');
                      default:
                        return const Center(child: Text('Unknown category'));
                    }
                  }).toList(),
                ),
              ),
            );
          },
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
      color: MyColors.white,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
