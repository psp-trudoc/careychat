class ConversationMetaData {
  int id;
  String packageName;
  String packageDescription;
  String? preparation;
  String? specimen;
  String? whenToGetTested;
  String? testsIncluded;
  int labId;
  String labName;
  String? labAddress;
  double price;
  int discount;
  String currency;
  double priceAfterDiscount;
  int testCount;

  ConversationMetaData({
    required this.id,
    required this.packageName,
    required this.packageDescription,
    this.preparation,
    this.specimen,
    this.whenToGetTested,
    this.testsIncluded,
    required this.labName,
    required this.labId,
    this.labAddress,
    required this.price,
    required this.discount,
    required this.currency,
    required this.priceAfterDiscount,
    required this.testCount,
  });

  factory ConversationMetaData.fromJson(Map<String, dynamic> json) {
    return ConversationMetaData(
        id: json['id'],
        packageName: json['packageName'],
        packageDescription: json['packageName'],
        labName: json['packageName'],
        labId: json['packageName'],
        price: json['packageName'],
        discount: json['packageName'],
        currency: json['packageName'],
        priceAfterDiscount: json['packageName'],
        testCount: json['packageName']);
  }
}
