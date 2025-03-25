// To parse this JSON data, do
//
//     final productResponse = productResponseFromJson(jsonString);

import 'dart:convert';

ProductResponse productResponseFromJson(String str) => ProductResponse.fromJson(json.decode(str));

String productResponseToJson(ProductResponse data) => json.encode(data.toJson());

class ProductResponse {
  int status;
  List<Datum> data;
  Meta meta;

  ProductResponse({
    required this.status,
    required this.data,
    required this.meta,
  });

  factory ProductResponse.fromJson(Map<String, dynamic> json) => ProductResponse(
    status: json["status"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    meta: Meta.fromJson(json["meta"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "meta": meta.toJson(),
  };
}

class Datum {
  int id;
  String name;
  int status;
  String slug;
  SellerName sellerName;
  String stock;
  String currentPrice;
  String price;
  String code;
  String image;
  String catName;
  int userId;
  List<ThisOption> thisOptions;

  Datum({
    required this.id,
    required this.name,
    required this.status,
    required this.slug,
    required this.sellerName,
    required this.stock,
    required this.currentPrice,
    required this.price,
    required this.code,
    required this.image,
    required this.catName,
    required this.userId,
    required this.thisOptions,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
    status: json["status"],
    slug: json["slug"],
    sellerName: sellerNameValues.map[json["seller_name"]]!,
    stock: json["stock"],
    currentPrice: json["current_price"],
    price: json["price"],
    code: json["code"],
    image: json["image"],
    catName: json["cat_name"],
    userId: json["user_id"],
    thisOptions: List<ThisOption>.from(json["this_options"].map((x) => ThisOption.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "status": status,
    "slug": slug,
    "seller_name": sellerNameValues.reverse[sellerName],
    "stock": stock,
    "current_price": currentPrice,
    "price": price,
    "code": code,
    "image": image,
    "cat_name": catName,
    "user_id": userId,
    "this_options": List<dynamic>.from(thisOptions.map((x) => x.toJson())),
  };
}

enum SellerName {
  SWAN
}

final sellerNameValues = EnumValues({
  "Swan": SellerName.SWAN
});

class ThisOption {
  int optionId;
  String name;
  int productId;
  int id;
  String type;
  ThisValues? thisValues;

  ThisOption({
    required this.optionId,
    required this.name,
    required this.productId,
    required this.id,
    required this.type,
    required this.thisValues,
  });

  factory ThisOption.fromJson(Map<String, dynamic> json) => ThisOption(
    optionId: json["option_id"],
    name: json["name"],
    productId: json["product_id"],
    id: json["id"],
    type: json["type"],
    thisValues: json["this_values"] == null ? null : ThisValues.fromJson(json["this_values"]),
  );

  Map<String, dynamic> toJson() => {
    "option_id": optionId,
    "name": name,
    "product_id": productId,
    "id": id,
    "type": type,
    "this_values": thisValues?.toJson(),
  };
}

class ThisValues {
  int optionValueId;
  String value;
  String text;
  String slug;
  int productOptionId;
  int productId;

  ThisValues({
    required this.optionValueId,
    required this.value,
    required this.text,
    required this.slug,
    required this.productOptionId,
    required this.productId,
  });

  factory ThisValues.fromJson(Map<String, dynamic> json) => ThisValues(
    optionValueId: json["option_value_id"],
    value: json["value"],
    text: json["text"],
    slug: json["slug"],
    productOptionId: json["product_option_id"],
    productId: json["product_id"],
  );

  Map<String, dynamic> toJson() => {
    "option_value_id": optionValueId,
    "value": value,
    "text": text,
    "slug": slug,
    "product_option_id": productOptionId,
    "product_id": productId,
  };
}

class Meta {
  int total;
  int currentPage;
  int lastPage;
  int perPage;

  Meta({
    required this.total,
    required this.currentPage,
    required this.lastPage,
    required this.perPage,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    total: json["total"],
    currentPage: json["current_page"],
    lastPage: json["last_page"],
    perPage: json["per_page"],
  );

  Map<String, dynamic> toJson() => {
    "total": total,
    "current_page": currentPage,
    "last_page": lastPage,
    "per_page": perPage,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
