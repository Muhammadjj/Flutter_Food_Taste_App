class FavoriteIconModelClass {
  String? favoriteID;
  String? favoriteImageUrl;
  String? favoriteName;
  num? favoritePrice;

  FavoriteIconModelClass(
      {this.favoriteID,
      this.favoriteImageUrl,
      this.favoriteName,
      this.favoritePrice});

  factory FavoriteIconModelClass.fromJson(Map<String, dynamic> map) {
    return FavoriteIconModelClass(
      favoriteID: map["favoriteID"],
      favoriteImageUrl: map["favoriteImageUrl"],
      favoriteName: map["favoriteName"],
      favoritePrice: map["favoritePrice"],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = <String, dynamic>{};
    data["favoriteID"] = favoriteID;
    data["favoriteImageUrl"] = favoriteImageUrl;
    data["favoriteName"] = favoriteName;
    data["favoritePrice"] = favoritePrice;
    return data;
  }
}
