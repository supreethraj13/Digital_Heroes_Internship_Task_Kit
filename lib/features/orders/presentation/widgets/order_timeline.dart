import 'package:flutter/material.dart';

import '../../domain/entities/order.dart';

class OrderTimeline extends StatelessWidget {
  const OrderTimeline({required this.status, super.key});

  final OrderStatus status;

  @override
  Widget build(BuildContext context) {
    if (status == OrderStatus.cancelled) {
      return const Column(
        children: [
          TimelineStep(
            title: 'Order placed',
            subtitle: 'The order was received by the store.',
            isComplete: true,
            isLast: false,
          ),
          TimelineStep(
            title: 'Cancelled',
            subtitle: 'The order was cancelled before fulfillment.',
            isComplete: true,
            isLast: true,
            color: Color(0xFFB91C1C),
          ),
        ],
      );
    }

    const steps = [
      ('Processing', 'The order is being reviewed and prepared.'),
      ('Packed', 'Items are packed and ready for dispatch.'),
      ('Shipped', 'The package is on its way to the customer.'),
      ('Delivered', 'The order has reached the customer.'),
    ];

    return Column(
      children: [
        for (var i = 0; i < steps.length; i++)
          TimelineStep(
            title: steps[i].$1,
            subtitle: steps[i].$2,
            isComplete: i <= status.timelineIndex,
            isLast: i == steps.length - 1,
          ),
      ],
    );
  }
}

class TimelineStep extends StatelessWidget {
  const TimelineStep({
    required this.title,
    required this.subtitle,
    required this.isComplete,
    required this.isLast,
    this.color,
    super.key,
  });

  final String title;
  final String subtitle;
  final bool isComplete;
  final bool isLast;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final activeColor = color ?? Theme.of(context).colorScheme.primary;
    final stepColor = isComplete ? activeColor : const Color(0xFFCBD5E1);

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: stepColor,
                  shape: BoxShape.circle,
                ),
                child: isComplete
                    ? const Icon(Icons.check, color: Colors.white, size: 16)
                    : null,
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: stepColor.withValues(alpha: 0.55),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: isComplete ? const Color(0xFF111827) : Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: isComplete ? const Color(0xFF4B5563) : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
