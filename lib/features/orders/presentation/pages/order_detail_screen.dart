import 'package:flutter/material.dart';

import '../../../../core/utils/formatters.dart';
import '../../domain/entities/order.dart';
import '../widgets/info_panel.dart';
import '../widgets/order_timeline.dart';
import '../widgets/status_chip.dart';

class OrderDetailScreen extends StatelessWidget {
  const OrderDetailScreen({required this.order, super.key});

  final Order order;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(order.id)),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            order.customer,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              StatusChip(status: order.status),
              const SizedBox(width: 10),
              Text(formatDate(order.placedAt)),
            ],
          ),
          const SizedBox(height: 24),
          InfoPanel(
            title: 'Order summary',
            rows: [
              InfoPanelRow(label: 'Items', value: order.items.join(', ')),
              InfoPanelRow(
                label: 'Amount',
                value: formatCurrency(order.amount),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            'Status timeline',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: 16),
          OrderTimeline(status: order.status),
        ],
      ),
    );
  }
}
