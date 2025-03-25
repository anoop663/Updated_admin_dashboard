class CategoryEditResponse {
  final int status;
  final CategoryEditData data;

  CategoryEditResponse({
    required this.status,
    required this.data,
  });

  factory CategoryEditResponse.fromJson(Map<String, dynamic> json) {
    return CategoryEditResponse(
      status: json['status'],
      data: CategoryEditData.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'data': data.toJson(),
    };
  }
}

class CategoryEditData {
  final int id;
  final int parentId;
  final int orderNumber;
  final String? image;
  final int status;
  final String slug;
  final int inbuiltCategoryId;
  final int isPuliExpress;
  final int isPuliAssured;
  final int isAlisonsAssured;
  final int isAlisonsExpress;
  final int isVisibleInHome;
  final int isTryAndBuyAvailable;
  final String? metaTitle;
  final String? metaDescription;
  final String? metaKeywords;
  final String? image2;
  final String? image3;
  final String? image4;
  final String? image5;
  final String createdAt;
  final String updatedAt;
  final List<Language> languages;

  CategoryEditData({
    required this.id,
    required this.parentId,
    required this.orderNumber,
    required this.image,
    required this.status,
    required this.slug,
    required this.inbuiltCategoryId,
    required this.isPuliExpress,
    required this.isPuliAssured,
    required this.isAlisonsAssured,
    required this.isAlisonsExpress,
    required this.isVisibleInHome,
    required this.isTryAndBuyAvailable,
    this.metaTitle,
    this.metaDescription,
    this.metaKeywords,
    this.image2,
    this.image3,
    this.image4,
    this.image5,
    required this.createdAt,
    required this.updatedAt,
    required this.languages,
  });

  factory CategoryEditData.fromJson(Map<String, dynamic> json) {
    return CategoryEditData(
      id: json['id'],
      parentId: json['parent_id'],
      orderNumber: json['order_number'],
      image: json['image'],
      status: json['status'],
      slug: json['slug'],
      inbuiltCategoryId: json['inbuilt_category_id'],
      isPuliExpress: json['is_puli_express'],
      isPuliAssured: json['is_puli_assured'],
      isAlisonsAssured: json['is_alisons_assured'],
      isAlisonsExpress: json['is_alisons_express'],
      isVisibleInHome: json['is_visible_in_home'],
      isTryAndBuyAvailable: json['is_try_and_buy_available'],
      metaTitle: json['meta_title'],
      metaDescription: json['meta_description'],
      metaKeywords: json['meta_keywords'],
      image2: json['image2'],
      image3: json['image3'],
      image4: json['image4'],
      image5: json['image5'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      languages: (json['languages'] as List)
          .map((lang) => Language.fromJson(lang))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'parent_id': parentId,
      'order_number': orderNumber,
      'image': image,
      'status': status,
      'slug': slug,
      'inbuilt_category_id': inbuiltCategoryId,
      'is_puli_express': isPuliExpress,
      'is_puli_assured': isPuliAssured,
      'is_alisons_assured': isAlisonsAssured,
      'is_alisons_express': isAlisonsExpress,
      'is_visible_in_home': isVisibleInHome,
      'is_try_and_buy_available': isTryAndBuyAvailable,
      'meta_title': metaTitle,
      'meta_description': metaDescription,
      'meta_keywords': metaKeywords,
      'image2': image2,
      'image3': image3,
      'image4': image4,
      'image5': image5,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'languages': languages.map((lang) => lang.toJson()).toList(),
    };
  }
}

class Language {
  final int id;
  final int categoryId;
  final int languageId;
  final String name;
  final String description;
  final String createdAt;
  final String updatedAt;

  Language({
    required this.id,
    required this.categoryId,
    required this.languageId,
    required this.name,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Language.fromJson(Map<String, dynamic> json) {
    return Language(
      id: json['id'],
      categoryId: json['category_id'],
      languageId: json['language_id'],
      name: json['name'],
      description: json['description'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category_id': categoryId,
      'language_id': languageId,
      'name': name,
      'description': description,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
