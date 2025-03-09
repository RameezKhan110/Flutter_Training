class ProductModel {
  final String productImage;
  final String productName;

  const ProductModel({
    required this.productImage,
    required this.productName
  });


  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      productImage: json['productImage'] ?? '',
      productName: json['productName'] ?? '',
    );
  }
}
