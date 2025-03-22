import 'dart:convert';

CategoryResponse categoryResponseFromJson(String str) =>
    CategoryResponse.fromJson(json.decode(str));

String categoryResponseToJson(CategoryResponse data) => json.encode(data.toJson());

class CategoryResponse {
  final int status;
  final CategoryData data;

  CategoryResponse({required this.status, required this.data});

  factory CategoryResponse.fromJson(Map<String, dynamic> json) {
    return CategoryResponse(
      status: json['status'],
      data: CategoryData.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'data': data.toJson(),
    };
  }
}

class CategoryData {
  final int currentPage;
  final List<Category> data;
  final int total;
  final int lastPage;

  CategoryData({
    required this.currentPage,
    required this.data,
    required this.total,
    required this.lastPage,
  });

  factory CategoryData.fromJson(Map<String, dynamic> json) {
    return CategoryData(
      currentPage: json['current_page'],
      data: (json['data'] as List)
          .map((item) => Category.fromJson(item))
          .toList(),
      total: json['total'],
      lastPage: json['last_page'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'current_page': currentPage,
      'data': data.map((item) => item.toJson()).toList(),
      'total': total,
      'last_page': lastPage,
    };
  }
}

class Category {
  final int id;
  final int parentId;
  final String slug;
  final String image;
  final List<Language> languages;
  final ParentCategory? parentCategory;

  Category({
    required this.id,
    required this.parentId,
    required this.slug,
    required this.image,
    required this.languages,
    this.parentCategory,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      parentId: json['parent_id'],
      slug: json['slug'],
      image: json['image'],
      languages: (json['languages'] as List)
          .map((item) => Language.fromJson(item))
          .toList(),
      parentCategory: json['parentcategory'] != null
          ? ParentCategory.fromJson(json['parentcategory'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'parent_id': parentId,
      'slug': slug,
      'image': image,
      'languages': languages.map((item) => item.toJson()).toList(),
      'parentcategory': parentCategory?.toJson(),
    };
  }
}

class Language {
  final int id;
  final int categoryId;
  final String name;

  Language({required this.id, required this.categoryId, required this.name});

  factory Language.fromJson(Map<String, dynamic> json) {
    return Language(
      id: json['id'],
      categoryId: json['category_id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category_id': categoryId,
      'name': name,
    };
  }
}

class ParentCategory {
  final int id;
  final List<Language> languages;

  ParentCategory({required this.id, required this.languages});

  factory ParentCategory.fromJson(Map<String, dynamic> json) {
    return ParentCategory(
      id: json['id'],
      languages: (json['languages'] as List)
          .map((item) => Language.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'languages': languages.map((item) => item.toJson()).toList(),
    };
  }
  
}
