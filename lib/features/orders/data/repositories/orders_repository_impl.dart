import '../../../../core/errors/app_exception.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/order.dart';
import '../../domain/repositories/orders_repository.dart';
import '../datasources/orders_remote_data_source.dart';

class OrdersRepositoryImpl implements OrdersRepository {
  const OrdersRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  final OrdersRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  @override
  Future<List<Order>> getOrders() async {
    if (!await networkInfo.isConnected) {
      throw const NetworkException();
    }

    return remoteDataSource.fetchOrders();
  }
}
