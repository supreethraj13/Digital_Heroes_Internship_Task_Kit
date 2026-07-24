import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'app/app.dart';
import 'core/constants/api_constants.dart';
import 'core/network/network_info.dart';
import 'features/orders/data/datasources/orders_remote_data_source.dart';
import 'features/orders/data/repositories/orders_repository_impl.dart';
import 'features/orders/domain/usecases/get_orders.dart';

void main() {
  final networkInfo = NetworkInfoImpl();
  final remoteDataSource = OrdersRemoteDataSourceImpl(
    client: http.Client(),
    apiUrl: ordersApiUrl,
  );
  final repository = OrdersRepositoryImpl(
    remoteDataSource: remoteDataSource,
    networkInfo: networkInfo,
  );
  final getOrders = GetOrders(repository);

  runApp(
    OrderTrackerApp(
      getOrders: getOrders,
      networkInfo: networkInfo,
    ),
  );
}
