
import 'dart:convert';

OrderDetails orderDetailsFromJson(String str) => OrderDetails.fromJson(json.decode(str));

String orderDetailsToJson(OrderDetails data) => json.encode(data.toJson());

class OrderDetails {
  int status;
  Data data;
  List<StatusLanguage> statusLanguage;

  OrderDetails({
    required this.status,
    required this.data,
    required this.statusLanguage,
  });

  factory OrderDetails.fromJson(Map<String, dynamic> json) => OrderDetails(
    status: json["status"],
    data: Data.fromJson(json["data"]),
    statusLanguage: List<StatusLanguage>.from(json["statusLanguage"].map((x) => StatusLanguage.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data.toJson(),
    "statusLanguage": List<dynamic>.from(statusLanguage.map((x) => x.toJson())),
  };
}

class Data {
  int id;
  dynamic invoiceNumber;
  int storeId;
  dynamic storeName;
  int customerId;
  dynamic billingAddressId;
  dynamic billingAddressType;
  dynamic billingName;
  dynamic billingEmail;
  dynamic billingPhone;
  dynamic billingAddress;
  dynamic billingCity;
  dynamic billingAreaNumber;
  dynamic billingCountry;
  dynamic billingZipcode;
  dynamic billingLatitude;
  dynamic billingLongitude;
  dynamic billingLandmark;
  dynamic billingRegion;
  dynamic shippingLandmark;
  dynamic shippingRegion;
  dynamic shippingAddressId;
  dynamic shippingAddressType;
  dynamic shippingName;
  dynamic shippingEmail;
  dynamic shippingPhone;
  dynamic shippingAddress;
  dynamic shippingCity;
  dynamic shippingAreaNumber;
  dynamic shippingCountry;
  dynamic shippingZipcode;
  dynamic shippingLatitude;
  dynamic shippingLongitude;
  dynamic comments;
  dynamic deliveryNotes;
  dynamic cartId;
  dynamic totalAmount;
  dynamic couponId;
  dynamic couponCode;
  dynamic couponDiscount;
  dynamic couponDiscountType;
  dynamic discountAmount;
  dynamic swanCredit;
  dynamic walletAmount;
  dynamic shippingCharge;
  dynamic totalTaxAmount;
  double netTotalAmount;
  dynamic paymentMode;
  dynamic deliveryMode;
  dynamic pickupStoreId;
  dynamic languageId;
  dynamic currencyId;
  dynamic currencyValue;
  dynamic ip;
  dynamic userAgent;
  dynamic orderStatusId;
  dynamic orderStatus;
  dynamic paymentStatus;
  dynamic orderCancelReason;
  dynamic orderCancelDescription;
  dynamic giftWrap;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;
  dynamic orderWalletAmount;
  dynamic orderTotalAmount;
  dynamic orderNetTotalAmount;
  dynamic orderShippingCharge;
  dynamic adminOrderStatus;
  dynamic aramexshipping;
  List<dynamic> walletUsed;
  List<dynamic> walletCancelled;
  List<dynamic> walletReturned;
  List<Item> items;

  Data({
    required this.id,
    required this.invoiceNumber,
    required this.storeId,
    required this.storeName,
    required this.customerId,
    required this.billingAddressId,
    required this.billingAddressType,
    required this.billingName,
    required this.billingEmail,
    required this.billingPhone,
    required this.billingAddress,
    required this.billingCity,
    required this.billingAreaNumber,
    required this.billingCountry,
    required this.billingZipcode,
    required this.billingLatitude,
    required this.billingLongitude,
    required this.billingLandmark,
    required this.billingRegion,
    required this.shippingLandmark,
    required this.shippingRegion,
    required this.shippingAddressId,
    required this.shippingAddressType,
    required this.shippingName,
    required this.shippingEmail,
    required this.shippingPhone,
    required this.shippingAddress,
    required this.shippingCity,
    required this.shippingAreaNumber,
    required this.shippingCountry,
    required this.shippingZipcode,
    required this.shippingLatitude,
    required this.shippingLongitude,
    required this.comments,
    required this.deliveryNotes,
    required this.cartId,
    required this.totalAmount,
    required this.couponId,
    required this.couponCode,
    required this.couponDiscount,
    required this.couponDiscountType,
    required this.discountAmount,
    required this.swanCredit,
    required this.walletAmount,
    required this.shippingCharge,
    required this.totalTaxAmount,
    required this.netTotalAmount,
    required this.paymentMode,
    required this.deliveryMode,
    required this.pickupStoreId,
    required this.languageId,
    required this.currencyId,
    required this.currencyValue,
    required this.ip,
    required this.userAgent,
    required this.orderStatusId,
    required this.orderStatus,
    required this.paymentStatus,
    required this.orderCancelReason,
    required this.orderCancelDescription,
    required this.giftWrap,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.orderWalletAmount,
    required this.orderTotalAmount,
    required this.orderNetTotalAmount,
    required this.orderShippingCharge,
    required this.adminOrderStatus,
    required this.aramexshipping,
    required this.walletUsed,
    required this.walletCancelled,
    required this.walletReturned,
    required this.items,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    invoiceNumber: json["invoice_number"],
    storeId: json["store_id"],
    storeName: json["store_name"],
    customerId: json["customer_id"],
    billingAddressId: json["billing_address_id"],
    billingAddressType: json["billing_address_type"],
    billingName: json["billing_name"],
    billingEmail: json["billing_email"],
    billingPhone: json["billing_phone"],
    billingAddress: json["billing_address"],
    billingCity: json["billing_city"],
    billingAreaNumber: json["billing_area_number"],
    billingCountry: json["billing_country"],
    billingZipcode: json["billing_zipcode"],
    billingLatitude: json["billing_latitude"],
    billingLongitude: json["billing_longitude"],
    billingLandmark: json["billing_landmark"],
    billingRegion: json["billing_region"],
    shippingLandmark: json["shipping_landmark"],
    shippingRegion: json["shipping_region"],
    shippingAddressId: json["shipping_address_id"],
    shippingAddressType: json["shipping_address_type"],
    shippingName: json["shipping_name"],
    shippingEmail: json["shipping_email"],
    shippingPhone: json["shipping_phone"],
    shippingAddress: json["shipping_address"],
    shippingCity: json["shipping_city"],
    shippingAreaNumber: json["shipping_area_number"],
    shippingCountry: json["shipping_country"],
    shippingZipcode: json["shipping_zipcode"],
    shippingLatitude: json["shipping_latitude"],
    shippingLongitude: json["shipping_longitude"],
    comments: json["comments"],
    deliveryNotes: json["delivery_notes"],
    cartId: json["cart_id"],
    totalAmount: json["total_amount"],
    couponId: json["coupon_id"],
    couponCode: json["coupon_code"],
    couponDiscount: json["coupon_discount"],
    couponDiscountType: json["coupon_discount_type"],
    discountAmount: json["discount_amount"],
    swanCredit: json["swan_credit"],
    walletAmount: json["wallet_amount"],
    shippingCharge: json["shipping_charge"],
    totalTaxAmount: json["total_tax_amount"],
    netTotalAmount: json["net_total_amount"]?.toDouble(),
    paymentMode: json["payment_mode"],
    deliveryMode: json["delivery_mode"],
    pickupStoreId: json["pickup_store_id"],
    languageId: json["language_id"],
    currencyId: json["currency_id"],
    currencyValue: json["currency_value"],
    ip: json["ip"],
    userAgent: json["user_agent"],
    orderStatusId: json["order_status_id"],
    orderStatus: json["order_status"],
    paymentStatus: json["payment_status"],
    orderCancelReason: json["order_cancel_reason"],
    orderCancelDescription: json["order_cancel_description"],
    giftWrap: json["gift_wrap"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    orderWalletAmount: json["order_wallet_amount"],
    orderTotalAmount: json["order_total_amount"],
    orderNetTotalAmount: json["order_net_total_amount"],
    orderShippingCharge: json["order_shipping_charge"],
    adminOrderStatus: json["admin_order_status"],
    aramexshipping: json["aramexshipping"],
    walletUsed: List<dynamic>.from(json["wallet_used"].map((x) => x)),
    walletCancelled: List<dynamic>.from(json["wallet_cancelled"].map((x) => x)),
    walletReturned: List<dynamic>.from(json["wallet_returned"].map((x) => x)),
    items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "invoice_number": invoiceNumber,
    "store_id": storeId,
    "store_name": storeName,
    "customer_id": customerId,
    "billing_address_id": billingAddressId,
    "billing_address_type": billingAddressType,
    "billing_name": billingName,
    "billing_email": billingEmail,
    "billing_phone": billingPhone,
    "billing_address": billingAddress,
    "billing_city": billingCity,
    "billing_area_number": billingAreaNumber,
    "billing_country": billingCountry,
    "billing_zipcode": billingZipcode,
    "billing_latitude": billingLatitude,
    "billing_longitude": billingLongitude,
    "billing_landmark": billingLandmark,
    "billing_region": billingRegion,
    "shipping_landmark": shippingLandmark,
    "shipping_region": shippingRegion,
    "shipping_address_id": shippingAddressId,
    "shipping_address_type": shippingAddressType,
    "shipping_name": shippingName,
    "shipping_email": shippingEmail,
    "shipping_phone": shippingPhone,
    "shipping_address": shippingAddress,
    "shipping_city": shippingCity,
    "shipping_area_number": shippingAreaNumber,
    "shipping_country": shippingCountry,
    "shipping_zipcode": shippingZipcode,
    "shipping_latitude": shippingLatitude,
    "shipping_longitude": shippingLongitude,
    "comments": comments,
    "delivery_notes": deliveryNotes,
    "cart_id": cartId,
    "total_amount": totalAmount,
    "coupon_id": couponId,
    "coupon_code": couponCode,
    "coupon_discount": couponDiscount,
    "coupon_discount_type": couponDiscountType,
    "discount_amount": discountAmount,
    "swan_credit": swanCredit,
    "wallet_amount": walletAmount,
    "shipping_charge": shippingCharge,
    "total_tax_amount": totalTaxAmount,
    "net_total_amount": netTotalAmount,
    "payment_mode": paymentMode,
    "delivery_mode": deliveryMode,
    "pickup_store_id": pickupStoreId,
    "language_id": languageId,
    "currency_id": currencyId,
    "currency_value": currencyValue,
    "ip": ip,
    "user_agent": userAgent,
    "order_status_id": orderStatusId,
    "order_status": orderStatus,
    "payment_status": paymentStatus,
    "order_cancel_reason": orderCancelReason,
    "order_cancel_description": orderCancelDescription,
    "gift_wrap": giftWrap,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "deleted_at": deletedAt,
    "order_wallet_amount": orderWalletAmount,
    "order_total_amount": orderTotalAmount,
    "order_net_total_amount": orderNetTotalAmount,
    "order_shipping_charge": orderShippingCharge,
    "admin_order_status": adminOrderStatus,
    "aramexshipping": aramexshipping,
    "wallet_used": List<dynamic>.from(walletUsed.map((x) => x)),
    "wallet_cancelled": List<dynamic>.from(walletCancelled.map((x) => x)),
    "wallet_returned": List<dynamic>.from(walletReturned.map((x) => x)),
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
  };
}

class Item {
  int id;
  int orderId;
  dynamic sellerInvoiceReference;
  dynamic itemCgst;
  dynamic itemSgst;
  dynamic itemIgst;
  dynamic itemUtgst;
  dynamic itemCess;
  dynamic shippingCgst;
  dynamic shippingSgst;
  dynamic shippingIgst;
  dynamic shippingUtgst;
  dynamic shippingCess;
  int productId;
  int storeId;
  dynamic paidToSellerReference;
  dynamic sellerRefundAmount;
  dynamic paidAmountToAdmin;
  int paidToAdmin;
  dynamic paidToAdminDate;
  dynamic paidToAdminReference;
  dynamic productName;
  dynamic quantity;
  dynamic amount;
  dynamic taxAmount;
  dynamic couponAmount;
  dynamic itemStatus;
  dynamic shippingCharge;
  dynamic returnPeriod;
  dynamic refundPayable;
  dynamic refundPayed;
  dynamic refundBankId;
  dynamic refundBankDetails;
  dynamic itemCancelReason;
  dynamic itemCancelDescription;
  dynamic cgst;
  dynamic sgst;
  dynamic igst;
  dynamic utgst;
  dynamic cess;
  dynamic giftWrap;
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

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    id: json["id"],
    orderId: json["order_id"],
    sellerInvoiceReference: json["seller_invoice_reference"],
    itemCgst: json["item_cgst"],
    itemSgst: json["item_sgst"],
    itemIgst: json["item_igst"],
    itemUtgst: json["item_utgst"],
    itemCess: json["item_cess"],
    shippingCgst: json["shipping_cgst"],
    shippingSgst: json["shipping_sgst"],
    shippingIgst: json["shipping_igst"],
    shippingUtgst: json["shipping_utgst"],
    shippingCess: json["shipping_cess"],
    productId: json["product_id"],
    storeId: json["store_id"],
    paidToSellerReference: json["paid_to_seller_reference"],
    sellerRefundAmount: json["seller_refund_amount"],
    paidAmountToAdmin: json["paid_amount_to_admin"],
    paidToAdmin: json["paid_to_admin"],
    paidToAdminDate: json["paid_to_admin_date"],
    paidToAdminReference: json["paid_to_admin_reference"],
    productName: json["product_name"],
    quantity: json["quantity"],
    amount: json["amount"],
    taxAmount: json["tax_amount"],
    couponAmount: json["coupon_amount"],
    itemStatus: json["item_status"],
    shippingCharge: json["shipping_charge"],
    returnPeriod: json["return_period"],
    refundPayable: json["refund_payable"],
    refundPayed: json["refund_payed"],
    refundBankId: json["refund_bank_id"],
    refundBankDetails: json["refund_bank_details"],
    itemCancelReason: json["item_cancel_reason"],
    itemCancelDescription: json["item_cancel_description"],
    cgst: json["cgst"],
    sgst: json["sgst"],
    igst: json["igst"],
    utgst: json["utgst"],
    cess: json["cess"],
    giftWrap: json["gift_wrap"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    product: Product.fromJson(json["product"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "order_id": orderId,
    "seller_invoice_reference": sellerInvoiceReference,
    "item_cgst": itemCgst,
    "item_sgst": itemSgst,
    "item_igst": itemIgst,
    "item_utgst": itemUtgst,
    "item_cess": itemCess,
    "shipping_cgst": shippingCgst,
    "shipping_sgst": shippingSgst,
    "shipping_igst": shippingIgst,
    "shipping_utgst": shippingUtgst,
    "shipping_cess": shippingCess,
    "product_id": productId,
    "store_id": storeId,
    "paid_to_seller_reference": paidToSellerReference,
    "seller_refund_amount": sellerRefundAmount,
    "paid_amount_to_admin": paidAmountToAdmin,
    "paid_to_admin": paidToAdmin,
    "paid_to_admin_date": paidToAdminDate,
    "paid_to_admin_reference": paidToAdminReference,
    "product_name": productName,
    "quantity": quantity,
    "amount": amount,
    "tax_amount": taxAmount,
    "coupon_amount": couponAmount,
    "item_status": itemStatus,
    "shipping_charge": shippingCharge,
    "return_period": returnPeriod,
    "refund_payable": refundPayable,
    "refund_payed": refundPayed,
    "refund_bank_id": refundBankId,
    "refund_bank_details": refundBankDetails,
    "item_cancel_reason": itemCancelReason,
    "item_cancel_description": itemCancelDescription,
    "cgst": cgst,
    "sgst": sgst,
    "igst": igst,
    "utgst": utgst,
    "cess": cess,
    "gift_wrap": giftWrap,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "product": product.toJson(),
  };
}

class Product {
  int id;
  dynamic code;
  int userId;
  dynamic status;
  int parentId;
  dynamic isShowInList;
  dynamic manufacturerId;
  dynamic taxClassId;
  dynamic slug;
  dynamic isFeatured;
  dynamic isPuliAssured;
  dynamic weight;
  dynamic sizeChart;
  dynamic orderNumber;
  dynamic rewardPoint;
  dynamic purchaseReward;
  dynamic metaTitle;
  dynamic metaDescription;
  dynamic metaKeywords;
  dynamic cgst;
  dynamic sgst;
  dynamic igst;
  dynamic utgst;
  dynamic cess;
  dynamic isAlisonsAssured;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;
  dynamic isLatest;
  dynamic isPopular;
  dynamic isTrending;
  dynamic isFlashsale;
  dynamic variantProductId;
  dynamic productVariant;
  dynamic isGender;
  dynamic homeImg;
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

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    code: json["code"],
    userId: json["user_id"],
    status: json["status"],
    parentId: json["parent_id"],
    isShowInList: json["is_show_in_list"],
    manufacturerId: json["manufacturer_id"],
    taxClassId: json["tax_class_id"],
    slug: json["slug"],
    isFeatured: json["is_featured"],
    isPuliAssured: json["is_puli_assured"],
    weight: json["weight"],
    sizeChart: json["size_chart"],
    orderNumber: json["order_number"],
    rewardPoint: json["reward_point"],
    purchaseReward: json["purchase_reward"],
    metaTitle: json["meta_title"],
    metaDescription: json["meta_description"],
    metaKeywords: json["meta_keywords"],
    cgst: json["cgst"],
    sgst: json["sgst"],
    igst: json["igst"],
    utgst: json["utgst"],
    cess: json["cess"],
    isAlisonsAssured: json["is_alisons_assured"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    isLatest: json["is_latest"],
    isPopular: json["is_popular"],
    isTrending: json["is_trending"],
    isFlashsale: json["is_flashsale"],
    variantProductId: json["variant_product_id"],
    productVariant: json["product_variant"],
    isGender: json["is_gender"],
    homeImg: json["home_img"],
    thisOptions: List<ThisOption>.from(json["this_options"].map((x) => ThisOption.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "code": code,
    "user_id": userId,
    "status": status,
    "parent_id": parentId,
    "is_show_in_list": isShowInList,
    "manufacturer_id": manufacturerId,
    "tax_class_id": taxClassId,
    "slug": slug,
    "is_featured": isFeatured,
    "is_puli_assured": isPuliAssured,
    "weight": weight,
    "size_chart": sizeChart,
    "order_number": orderNumber,
    "reward_point": rewardPoint,
    "purchase_reward": purchaseReward,
    "meta_title": metaTitle,
    "meta_description": metaDescription,
    "meta_keywords": metaKeywords,
    "cgst": cgst,
    "sgst": sgst,
    "igst": igst,
    "utgst": utgst,
    "cess": cess,
    "is_alisons_assured": isAlisonsAssured,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "deleted_at": deletedAt,
    "is_latest": isLatest,
    "is_popular": isPopular,
    "is_trending": isTrending,
    "is_flashsale": isFlashsale,
    "variant_product_id": variantProductId,
    "product_variant": productVariant,
    "is_gender": isGender,
    "home_img": homeImg,
    "this_options": List<dynamic>.from(thisOptions.map((x) => x.toJson())),
  };
}

class ThisOption {
  int optionId;
  String name;
  int productId;
  int id;
  dynamic type;
  ThisValues thisValues;

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
    thisValues: ThisValues.fromJson(json["this_values"]),
  );

  Map<String, dynamic> toJson() => {
    "option_id": optionId,
    "name": name,
    "product_id": productId,
    "id": id,
    "type": type,
    "this_values": thisValues.toJson(),
  };
}

class ThisValues {
  int optionValueId;
  dynamic value;
  dynamic text;
  dynamic slug;
  int productOptionId;

  ThisValues({
    required this.optionValueId,
    required this.value,
    required this.text,
    required this.slug,
    required this.productOptionId,
  });

  factory ThisValues.fromJson(Map<String, dynamic> json) => ThisValues(
    optionValueId: json["option_value_id"],
    value: json["value"],
    text: json["text"],
    slug: json["slug"],
    productOptionId: json["product_option_id"],
  );

  Map<String, dynamic> toJson() => {
    "option_value_id": optionValueId,
    "value": value,
    "text": text,
    "slug": slug,
    "product_option_id": productOptionId,
  };
}

class StatusLanguage {
  int statusId;
  dynamic statusText;

  StatusLanguage({
    required this.statusId,
    required this.statusText,
  });

  factory StatusLanguage.fromJson(Map<String, dynamic> json) => StatusLanguage(
    statusId: json["status_id"],
    statusText: json["status_text"],
  );

  Map<String, dynamic> toJson() => {
    "status_id": statusId,
    "status_text": statusText,
  };
}
