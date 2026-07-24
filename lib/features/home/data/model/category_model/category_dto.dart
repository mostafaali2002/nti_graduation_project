class CategoryDto {
  List<CategoryList>? categoryList;

  CategoryDto({this.categoryList});

  CategoryDto.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      categoryList = [];
      json['list'].forEach((v) {
        categoryList!.add(new CategoryList.fromJson(v));
      });
    }
  }
}

class CategoryList {
  String? name;
  String? image;

  CategoryList({this.name, this.image});

  CategoryList.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
  }
}
