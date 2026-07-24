import '../../domain/entities/order.dart';

sealed class OrdersState {
  const OrdersState();
}

class OrdersInitial extends OrdersState {
  const OrdersInitial();
}

class OrdersLoading extends OrdersState {
  const OrdersLoading({this.isOffline = false});

  final bool isOffline;
}

class OrdersLoaded extends OrdersState {
  const OrdersLoaded(
    this.orders, {
    this.isOffline = false,
    this.isRefreshing = false,
  });

  final List<Order> orders;
  final bool isOffline;
  final bool isRefreshing;
}

class OrdersError extends OrdersState {
  const OrdersError(
    this.message, {
    this.isOffline = false,
  });

  final String message;
  final bool isOffline;
}
