class OrderResponse {
  int? status;
  Data? data;
  Meta? meta;
  String? name;
  int? founded;
  List<String>? members;

  OrderResponse({
    this.status,
    this.data,
    this.meta,
    this.name,
    this.founded,
    this.members,
  });

  factory OrderResponse.fromJson(Map<String, dynamic> json) => OrderResponse(
        status: json['status'],
        data: json['data'] != null ? Data.fromJson(json['data']) : null,
     //   meta: json['meta'] != null ? Meta.fromJson(json['meta']) : null,
        name: json['name'],
        founded: json['founded'],
        members: List<String>.from(json['members'] ?? []),
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'data': data?.toJson(),
     //   'meta': meta?.toJson(),
        'name': name,
        'founded': founded,
        'members': members,
      };
}

class Data {
  int currentPage;
  List<Orders> data1;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  List<Link> links;
  dynamic nextPageUrl;
  String path;
  int perPage;
  dynamic prevPageUrl;
  int to;
  int total;

  Data({
    required this.currentPage,
    required this.data1,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    required this.links,
    required this.nextPageUrl,
    required this.path,
    required this.perPage,
    required this.prevPageUrl,
    required this.to,
    required this.total,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        currentPage: json['current_page'],
        data1: (json['data'] as List).map((e) => Orders.fromJson(e)).toList(),
        firstPageUrl: json['first_page_url'],
        from: json['from'],
        lastPage: json['last_page'],
        lastPageUrl: json['last_page_url'],
     //   links: (json['links'] as List).map((e) => Link.fromJson(e)).toList(),
        nextPageUrl: json['next_page_url'],
        path: json['path'],
        perPage: json['per_page'],
        prevPageUrl: json['prev_page_url'],
        to: json['to'],
        total: json['total'], links: [],
      );

  Map<String, dynamic> toJson() => {
        'current_page': currentPage,
        'data': data1.map((e) => e.toJson()).toList(),
        'first_page_url': firstPageUrl,
        'from': from,
        'last_page': lastPage,
        'last_page_url': lastPageUrl,
     //   'links': links.map((e) => e.toJson()).toList(),
        'next_page_url': nextPageUrl,
        'path': path,
        'per_page': perPage,
        'prev_page_url': prevPageUrl,
        'to': to,
        'total': total,
      };
}

class Orders {
  int id;
  String invoiceNumber;
  String billingName;
  String billingEmail;
  String billingPhone;
  double netTotalAmount;
  String orderStatus;
  String orderWalletAmount;
  String orderTotalAmount;
  String orderNetTotalAmount;
  String orderShippingCharge;
  String adminOrderStatus;
  dynamic aramexshipping;
  List<Item> items;
  List<dynamic> walletUsed;
  List<dynamic> walletCancelled;
  List<dynamic> walletReturned;

  Orders({
    required this.id,
    required this.invoiceNumber,
    required this.billingName,
    required this.billingEmail,
    required this.billingPhone,
    required this.netTotalAmount,
    required this.orderStatus,
    required this.orderWalletAmount,
    required this.orderTotalAmount,
    required this.orderNetTotalAmount,
    required this.orderShippingCharge,
    required this.adminOrderStatus,
    required this.aramexshipping,
    required this.items,
    required this.walletUsed,
    required this.walletCancelled,
    required this.walletReturned,
  });

  factory Orders.fromJson(Map<String, dynamic> json) => Orders(
        id: json['id'],
        invoiceNumber: json['invoice_number'],
        billingName: json['billing_name'],
        billingEmail: json['billing_email'],
        billingPhone: json['billing_phone'],
        netTotalAmount: json['net_total_amount'].toDouble(),
        orderStatus: json['order_status'],
        orderWalletAmount: json['order_wallet_amount'],
        orderTotalAmount: json['order_total_amount'],
        orderNetTotalAmount: json['order_net_total_amount'],
        orderShippingCharge: json['order_shipping_charge'],
        adminOrderStatus: json['admin_order_status'],
        aramexshipping: json['aramexshipping'],
     //   items: (json['items'] as List).map((e) => Item.fromJson(e)).toList(),
        walletUsed: json['wallet_used'] ?? [],
        walletCancelled: json['wallet_cancelled'] ?? [],
        walletReturned: json['wallet_returned'] ?? [], items: [],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'invoice_number': invoiceNumber,
        'billing_name': billingName,
        'billing_email': billingEmail,
        'billing_phone': billingPhone,
        'net_total_amount': netTotalAmount,
        'order_status': orderStatus,
        'order_wallet_amount': orderWalletAmount,
        'order_total_amount': orderTotalAmount,
        'order_net_total_amount': orderNetTotalAmount,
        'order_shipping_charge': orderShippingCharge,
        'admin_order_status': adminOrderStatus,
        'aramexshipping': aramexshipping,
       // 'items': items.map((e) => e.toJson()).toList(),
        'wallet_used': walletUsed,
        'wallet_cancelled': walletCancelled,
        'wallet_returned': walletReturned,
      };
}



class Item {
    int id;
    int orderId;
    String sellerInvoiceReference;
    String itemCgst;
    String itemSgst;
    String itemIgst;
    String itemUtgst;
    String itemCess;
    String shippingCgst;
    String shippingSgst;
    String shippingIgst;
    String shippingUtgst;
    String shippingCess;
    int productId;
    int storeId;
    dynamic paidToSellerReference;
    String sellerRefundAmount;
    String paidAmountToAdmin;
    int paidToAdmin;
    dynamic paidToAdminDate;
    dynamic paidToAdminReference;
    String productName;
    String quantity;
    String amount;
    String taxAmount;
    dynamic couponAmount;
    int itemStatus;
    String shippingCharge;
    int returnPeriod;
    String refundPayable;
    String refundPayed;
    dynamic refundBankId;
    dynamic refundBankDetails;
    String? itemCancelReason;
    dynamic itemCancelDescription;
    String cgst;
    String sgst;
    String igst;
    String utgst;
    String cess;
    int giftWrap;
    DateTime createdAt;
    DateTime updatedAt;
    Product product;

    Item({
        required this.id,
        required this.orderId,
        required this.sellerInvoiceReference,
        required this.itemCgst,
        required this.itemSgst,
        required this.itemIgst,
        required this.itemUtgst,
        required this.itemCess,
        required this.shippingCgst,
        required this.shippingSgst,
        required this.shippingIgst,
        required this.shippingUtgst,
        required this.shippingCess,
        required this.productId,
        required this.storeId,
        required this.paidToSellerReference,
        required this.sellerRefundAmount,
        required this.paidAmountToAdmin,
        required this.paidToAdmin,
        required this.paidToAdminDate,
        required this.paidToAdminReference,
        required this.productName,
        required this.quantity,
        required this.amount,
        required this.taxAmount,
        required this.couponAmount,
        required this.itemStatus,
        required this.shippingCharge,
        required this.returnPeriod,
        required this.refundPayable,
        required this.refundPayed,
        required this.refundBankId,
        required this.refundBankDetails,
        required this.itemCancelReason,
        required this.itemCancelDescription,
        required this.cgst,
        required this.sgst,
        required this.igst,
        required this.utgst,
        required this.cess,
        required this.giftWrap,
        required this.createdAt,
        required this.updatedAt,
        required this.product,
    });

}

class Product {
    int id;
    String code;
    int userId;
    int status;
    int parentId;
    int isShowInList;
    int manufacturerId;
    int taxClassId;
    String slug;
    int isFeatured;
    int isPuliAssured;
    String weight;
    String sizeChart;
    int orderNumber;
    String rewardPoint;
    String purchaseReward;
    MetaTitle? metaTitle;
    MetaDescription? metaDescription;
    dynamic metaKeywords;
    String cgst;
    String sgst;
    String igst;
    String utgst;
    String cess;
    int isAlisonsAssured;
    DateTime createdAt;
    DateTime updatedAt;
    dynamic deletedAt;
    int isLatest;
    int isPopular;
    int isTrending;
    int isFlashsale;
    int variantProductId;
    int? productVariant;
    dynamic isGender;
    String homeImg;
    List<ThisOption> thisOptions;

    Product({
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
        required this.metaTitle,
        required this.metaDescription,
        required this.metaKeywords,
        required this.cgst,
        required this.sgst,
        required this.igst,
        required this.utgst,
        required this.cess,
        required this.isAlisonsAssured,
        required this.createdAt,
        required this.updatedAt,
        required this.deletedAt,
        required this.isLatest,
        required this.isPopular,
        required this.isTrending,
        required this.isFlashsale,
        required this.variantProductId,
        required this.productVariant,
        required this.isGender,
        required this.homeImg,
        required this.thisOptions,
    });

}

enum MetaDescription {
    // ignore: constant_identifier_names
    SEO_DESCRIPTION
}

enum MetaTitle {
    // ignore: constant_identifier_names
    SEO_TITLE
}

class ThisOption {
    int optionId;
    Name name;
    int productId;
    int id;
    Type type;
    ThisValues thisValues;

    ThisOption({
        required this.optionId,
        required this.name,
        required this.productId,
        required this.id,
        required this.type,
        required this.thisValues,
    });

}

enum Name {
    // ignore: constant_identifier_names
    COLOR,
    // ignore: constant_identifier_names
    SIZE
}

class ThisValues {
    int optionValueId;
    String value;
    String text;
    String slug;
    int productOptionId;

    ThisValues({
        required this.optionValueId,
        required this.value,
        required this.text,
        required this.slug,
        required this.productOptionId,
    });

}

enum Type {
    // ignore: constant_identifier_names
    TEXT
}

class Link {
    String? url;
    String label;
    bool active;

    Link({
        required this.url,
        required this.label,
        required this.active,
    });

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

}

class Album {
    String name;
    ArtistClass artist;
    List<Track> tracks;

    Album({
        required this.name,
        required this.artist,
        required this.tracks,
    });

}

class ArtistClass {
    String name;
    int founded;
    List<String> members;

    ArtistClass({
        required this.name,
        required this.founded,
        required this.members,
    });

}

class Track {
    String name;
    int duration;

    Track({
        required this.name,
        required this.duration,
    });

}
