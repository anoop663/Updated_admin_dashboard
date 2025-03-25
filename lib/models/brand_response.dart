import 'dart:convert';

BrandResponse brandResponseFromJson(String str) =>
    BrandResponse.fromJson(json.decode(str));

String brandResponseToJson(BrandResponse data) => json.encode(data.toJson());

class BrandResponse {
  int? status;
  Data? data;
  Meta? meta;

  BrandResponse({this.status, this.data, this.meta});

  // From JSON
  factory BrandResponse.fromJson(Map<String, dynamic> json) {
    return BrandResponse(
      status: json['status'],
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
      meta: json['meta'] != null ? Meta.fromJson(json['meta']) : null,
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'data': data?.toJson(),
      'meta': meta?.toJson(),
    };
  }
}

class Data {
  int? currentPage;
  List<Brand>? brands;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Link>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  Data({
    this.currentPage,
    this.brands,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  // From JSON
  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      currentPage: json['current_page'],
      brands: (json['data'] as List<dynamic>?)
          ?.map((e) => Brand.fromJson(e))
          .toList(),
      firstPageUrl: json['first_page_url'],
      from: json['from'],
      lastPage: json['last_page'],
      lastPageUrl: json['last_page_url'],
      links: (json['links'] as List<dynamic>?)
          ?.map((e) => Link.fromJson(e))
          .toList(),
      nextPageUrl: json['next_page_url'],
      path: json['path'],
      perPage: json['per_page'],
      prevPageUrl: json['prev_page_url'],
      to: json['to'],
      total: json['total'],
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'current_page': currentPage,
      'data': brands?.map((e) => e.toJson()).toList(),
      'first_page_url': firstPageUrl,
      'from': from,
      'last_page': lastPage,
      'last_page_url': lastPageUrl,
      'links': links?.map((e) => e.toJson()).toList(),
      'next_page_url': nextPageUrl,
      'path': path,
      'per_page': perPage,
      'prev_page_url': prevPageUrl,
      'to': to,
      'total': total,
    };
  }
}

class Brand {
  int? id;
  String? slug;
  String? image;
  List<Language>? languages;

  Brand({this.id, this.slug, this.image, this.languages});

  // From JSON
  factory Brand.fromJson(Map<String, dynamic> json) {
    return Brand(
      id: json['id'],
      slug: json['slug'],
      image: json['image'],
      languages: (json['languages'] as List<dynamic>?)
          ?.map((e) => Language.fromJson(e))
          .toList(),
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'slug': slug,
      'image': image,
      'languages': languages?.map((e) => e.toJson()).toList(),
    };
  }
}

class Language {
  int? id;
  int? manufacturerId;
  String? name;

  Language({this.id, this.manufacturerId, this.name});

  // From JSON
  factory Language.fromJson(Map<String, dynamic> json) {
    return Language(
      id: json['id'],
      manufacturerId: json['manufacturer_id'],
      name: json['name'],
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'manufacturer_id': manufacturerId,
      'name': name,
    };
  }
}

class Link {
  String? url;
  String? label;
  bool? active;

  Link({this.url, this.label, this.active});

  // From JSON
  factory Link.fromJson(Map<String, dynamic> json) {
    return Link(
      url: json['url'],
      label: json['label'],
      active: json['active'],
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'label': label,
      'active': active,
    };
  }
}

class Meta {
  int? total;
  int? currentPage;
  int? lastPage;
  int? perPage;

  Meta({this.total, this.currentPage, this.lastPage, this.perPage});

  // From JSON
  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      total: json['total'],
      currentPage: json['current_page'],
      lastPage: json['last_page'],
      perPage: json['per_page'],
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'total': total,
      'current_page': currentPage,
      'last_page': lastPage,
      'per_page': perPage,
    };
  }
}
