import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/order_model.dart';

abstract class OrdersRemoteDataSource {
  Future<List<OrderModel>> fetchOrders();
}

class OrdersRemoteDataSourceImpl implements OrdersRemoteDataSource {
  const OrdersRemoteDataSourceImpl({
    required this.client,
    required this.apiUrl,
  });

  final http.Client client;
  final String apiUrl;

  @override
  Future<List<OrderModel>> fetchOrders() async {
    final response = await client.get(Uri.parse(apiUrl));

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception('Could not load orders (${response.statusCode}).');
    }

    final decoded = jsonDecode(response.body);
    if (decoded is! List<dynamic>) {
      throw const FormatException('The orders API must return a JSON array.');
    }

    return decoded
        .map((json) => OrderModel.fromJson(json as Map<String, dynamic>))
        .toList()
      ..sort((a, b) => b.placedAt.compareTo(a.placedAt));
  }
}
