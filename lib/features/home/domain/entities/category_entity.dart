class CategoryEntity {
  List<CategoryListEntity> categoryList;

  CategoryEntity({this.categoryList = const []});
}

class CategoryListEntity {
  String name;
  String image;
  String slug;

  CategoryListEntity({this.name = '', this.image = '', this.slug = ''});
}
