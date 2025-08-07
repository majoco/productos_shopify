class Product {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final String price;
  final String handle;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.handle,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    final variant = json['variants']['edges'][0]['node'];
    final image = json['images']['edges'].isNotEmpty
        ? json['images']['edges'][0]['node']['url']
        : '';

    return Product(
      id: json['id'],
      title: json['title'],
      description: json['description'] ?? '',
      imageUrl: image,
      price: variant['price']['amount'],
      handle: json['handle'],
    );
  }
}
