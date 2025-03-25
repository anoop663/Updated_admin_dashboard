import 'dart:io';

class BrandCreateModel {
  String? name;
  String? discriptions;
  String? status;
  String? seourl;
  String? isfeatured;
  File? image;
  File? brandlogo;

  BrandCreateModel({
    this.name,
    this.discriptions,
    this.status,
    this.seourl,
    this.brandlogo,
    this.image,
    this.isfeatured
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'discrptions': discriptions,
      'status': status,
      'seo_url': seourl,
      'is_featured': isfeatured,
      'image': image,
      'brand_log': brandlogo
    };
  }
}
