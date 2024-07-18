import 'package:flutter/foundation.dart';
import 'package:foodstorefront/models/cateogry_model.dart';

class CategoryProvider with ChangeNotifier {
  final List<CategoryModel> _categories = ExampleData.data.categories;

  List<CategoryModel> get categories => _categories;

  void addCategory(CategoryModel category) {
    _categories.add(category);
    notifyListeners();
  }
}
