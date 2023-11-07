class AddCartModelClass {
  String? cartUid;
  String? cartImageUrl;
  String? cartName;
  num? cartPrice;

  AddCartModelClass(
      {this.cartUid, this.cartImageUrl, this.cartName, this.cartPrice});

  factory AddCartModelClass.fromMap(Map<String, dynamic> map) {
    return AddCartModelClass(
      cartUid: map["cartUid"],
      cartImageUrl: map["cartImageUrl"],
      cartName: map["cartName"],
      cartPrice: map["cartPrice"],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = <String, dynamic>{};
    data["cartUid"] = cartUid;
    data["cartImageUrl"] = cartImageUrl;
    data["cartName"] = cartName;
    data["cartPrice"] = cartPrice;
    return data;
  }
}
