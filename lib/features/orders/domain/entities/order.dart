class Order {
  const Order({
    required this.id,
    required this.customer,
    required this.items,
    required this.amount,
    required this.status,
    required this.placedAt,
  });

  final String id;
  final String customer;
  final List<String> items;
  final double amount;
  final OrderStatus status;
  final DateTime placedAt;
}

enum OrderStatus {
  processing,
  packed,
  shipped,
  delivered,
  cancelled,
}

OrderStatus parseOrderStatus(String value) {
  return OrderStatus.values.firstWhere(
    (status) => status.label.toLowerCase() == value.toLowerCase(),
    orElse: () => OrderStatus.processing,
  );
}

extension OrderStatusX on OrderStatus {
  String get label {
    switch (this) {
      case OrderStatus.processing:
        return 'Processing';
      case OrderStatus.packed:
        return 'Packed';
      case OrderStatus.shipped:
        return 'Shipped';
      case OrderStatus.delivered:
        return 'Delivered';
      case OrderStatus.cancelled:
        return 'Cancelled';
    }
  }

  int get timelineIndex {
    switch (this) {
      case OrderStatus.processing:
        return 0;
      case OrderStatus.packed:
        return 1;
      case OrderStatus.shipped:
        return 2;
      case OrderStatus.delivered:
        return 3;
      case OrderStatus.cancelled:
        return -1;
    }
  }
}
