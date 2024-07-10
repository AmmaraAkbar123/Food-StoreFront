import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodstorefront/utils/colors.dart';
import 'package:foodstorefront/utils/images_strings.dart';
import 'package:foodstorefront/widgets/store_product_container.dart';
import 'package:foodstorefront/widgets/store_screen_widgets.dart';
import 'package:foodstorefront/widgets/summer_deals_widget.dart';

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
          title: _isAppBarExpanded
              ? Column(
                  children: [
                    const Text(
                      "Delivery:",
                      style: TextStyle(
                          color: MyColors.textPrimary,
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
        drawer: Drawer(), // Ensure only one drawer
        body: NotificationListener<ScrollNotification>(
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
                        Tab(text: "Popular"),
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
                TabContentWidget(apiEndpoint: 'popular', title: 'Popular'),
                SummerDealsWidget(),
                SummerDealsWidget(),
                TabContentWidget(
                    apiEndpoint: 'new_arrivals', title: 'New Arrivals'),
              ],
            ),
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
