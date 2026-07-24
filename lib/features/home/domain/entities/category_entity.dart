class CategoryEntity {
  List<CategoryListEntity> categoryList;

  CategoryEntity({this.categoryList = const []});
}

class CategoryListEntity {
  String name;
  String image;

  CategoryListEntity({this.name = '', this.image = ''});
}
