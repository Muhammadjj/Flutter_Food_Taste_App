class OrderNowModelClass {
  String? orderUid;
  String? orderTextFieldCustomerName;
  String? orderTextFieldPhoneNo;
  String? orderTextFieldAddress;
  String? orderTextFieldPostCode;
  // Constructor .
  OrderNowModelClass({
    this.orderUid,
    this.orderTextFieldCustomerName,
    this.orderTextFieldPhoneNo,
    this.orderTextFieldAddress,
    this.orderTextFieldPostCode,
  });

  // From Map .
  factory OrderNowModelClass.fromMap(Map<String, dynamic> map) {
    return OrderNowModelClass(
        orderUid: map["orderUid"],
        orderTextFieldCustomerName: map["orderTextFieldCustomerName"],
        orderTextFieldPhoneNo: map["orderTextFieldPhoneNo"],
        orderTextFieldAddress: map["orderTextFieldAddress"],
        orderTextFieldPostCode: map["orderTextFieldPostCode"]);
  }

  // To Map .

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['orderUid'] = orderUid;
    map["orderTextFieldCustomerName"] = orderTextFieldCustomerName;
    map["orderTextFieldPhoneNo"] = orderTextFieldPhoneNo;
    map["orderTextFieldAddress"] = orderTextFieldAddress;
    map["orderTextFieldPostCode"] = orderTextFieldPostCode;
    return map;
  }
}
