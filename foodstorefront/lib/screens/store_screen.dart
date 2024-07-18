import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodstorefront/provider/category_provider.dart';
import 'package:foodstorefront/utils/colors.dart';
import 'package:foodstorefront/utils/images_strings.dart';
import 'package:foodstorefront/widgets/delivery_info_widget.dart';
import 'package:foodstorefront/widgets/discount_offtag_widgets.dart';
import 'package:foodstorefront/widgets/more_info_text_widget.dart';
import 'package:foodstorefront/widgets/see_reviews_widget.dart';
import 'package:provider/provider.dart';
import 'package:rect_getter/rect_getter.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({super.key});

  @override
  _StoreScreenState createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen>
    with SingleTickerProviderStateMixin {
  bool isAppBarExpanded = false;
  bool isCollapsed = false;
  late AutoScrollController scrollController;
  late TabController tabController;

  final double expandedHeight = 500.0;
  final double collapsedHeight = kToolbarHeight;

  final listViewKey = RectGetter.createGlobalKey();
  Map<int, GlobalKey<RectGetterState>> itemKeys =
      {}; // Updated to use GlobalKey<RectGetterState>

  bool pauseRectGetterIndex = false;

  @override
  void initState() {
    super.initState();
    final categoryProvider = context.read<CategoryProvider>();
    tabController = TabController(
      length: categoryProvider.categories.length,
      vsync: this,
    )..addListener(() {
        if (!tabController.indexIsChanging) {
          animateAndScrollTo(tabController.index);
        }
      });
    scrollController = AutoScrollController();
  }

  @override
  void dispose() {
    scrollController.dispose();
    tabController.dispose();
    super.dispose();
  }

  List<int> getVisibleItemsIndex() {
    Rect? rect = RectGetter.getRectFromKey(listViewKey);
    List<int> items = [];
    if (rect == null) return items;
    itemKeys.forEach((index, key) {
      Rect? itemRect = RectGetter.getRectFromKey(key);
      if (itemRect == null) return;
      if (itemRect.top > rect.bottom) return;
      if (itemRect.bottom < rect.top) return;
      items.add(index);
    });
    return items;
  }

  void onCollapsed(bool value) {
    if (this.isCollapsed == value) return;
    setState(() => this.isCollapsed = value);
  }

  bool onScrollNotification(ScrollNotification notification) {
    if (pauseRectGetterIndex) return true;
    if (notification is ScrollUpdateNotification) {
      final categoryProvider = context.read<CategoryProvider>();
      List<int> visibleItems = getVisibleItemsIndex();

      if (visibleItems.isNotEmpty) {
        int middleIndex =
            visibleItems.reduce((value, element) => value + element) ~/
                visibleItems.length;
        if (tabController.index != middleIndex) {
          tabController.animateTo(middleIndex);
        }
      }

      setState(() {
        isAppBarExpanded = notification.metrics.pixels > 200;
      });
    }
    return true;
  }

  void animateAndScrollTo(int index) {
    pauseRectGetterIndex = true;
    scrollController
        .scrollToIndex(index, preferPosition: AutoScrollPosition.begin)
        .then((_) => pauseRectGetterIndex = false);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: context.watch<CategoryProvider>().categories.length,
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
          title: isAppBarExpanded
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
              onNotification: onScrollNotification,
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
                          controller: tabController,
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
                body: ListView.builder(
                  key: listViewKey,
                  itemCount: categoryProvider.categories.length,
                  itemBuilder: (context, index) {
                    final category = categoryProvider.categories[index];
                    return AutoScrollTag(
                      key: ValueKey(index),
                      controller: scrollController,
                      index: index,
                      child: Container(
                        key: itemKeys[index] = GlobalKey<
                            RectGetterState>(), // Use GlobalKey<RectGetterState>
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              category.title,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: MyColors.black,
                              ),
                            ),
                            ...category.foods.map((food) {
                              return ListTile(
                                leading: Image.network(food.imageUrl),
                                title: Text(food.name),
                                subtitle: Text('Rs.${food.price}'),
                                trailing: Text(food.comparePrice),
                              );
                            }).toList(),
                          ],
                        ),
                      ),
                    );
                  },
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
  final TabBar _tabBar;

  _SliverAppBarDelegate(this._tabBar);

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
    return _tabBar != oldDelegate._tabBar;
  }
}
