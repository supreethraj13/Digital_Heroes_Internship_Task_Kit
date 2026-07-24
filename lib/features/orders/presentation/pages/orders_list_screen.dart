import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/orders_bloc.dart';
import '../widgets/animated_order_list_item.dart';
import '../widgets/empty_state.dart';
import '../widgets/error_state.dart';
import '../widgets/loading_state.dart';
import '../widgets/offline_banner.dart';
import '../widgets/order_card.dart';

class OrdersListScreen extends StatelessWidget {
  const OrdersListScreen({super.key});

  Future<void> _refresh(BuildContext context) async {
    final bloc = context.read<OrdersBloc>()..add(const OrdersRefreshRequested());
    await bloc.stream.firstWhere(
      (state) {
        return state is OrdersError ||
            state is OrdersLoaded && !state.isRefreshing;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
        centerTitle: false,
      ),
      body: BlocBuilder<OrdersBloc, OrdersState>(
        builder: (context, state) {
          if (state is OrdersLoading || state is OrdersInitial) {
            return LoadingState(isOffline: state is OrdersLoading && state.isOffline);
          }

          if (state is OrdersError) {
            return ErrorState(
              title: state.isOffline ? 'You are offline' : 'Could not load orders',
              message: state.message,
              isOffline: state.isOffline,
              onRetry: () {
                context.read<OrdersBloc>().add(const OrdersRequested());
              },
            );
          }

          if (state is OrdersLoaded && state.orders.isEmpty) {
            return RefreshIndicator(
              onRefresh: () => _refresh(context),
              child: const EmptyState(),
            );
          }

          final orders = (state as OrdersLoaded).orders;
          return RefreshIndicator(
            onRefresh: () => _refresh(context),
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                if (state.isOffline)
                  const SliverToBoxAdapter(
                    child: OfflineBanner(),
                  ),
                if (state.isRefreshing)
                  const SliverToBoxAdapter(
                    child: LinearProgressIndicator(minHeight: 2),
                  ),
                SliverPadding(
                  padding: const EdgeInsets.all(16),
                  sliver: SliverList.separated(
                    itemBuilder: (context, index) {
                      return AnimatedOrderListItem(
                        index: index,
                        child: OrderCard(order: orders[index]),
                      );
                    },
                    separatorBuilder: (_, _) => const SizedBox(height: 12),
                    itemCount: orders.length,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
