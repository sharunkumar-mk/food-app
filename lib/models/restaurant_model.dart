RestaurantModel restaurantModelFromJson(str) {
  return RestaurantModel.fromJson(str);
}

class RestaurantModel {
  List<Restaurant>? restaurants;

  RestaurantModel({this.restaurants});

  factory RestaurantModel.fromJson(List<dynamic>? json) {
    return RestaurantModel(
      restaurants: json != null
          ? List<Restaurant>.from(json.map((item) => Restaurant.fromJson(item)))
          : null,
    );
  }
}

class Restaurant {
  final String? phone;
  final String? restaurantId;
  final String? cuisine;
  final String? name;
  final String? address;

  Restaurant({
    this.phone,
    this.restaurantId,
    this.cuisine,
    this.name,
    this.address,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      phone: json['phone'],
      restaurantId: json['restaurantId'],
      cuisine: json['cuisine'],
      name: json['name'],
      address: json['address'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'phone': phone,
      'restaurantId': restaurantId,
      'cuisine': cuisine,
      'name': name,
      'address': address,
    };
  }
}
