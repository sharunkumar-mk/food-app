import 'package:cloud_firestore/cloud_firestore.dart';

OrderModel orderModelFromjson(str) {
  return OrderModel.fromJson(str);
}

class OrderModel {
  List<Order>? orders;

  OrderModel({this.orders});

  factory OrderModel.fromJson(List<dynamic>? json) {
    return OrderModel(
      orders: json != null
          ? List<Order>.from(json.map((order) => Order.fromJson(order)))
          : null,
    );
  }
}

class Order {
  final String orderId;
  final String userId;
  final String deliveryAddress;
  final double totalPrice;
  final String restaurantId;
  final Timestamp timestamp;
  final List<OrderItem> items;
  final String status;
  final GeoPoint location;

  Order(
      {required this.orderId,
      required this.userId,
      required this.deliveryAddress,
      required this.totalPrice,
      required this.restaurantId,
      required this.timestamp,
      required this.items,
      required this.status,
      required this.location});

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      orderId: json['orderId'],
      userId: json['userId'],
      deliveryAddress: json['deliveryAddress'],
      totalPrice: json['totalPrice'].toDouble(),
      restaurantId: json['restaurantId'],
      timestamp: json['timestamp'],
      status: json['status'],
      location: json['location'],
      items: (json['items'] as List<dynamic>)
          .map((item) => OrderItem.fromJson(item))
          .toList(),
    );
  }
}

class OrderItem {
  final String itemId;
  final int quantity;
  final String itemImage;
  final String itemName;
  final double itemPrice;

  OrderItem(
      {required this.itemId,
      required this.quantity,
      required this.itemName,
      required this.itemImage,
      required this.itemPrice});

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      itemId: json['itemId'],
      quantity: json['quantity'],
      itemName: json['itemName'],
      itemImage: json['itemImage'],
      itemPrice: json['itemPrice'],
    );
  }
}
