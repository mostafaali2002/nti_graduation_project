import 'package:nti_graduation_project/features/home/domain/entities/category_entity.dart';

class CategoryDto {
  List<CategoryList>? categoryList;

  CategoryDto({this.categoryList});

  CategoryDto.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      categoryList = [];
      json['list'].forEach((v) {
        categoryList!.add(CategoryList.fromJson(v));
      });
    }
  }
  CategoryEntity toEntity() {
    return CategoryEntity(
      categoryList: categoryList?.map((e) => e.toEntity()).toList() ?? [],
    );
  }
}

class CategoryList {
  String? name;
  String? image;
  String? slug;

  CategoryList({this.name, this.image, this.slug});

  CategoryList.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
    slug = json['slug'];
  }
  CategoryListEntity toEntity() {
    return CategoryListEntity(
      name: name ?? '',
      image: image ?? '',
      slug: slug ?? '',
    );
  }
}
