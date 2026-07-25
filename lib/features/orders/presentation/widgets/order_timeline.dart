import 'package:flutter/material.dart';

import '../../domain/entities/order.dart';

class OrderTimeline extends StatefulWidget {
  const OrderTimeline({required this.status, super.key});

  final OrderStatus status;

  @override
  State<OrderTimeline> createState() => _OrderTimelineState();
}

class _OrderTimelineState extends State<OrderTimeline> {
  int _visibleStep = -1;

  @override
  void initState() {
    super.initState();
    _playTimeline();
  }

  void _playTimeline() {
    final completedCount = widget.status == OrderStatus.cancelled
        ? 2
        : widget.status.timelineIndex + 1;

    for (var i = 0; i < completedCount; i++) {
      Future<void>.delayed(Duration(milliseconds: 180 + i * 220), () {
        if (mounted) {
          setState(() => _visibleStep = i);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.status == OrderStatus.cancelled) {
      return Column(
        children: [
          TimelineStep(
            title: 'Order placed',
            subtitle: 'The order was received by the store.',
            isComplete: _visibleStep >= 0,
            isLast: false,
          ),
          TimelineStep(
            title: 'Cancelled',
            subtitle: 'The order was cancelled before fulfillment.',
            isComplete: _visibleStep >= 1,
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
            isComplete: i <= widget.status.timelineIndex && i <= _visibleStep,
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
    final textColor = isComplete ? const Color(0xFF111827) : Colors.grey;
    final subtitleColor = isComplete ? const Color(0xFF4B5563) : Colors.grey;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              AnimatedContainer(
                width: isComplete ? 26 : 24,
                height: isComplete ? 26 : 24,
                duration: const Duration(milliseconds: 260),
                curve: Curves.easeOutBack,
                decoration: BoxDecoration(
                  color: stepColor,
                  shape: BoxShape.circle,
                  boxShadow: isComplete
                      ? [
                          BoxShadow(
                            color: activeColor.withValues(alpha: 0.22),
                            blurRadius: 10,
                            spreadRadius: 1,
                          ),
                        ]
                      : null,
                ),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 180),
                  child: isComplete
                      ? const Icon(
                          Icons.check,
                          key: ValueKey('complete'),
                          color: Colors.white,
                          size: 16,
                        )
                      : const SizedBox(key: ValueKey('pending')),
                ),
              ),
              if (!isLast)
                Expanded(
                  child: AnimatedContainer(
                    width: 2,
                    duration: const Duration(milliseconds: 260),
                    curve: Curves.easeOut,
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
                  AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 220),
                    curve: Curves.easeOut,
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: textColor,
                    ),
                    child: Text(title),
                  ),
                  const SizedBox(height: 4),
                  AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 220),
                    curve: Curves.easeOut,
                    style: TextStyle(
                      color: subtitleColor,
                    ),
                    child: Text(subtitle),
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
