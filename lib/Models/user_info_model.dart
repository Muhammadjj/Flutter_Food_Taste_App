class UserInfoModel {
  String? userID;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  // Constructor
  UserInfoModel(
      {this.userID, this.firstName, this.lastName, this.email, this.phone});
  factory UserInfoModel.fromJson(Map<String, dynamic> map) {
    return UserInfoModel(
      userID: map["userID"],
      firstName: map["firstName"],
      lastName: map["lastName"],
      email: map["email"],
      phone: map["phone"],
    );
  }
  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = <String, dynamic>{};
    data["userID"] = userID;
    data["firstName"] = firstName;
    data["lastName"] = lastName;
    data["email"] = email;
    data["phone"] = phone;
    return data;
  }
}
