import 'dart:convert';

ProductEditResponse productResponseFromJson(String str) =>
    ProductEditResponse.fromJson(json.decode(str));

// Encode JSON
String productResponseToJson(ProductEditResponse data) =>
    json.encode(data.toJson());

class ProductEditResponse {
  final int success;
  final ProductData? data;
  List<Image>? images;
  ProductEditResponse({
    required this.success,
    this.data,
    this.images,
  });

  factory ProductEditResponse.fromJson(Map<String, dynamic> json) {
    return ProductEditResponse(
      success: json['success'],
      data: json['data'] != null ? ProductData.fromJson(json['data']) : null,
      images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data?.toJson(),
    };
  }
}

class Image {
  String image;
  int id;
  int isDefault;

  Image({
    required this.image,
    required this.id,
    required this.isDefault,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
    image: json["image"],
    id: json["id"],
    isDefault: json["is_default"],
  );

  Map<String, dynamic> toJson() => {
    "image": image,
    "id": id,
    "is_default": isDefault,
  };
}

class ProductData {
  final int id;
  final String code;
  final int userId;
  final int status;
  final int parentId;
  final int isShowInList;
  final int manufacturerId;
  final int taxClassId;
  final String slug;
  final int isFeatured;
  final int isPuliAssured;
  final String weight;
  final String sizeChart;
  final int orderNumber;
  final String rewardPoint;
  final String purchaseReward;
  final String? metaTitle;
  final String? metaDescription;
  final String? metaKeywords;
  final String cgst;
  final String sgst;
  final String igst;
  final String utgst;
  final String cess;
  final int isAlisonsAssured;
  final String createdAt;
  final String updatedAt;
  final String? deletedAt;
  final int isLatest;
  final int isPopular;
  final int isTrending;
  final int isFlashsale;
  final int variantProductId;
  final dynamic productVariant;
  final int isGender;
  final dynamic homeImg;
  final List<StoreData> stores;
  final List<LanguageData> languages;
  final List<CategoryDataEdit> categories;

  ProductData({
    required this.id,
    required this.code,
    required this.userId,
    required this.status,
    required this.parentId,
    required this.isShowInList,
    required this.manufacturerId,
    required this.taxClassId,
    required this.slug,
    required this.isFeatured,
    required this.isPuliAssured,
    required this.weight,
    required this.sizeChart,
    required this.orderNumber,
    required this.rewardPoint,
    required this.purchaseReward,
    this.metaTitle,
    this.metaDescription,
    this.metaKeywords,
    required this.cgst,
    required this.sgst,
    required this.igst,
    required this.utgst,
    required this.cess,
    required this.isAlisonsAssured,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.isLatest,
    required this.isPopular,
    required this.isTrending,
    required this.isFlashsale,
    required this.variantProductId,
    this.productVariant,
    required this.isGender,
    this.homeImg,
    required this.stores,
    required this.languages,
    required this.categories,
  });

  factory ProductData.fromJson(Map<String, dynamic> json) {
    return ProductData(
      id: json['id'],
      code: json['code'],
      userId: json['user_id'],
      status: json['status'],
      parentId: json['parent_id'],
      isShowInList: json['is_show_in_list'],
      manufacturerId: json['manufacturer_id'],
      taxClassId: json['tax_class_id'],
      slug: json['slug'],
      isFeatured: json['is_featured'],
      isPuliAssured: json['is_puli_assured'],
      weight: json['weight'],
      sizeChart: json['size_chart'],
      orderNumber: json['order_number'],
      rewardPoint: json['reward_point'],
      purchaseReward: json['purchase_reward'],
      metaTitle: json['meta_title'],
      metaDescription: json['meta_description'],
      metaKeywords: json['meta_keywords'],
      cgst: json['cgst'],
      sgst: json['sgst'],
      igst: json['igst'],
      utgst: json['utgst'],
      cess: json['cess'],
      isAlisonsAssured: json['is_alisons_assured'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      deletedAt: json['deleted_at'],
      isLatest: json['is_latest'],
      isPopular: json['is_popular'],
      isTrending: json['is_trending'],
      isFlashsale: json['is_flashsale'],
      variantProductId: json['variant_product_id'],
      productVariant: json['product_variant'],
      isGender: json['is_gender'],
      homeImg: json['home_img'],
      stores: (json['stores'] as List).map((e) => StoreData.fromJson(e)).toList(),
      languages:
          (json['languages'] as List).map((e) => LanguageData.fromJson(e)).toList(),
      categories: (json['categories'] as List)
          .map((e) => CategoryDataEdit.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'user_id': userId,
      'status': status,
      'parent_id': parentId,
      'is_show_in_list': isShowInList,
      'manufacturer_id': manufacturerId,
      'tax_class_id': taxClassId,
      'slug': slug,
      'is_featured': isFeatured,
      'is_puli_assured': isPuliAssured,
      'weight': weight,
      'size_chart': sizeChart,
      'order_number': orderNumber,
      'reward_point': rewardPoint,
      'purchase_reward': purchaseReward,
      'meta_title': metaTitle,
      'meta_description': metaDescription,
      'meta_keywords': metaKeywords,
      'cgst': cgst,
      'sgst': sgst,
      'igst': igst,
      'utgst': utgst,
      'cess': cess,
      'is_alisons_assured': isAlisonsAssured,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'deleted_at': deletedAt,
      'is_latest': isLatest,
      'is_popular': isPopular,
      'is_trending': isTrending,
      'is_flashsale': isFlashsale,
      'variant_product_id': variantProductId,
      'product_variant': productVariant,
      'is_gender': isGender,
      'home_img': homeImg,
      'stores': stores.map((e) => e.toJson()).toList(),
      'languages': languages.map((e) => e.toJson()).toList(),
      'categories': categories.map((e) => e.toJson()).toList(),
    };
  }
}

class StoreData {
  final int id;
  final int productId;
  final int storeId;
  final String defaultPrice;
  final String stock;
  final String minQuantity;
  final String maxQuantity;
  final String currentPrice;
  final String cost;
  final int returnPeriod;
  final int status;
  final String commission;
  final int stockAlertQuantity;
  final String createdAt;
  final String updatedAt;
  final String name;

  StoreData({
    required this.id,
    required this.productId,
    required this.storeId,
    required this.defaultPrice,
    required this.stock,
    required this.minQuantity,
    required this.maxQuantity,
    required this.currentPrice,
    required this.cost,
    required this.returnPeriod,
    required this.status,
    required this.commission,
    required this.stockAlertQuantity,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
  });

  factory StoreData.fromJson(Map<String, dynamic> json) {
    return StoreData(
      id: json['id'],
      productId: json['product_id'],
      storeId: json['store_id'],
      defaultPrice: json['default_price'],
      stock: json['stock'],
      minQuantity: json['min_quantity'],
      maxQuantity: json['max_quantity'],
      currentPrice: json['current_price'],
      cost: json['cost'],
      returnPeriod: json['return_period'],
      status: json['status'],
      commission: json['commission'],
      stockAlertQuantity: json['stock_alert_quantity'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product_id': productId,
      'store_id': storeId,
      'default_price': defaultPrice,
      'stock': stock,
      'min_quantity': minQuantity,
      'max_quantity': maxQuantity,
      'current_price': currentPrice,
      'cost': cost,
      'return_period': returnPeriod,
      'status': status,
      'commission': commission,
      'stock_alert_quantity': stockAlertQuantity,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'name': name,
    };
  }
}

class LanguageData {
  final int id;
  final int productId;
  final int languageId;
  final String name;
  final String description;
  final String appDescription;
  final dynamic tags;
  final String createdAt;
  final String updatedAt;

  LanguageData({
    required this.id,
    required this.productId,
    required this.languageId,
    required this.name,
    required this.description,
    required this.appDescription,
    this.tags,
    required this.createdAt,
    required this.updatedAt,
  });

  factory LanguageData.fromJson(Map<String, dynamic> json) {
    return LanguageData(
      id: json['id'],
      productId: json['product_id'],
      languageId: json['language_id'],
      name: json['name'],
      description: json['description'],
      appDescription: json['app_description'],
      tags: json['tags'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product_id': productId,
      'language_id': languageId,
      'name': name,
      'description': description,
      'app_description': appDescription,
      'tags': tags,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}

class CategoryDataEdit {
  final int id;
  final int productId;
  final int categoryId;
  final String createdAt;
  final String updatedAt;

  CategoryDataEdit({
    required this.id,
    required this.productId,
    required this.categoryId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CategoryDataEdit.fromJson(Map<String, dynamic> json) {
    return CategoryDataEdit(
      id: json['id'],
      productId: json['product_id'],
      categoryId: json['category_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product_id': productId,
      'category_id': categoryId,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
