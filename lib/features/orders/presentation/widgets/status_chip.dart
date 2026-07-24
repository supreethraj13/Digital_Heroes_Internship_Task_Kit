import 'package:flutter/material.dart';

import '../../domain/entities/order.dart';

class StatusChip extends StatelessWidget {
  const StatusChip({required this.status, super.key});

  final OrderStatus status;

  @override
  Widget build(BuildContext context) {
    final color = _statusColor(status);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        status.label,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

Color _statusColor(OrderStatus status) {
  switch (status) {
    case OrderStatus.processing:
      return const Color(0xFFB45309);
    case OrderStatus.packed:
      return const Color(0xFF2563EB);
    case OrderStatus.shipped:
      return const Color(0xFF7C3AED);
    case OrderStatus.delivered:
      return const Color(0xFF15803D);
    case OrderStatus.cancelled:
      return const Color(0xFFB91C1C);
  }
}
