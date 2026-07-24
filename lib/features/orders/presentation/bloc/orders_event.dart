sealed class OrdersEvent {
  const OrdersEvent();
}

class OrdersRequested extends OrdersEvent {
  const OrdersRequested();
}

class OrdersRefreshRequested extends OrdersEvent {
  const OrdersRefreshRequested();
}

class OrdersConnectionChanged extends OrdersEvent {
  const OrdersConnectionChanged(this.isConnected);

  final bool isConnected;
}
