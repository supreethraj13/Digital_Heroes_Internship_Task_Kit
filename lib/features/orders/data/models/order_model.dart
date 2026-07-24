import '../../domain/entities/order.dart';

class OrderModel extends Order {
  const OrderModel({
    required super.id,
    required super.customer,
    required super.items,
    required super.amount,
    required super.status,
    required super.placedAt,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'] as String,
      customer: json['customer'] as String,
      items: List<String>.from(json['items'] as List<dynamic>),
      amount: (json['amount'] as num).toDouble(),
      status: parseOrderStatus(json['status'] as String),
      placedAt: DateTime.parse(json['placed_at'] as String).toLocal(),
    );
  }
}
