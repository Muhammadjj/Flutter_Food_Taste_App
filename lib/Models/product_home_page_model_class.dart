class ProductHomePageModelClass {
  String? imageUrl;
  String? name;
  num? price;
  String? popularPremiumStar;

  ProductHomePageModelClass(
      {this.imageUrl, this.name, this.price, this.popularPremiumStar});

  factory ProductHomePageModelClass.fromJson(Map<String, dynamic> map) {
    return ProductHomePageModelClass(
      imageUrl: map["imageUrl"],
      name: map["name"],
      price: map["price"],
      popularPremiumStar: map["popularPremiumStar"],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = <String, dynamic>{};
    data["imageUrl"] = imageUrl;
    data["name"] = name;
    data["price"] = price;
    data["popularPremiumStar"] = popularPremiumStar;
    return data;
  }
}
