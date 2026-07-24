import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/network/network_info.dart';
import '../features/orders/domain/usecases/get_orders.dart';
import '../features/orders/presentation/bloc/orders_bloc.dart';
import '../features/orders/presentation/pages/orders_list_screen.dart';

class OrderTrackerApp extends StatelessWidget {
  const OrderTrackerApp({
    required this.getOrders,
    required this.networkInfo,
    super.key,
  });

  final GetOrders getOrders;
  final NetworkInfo networkInfo;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: getOrders,
      child: BlocProvider(
        create: (_) => OrdersBloc(
          getOrders: getOrders,
          networkInfo: networkInfo,
        )..add(OrdersRequested()),
        child: MaterialApp(
          title: 'Order Tracker',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF0F766E),
            ),
            scaffoldBackgroundColor: const Color(0xFFF7F8FA),
            useMaterial3: true,
          ),
          home: const OrdersListScreen(),
        ),
      ),
    );
  }
}
