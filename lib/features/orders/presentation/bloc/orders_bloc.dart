import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/errors/app_exception.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/order.dart';
import '../../domain/usecases/get_orders.dart';
import 'orders_event.dart';
import 'orders_state.dart';

export 'orders_event.dart';
export 'orders_state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  OrdersBloc({
    required this.getOrders,
    required this.networkInfo,
  }) : super(const OrdersInitial()) {
    on<OrdersRequested>(_onOrdersRequested);
    on<OrdersRefreshRequested>(_onOrdersRefreshRequested);
    on<OrdersConnectionChanged>(_onOrdersConnectionChanged);

    _connectionSubscription = networkInfo.onConnectionChanged.listen(
      (isConnected) => add(OrdersConnectionChanged(isConnected)),
    );
  }

  final GetOrders getOrders;
  final NetworkInfo networkInfo;
  StreamSubscription<bool>? _connectionSubscription;
  List<Order> _lastOrders = const [];
  bool _isOffline = false;

  @override
  Future<void> close() {
    _connectionSubscription?.cancel();
    return super.close();
  }

  Future<void> _onOrdersRequested(
    OrdersRequested event,
    Emitter<OrdersState> emit,
  ) async {
    emit(OrdersLoading(isOffline: _isOffline));
    await _loadOrders(emit);
  }

  Future<void> _onOrdersRefreshRequested(
    OrdersRefreshRequested event,
    Emitter<OrdersState> emit,
  ) async {
    if (_lastOrders.isNotEmpty) {
      emit(OrdersLoaded(_lastOrders, isOffline: _isOffline, isRefreshing: true));
    }
    await _loadOrders(emit);
  }

  Future<void> _onOrdersConnectionChanged(
    OrdersConnectionChanged event,
    Emitter<OrdersState> emit,
  ) async {
    final wasOffline = _isOffline;
    _isOffline = !event.isConnected;

    if (_isOffline) {
      if (_lastOrders.isNotEmpty) {
        emit(OrdersLoaded(_lastOrders, isOffline: true));
      } else {
        emit(
          const OrdersError(
            'No internet connection. Reconnect and orders will refresh automatically.',
            isOffline: true,
          ),
        );
      }
      return;
    }

    if (wasOffline) {
      if (_lastOrders.isNotEmpty) {
        emit(const OrdersLoading());
      }
      await _loadOrders(emit);
    }
  }

  Future<void> _loadOrders(Emitter<OrdersState> emit) async {
    try {
      final orders = await getOrders();
      _lastOrders = orders;
      _isOffline = false;
      emit(OrdersLoaded(orders));
    } catch (error) {
      final isNetworkError = error is NetworkException;
      _isOffline = isNetworkError || _isOffline;

      if (_lastOrders.isNotEmpty && isNetworkError) {
        emit(OrdersLoaded(_lastOrders, isOffline: true));
        return;
      }

      final message = error is AppException ? error.message : error.toString();
      emit(OrdersError(message, isOffline: _isOffline));
    }
  }
}
