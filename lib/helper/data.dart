import 'package:coffeetest/categoryModel/category_model.dart';

/// to call list of categories.
List<CategoryModel> getCategories(){
  List<CategoryModel> category = new List<CategoryModel>();

  /// Global variable
  CategoryModel categoryModel = CategoryModel();

  ///1
  categoryModel.categoryName = "Cappuccino";
  category.add(categoryModel);

  ///2
  categoryModel = new CategoryModel();
  categoryModel.categoryName = "Espresso";
  category.add(categoryModel);

  ///3
  categoryModel = new CategoryModel();
  categoryModel.categoryName = "Ristretto";
  category.add(categoryModel);

  ///4
  categoryModel = new CategoryModel();
  categoryModel.categoryName = "Americano";
  category.add(categoryModel);

  ///5
  categoryModel = new CategoryModel();
  categoryModel.categoryName = "Latte";
  category.add(categoryModel);

  return category;
}