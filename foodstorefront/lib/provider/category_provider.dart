import 'package:flutter/material.dart';
import 'package:foodstorefront/models/cateogry_model.dart';

class CategoryProvider with ChangeNotifier {
  List<Category> _categories = [
    Category(id: '1', title: 'Popular'),
    Category(id: '2', title: 'Summer Deals'),
    Category(id: '3', title: 'Favourite Deal'),
    Category(id: '4', title: 'New Arrivals'),
  ];

  List<Category> get categories => _categories;

  void addCategory(Category category) {
    _categories.add(category);
    notifyListeners();
  }
}
