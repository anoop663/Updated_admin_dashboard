class BrandEditResponse {
  final int status;
  final BrandEditData data;

  BrandEditResponse({required this.status, required this.data});

  factory BrandEditResponse.fromJson(Map<String, dynamic> json) {
    return BrandEditResponse(
      status: json['status'] as int,
      data: BrandEditData.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'data': data.toJson(),
    };
  }
}

class BrandEditData {
  final int id;
  final String image;
  final String brandLogo;
  final int status;
  final String slug;
  final int isFeatured;
  final int gender;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<BrandLanguage> languages;

  BrandEditData({
    required this.id,
    required this.image,
    required this.brandLogo,
    required this.status,
    required this.slug,
    required this.isFeatured,
    required this.gender,
    required this.createdAt,
    required this.updatedAt,
    required this.languages,
  });

  factory BrandEditData.fromJson(Map<String, dynamic> json) {
    return BrandEditData(
      id: json['id'] as int,
      image: json['image'] as String,
      brandLogo: json['brand_logo'] as String,
      status: json['status'] as int,
      slug: json['slug'] as String,
      isFeatured: json['is_featured'] as int,
      gender: json['gender'] as int,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      languages: (json['languages'] as List<dynamic>)
          .map((e) => BrandLanguage.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image': image,
      'brand_logo': brandLogo,
      'status': status,
      'slug': slug,
      'is_featured': isFeatured,
      'gender': gender,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'languages': languages.map((e) => e.toJson()).toList(),
    };
  }
}

class BrandLanguage {
  final int id;
  final int manufacturerId;
  final int languageId;
  final String name;
  final String? description;
  final DateTime createdAt;
  final DateTime updatedAt;

  BrandLanguage({
    required this.id,
    required this.manufacturerId,
    required this.languageId,
    required this.name,
    this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BrandLanguage.fromJson(Map<String, dynamic> json) {
    return BrandLanguage(
      id: json['id'] as int,
      manufacturerId: json['manufacturer_id'] as int,
      languageId: json['language_id'] as int,
      name: json['name'] as String,
      description: json['description'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'manufacturer_id': manufacturerId,
      'language_id': languageId,
      'name': name,
      'description': description,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
