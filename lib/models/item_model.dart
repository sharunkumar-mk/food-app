ItemModel menuItemModelFromjson(str) {
  return ItemModel.fromJson(str);
}

class ItemModel {
  List<Item>? items;

  ItemModel({this.items});

  factory ItemModel.fromJson(List<dynamic>? json) {
    return ItemModel(
      items: json != null
          ? List<Item>.from(json.map((item) => Item.fromJson(item)))
          : null,
    );
  }
}

class Item {
  final String? itemId;
  final String? restaurantId;
  final String? name;
  final String? shortDescription;
  final String? description;
  final double? price;
  final String? imageUrl;
  final double? rating;
  final String? tag;

  Item(
      {this.itemId,
      this.restaurantId,
      this.name,
      this.shortDescription,
      this.description,
      this.price,
      this.imageUrl,
      this.rating,
      this.tag});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      itemId: json['itemId'] as String?,
      restaurantId: json['restaurantId'] as String?,
      name: json['name'] as String?,
      shortDescription: json['shortDescription'] as String?,
      description: json['description'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      rating: (json['rating'] as num?)?.toDouble(),
      imageUrl: json['imageUrl'] as String?,
      tag: json['tag'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'itemId': itemId,
      'restaurantId': restaurantId,
      'name': name,
      'shortDescription': shortDescription,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'rating': rating,
      'tag': tag,
    };
  }
}
