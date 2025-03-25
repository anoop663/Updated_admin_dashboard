
class BrandListModel {
  int? page;

  BrandListModel({
    this.page,
  });

  Map<String, dynamic> toJson() {
    return {
      'page': page,

    };
  }
}
